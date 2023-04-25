# Overview

A Docker project designed to enable command line access to [OpenAI's Whisper](https://openai.com/research/whisper) library. Whisper is a neural network that has been trained to achieve human levels of robustness and accuracy on English speech recognition.

Any-to-English translation is supported as well.


Based on the article here: https://www.linuxlinks.com/machine-learning-linux-whisper-automatic-speech-recognition-system/

Python library here: https://pypi.org/project/openai-whisper/20230314/

Introduction: https://openai.com/research/whisper

Research Paper: https://cdn.openai.com/papers/whisper.pdf

https://github.com/openai/whisper

Licensed under MIT
Whisper's code and model weights are released under the MIT License. See LICENSE for further details.


https://github.com/openai/whisper/blob/main/model-card.md
Model card details the limitiations which we should copy.

# Build

Build the project using the provided Makefile. This will need to download around 11GB of dependencies.

```
make build
```

# Run

To run the project, you can use the provided script with any media file.

```
toTxt recording.mp3
```

It will output the following:

# Detail


docker run -v "$PWD:/audio" --rm -ti gencore/whisper-speech-to-text:latest counting.mp3