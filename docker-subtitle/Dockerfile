FROM continuumio/anaconda3@sha256:2936bbcc87821528d9741fa09351c17fb5ff78b1a33e024c09f05e8c59826521

# Install a fixed version of OpenAI's Whisper
RUN pip install -U openai-whisper==20230314

# Whisper depends on FFMPEG being present.
RUN apt-get update && apt-get install -y ffmpeg

# Exercise the program as part of build to pre-cache dependencies
WORKDIR /tmp
COPY counting.mp3 /tmp/counting.mp3

# 'small' appears to offer a reasonable balance of performance
# versus download size. 7m20s audio converted accurately in 19m20s
RUN whisper counting.mp3 --model small --language English

RUN mkdir /audio
WORKDIR /audio

# For our processing script to work, we need require that the 
# FFMPEG version has support for fonts built into the binary
RUN ffmpeg -version 2>&1 | grep -q 'libfontconfig' || exit 1

ADD entrypoint.sh /opt/

ENTRYPOINT ["/bin/bash", "/opt/entrypoint.sh"]