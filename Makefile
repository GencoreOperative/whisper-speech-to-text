project=gencore/whisper-speech-to-text
#git= $(shell git rev-parse --short HEAD)
git = test

PHONEY = build

build: 
	@echo "Building Docker image"
	docker build . \
		--tag $(project):$(git) \
		--tag $(project):latest