project=gencore/whisper-speech-to-text
git= $(shell git rev-parse --short HEAD)
pip-version = 20230314
#pip-version = 20230918
#pip-version = 20231117

all: build

.PHONY: build

build: buildBase buildTranscribe buildSubtitle

buildBase:
	@echo "Building Base Image"
	docker build docker-base \
		--tag $(project):$(pip-version) \
		--tag $(project):$(git) \
		--tag $(project):latest

buildTranscribe: 
	@echo "Building Transcribing Image"
	docker build docker-transcribe \
		--tag $(project)-transcribe:$(pip-version) \
		--tag $(project)-transcribe:$(git) \
		--tag $(project)-transcribe:latest

buildSubtitle: 
	@echo "Building Subtitling Image"
	docker build docker-subtitle \
		--tag $(project)-subtitle:$(pip-version) \
		--tag $(project)-subtitle:$(git) \
		--tag $(project)-subtitle:latest

publish:
	@echo "Pushing to DockerHub"
	@sh utils/docker-login
	docker push $(project):$(pip-version)
	docker push $(project):$(git)
	docker push $(project):latest
	
	docker push $(project)-transcribe:$(pip-version)
	docker push $(project)-transcribe:$(git)
	docker push $(project)-transcribe:latest

	docker push $(project)-subtitle:$(pip-version)
	docker push $(project)-subtitle:$(git)
	docker push $(project)-subtitle:latest