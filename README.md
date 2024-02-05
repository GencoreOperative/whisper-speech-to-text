# Overview

A Docker project designed to enable command line access to [OpenAI's Whisper](https://openai.com/research/whisper) library. ([paper](https://cdn.openai.com/papers/whisper.pdf))

Whisper is a neural network that has been trained to achieve human levels of robustness and accuracy on English speech recognition. Any-to-English translation is supported as well.

## Project Details

This project makes use of the [OpenAI Python](https://pypi.org/project/openai-whisper) binding for their Whisper API. Credit goes to [linuxlinks](https://www.linuxlinks.com/machine-learning-linux-whisper-automatic-speech-recognition-system) for the write up that explains how to install all of this.

the `whisper` utility supports both transcribe and translate features.

# Run

```
curl https://raw.githubusercontent.com/GencoreOperative/whisper-speech-to-text/master/toTxt
```

To run the project, you can use the provided script with any media file.

```
toTxt recording.mp3
```

# Build

Build the project using the provided Makefile. This will need to download around 11GB of dependencies.

```
make build
```



in the form of an MP3 file. Therefore, this project also includes FFMPEG to enable the user to provide input in audio and video formats.

TODO - Input

TODO - Output

# Limitations

> However, because the models are trained in a weakly supervised manner using large-scale noisy data, the predictions may include texts that are not actually spoken in the audio input (i.e. hallucination). We hypothesize that this happens because, given their general knowledge of language, the models combine trying to predict the next word in audio with trying to transcribe the audio itself.






https://github.com/openai/whisper/blob/main/model-card.md
Model card details the limitiations which we should copy.

There is a related [Python API](https://pypi.org/project/openai-whisper/20230314/) available using this project as well.




It will output the following:

# Detail


docker run -v "$PWD:/audio" --rm -ti gencore/whisper-speech-to-text:latest counting.mp3

# Use Case: Add Subtitles

docker run -v "$PWD:/audio" --rm -ti gencore/whisper-speech-to-text:latest video.mp3; ffmpeg -i video.mp4 -i video.srt -c copy -c:s mov_text -metadata:s:s:0 language=eng video-subtitle.mp4

# License

OpenAI have licensed their code and model under [MIT](https://github.com/openai/whisper/blob/main/LICENSE). Similarly, this project is licensed under the same MIT license.