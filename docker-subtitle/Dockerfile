FROM gencore/whisper-speech-to-text:20230314

# For our processing script to work, we need require that the 
# FFMPEG version has support for fonts built into the binary
RUN ffmpeg -version 2>&1 | grep -q 'libfontconfig' || exit 1

ADD entrypoint.sh /opt/

ENTRYPOINT ["/bin/bash", "/opt/entrypoint.sh"]