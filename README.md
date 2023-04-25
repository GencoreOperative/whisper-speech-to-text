Whisper Audio to Text model.

Based on the article here: https://www.linuxlinks.com/machine-learning-linux-whisper-automatic-speech-recognition-system/

Python library here: https://pypi.org/project/openai-whisper/20230314/

Introduction: https://openai.com/research/whisper

Research Paper: https://cdn.openai.com/papers/whisper.pdf

Amazing transcription capability and also has translation.

docker build . -t gencore/whisper-speech-to-text:latest

docker run -v "$PWD:/audio" --rm -ti gencore/whisper-speech-to-text:latest counting.mp3