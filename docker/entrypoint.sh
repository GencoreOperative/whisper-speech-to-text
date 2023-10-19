# If the provided input file does not end in .mp3
# convert it to an mp3 using 
# ffmpeg -i <input> -ar 44100 -filter:a dynaudnorm <input>.mp3