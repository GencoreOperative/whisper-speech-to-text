#!/bin/bash

set -e

SOURCE="$1"
EXTENSION=$(echo "$SOURCE" | rev | cut -d'.' -f1 | tr '[:upper:]' '[:lower:]' | rev)
TARGET=$(echo "$SOURCE" | rev | cut -d'.' -f2 | rev)-subtitle.mp4
MODE=$2

# -----------------------------------------------
# Extract the audio from the video so Whisper can
# listen to it.
# -----------------------------------------------
# Even if the source is an MP3 file, we need to create
# to ensure that the AUDIO is a fixed name. This helps
# the downstream stages of processing.

AUDIO=/tmp/audio.mp3
ffmpeg -i "$SOURCE" \
	-ar 44100 \
	-filter:a dynaudnorm \
	$AUDIO

# -----------------------------------------------
# Run the audio through Whisper for transcription
# -----------------------------------------------
# This will generate the multiple output files including the subtitle file.
# Note: https://github.com/openai/whisper/discussions/301 provided the tip on FP16 mode
cd /audio && /opt/conda/bin/whisper \
	--fp16 False \
	--model small \
	--language English \
	--output_format all \
	$AUDIO

# If the source was a Video file, convert into the target MP4 file 
# with the subtitle track included. If the mode flag was set, then
# instead, bake the subtitles into the video stream.
VIDEO_EXTENSIONS=("mp4" "avi" "mkv" "mov" "wmv" "flv" "webm" "m4v" "mpg" "mpeg" "3gp")

for VIDEO_EXTENSION in "${VIDEO_EXTENSIONS[@]}"; do
    if [ "$EXTENSION" == "$VIDEO_EXTENSION" ]; then
    	
		# If the caller provides the 'bake-in flag' then we need
		# to remove the instruction to add a new subtitle track
		# and instead let FFMPEG back the subtitles into the video
		# stream.

		if [ ! -z "$MODE" ]; then
			ffmpeg -i $SOURCE \
				-y \
				-vf subtitles=audio.srt \
	    		-c:v libx264 \
				-profile:v high \
				-crf 22 \
				-strict experimental \
				-c:a aac \
				-q:a 6 \
				-filter:a dynaudnorm \
				-c:s mov_text \
	    		$TARGET			
		else
			# https://superuser.com/questions/700082/is-there-an-option-in-ffmpeg-to-specify-a-subtitle-track-that-should-be-shown-by
			# Provided detail on the subtitle commands
			ffmpeg -i $SOURCE \
				-y \
				-i audio.srt \
				-c:v copy \
				-c:a copy \
				-c:s mov_text \
    			-metadata:s:s:0 language=eng \
    			-disposition:s:0 default \
    			$TARGET
		fi

        break
    fi
done

rm audio.json
rm audio.tsv
rm audio.vtt