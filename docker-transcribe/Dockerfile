FROM gencore/whisper-speech-to-text:20230314

ENTRYPOINT ["/opt/conda/bin/whisper", "--fp16 False", "--model", "small", "--language", "English", "--output_format", "txt"]