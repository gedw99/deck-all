# DOES THEM all in one hit...
# this can run as a CI makefile on github workflows. we just need the outputs to go to out own S3. 
# then nats can deploy them in real time as they are asked for by a pipleine !!
#- nats just pulls them off S3 and paces them in the call path. like a proxy Faas

BIN_FSPATH=$(PWD)/.bin

export PATH:=$(BIN_FSPATH)/darwin-amd64:$(PATH)
print:

all: git build dist

### git

batch-git:
	cd desksh && $(MAKE) git-upstream-clone
	cd deck && $(MAKE) git-upstream-clone
	cd deckfonts && $(MAKE) git-upstream-clone
	cd deckviz && $(MAKE) git-upstream-clone
	cd giocanvas && $(MAKE) git-upstream-clone
	
batch-git-del:
	cd desksh && $(MAKE) git-upstream-clone-del
	cd deck && $(MAKE) git-upstream-clone-del
	cd deckfonts && $(MAKE) git-upstream-clone-del
	cd deckviz && $(MAKE) git-upstream-clone-del
	cd giocanvas && $(MAKE) git-upstream-clone-del
	
	
### Build

# Pick one !!
CMD_BUILD=go-build
#CMD_BUILD=go-build

batch-build:
	mkdir -p $(BIN_FSPATH)
	# do it alphabetically and all platform
	cd decksh && $(MAKE) build-go
	cd deck && $(MAKE) build-go
	cd giocanvas && $(MAKE) build-gio
batch-build-all:
	cd decksh && $(MAKE) build-go-all
	cd deck && $(MAKE) build-go-all
	cd giocanvas && $(MAKE) build-gio-all
batch-build-clean:
	cd decksh && $(MAKE) build-clean
	cd deck && $(MAKE) build-clean
	cd giocanvas && $(MAKE) build-clean

### DIST

batch-dist-print:
	tree  $(BIN_FSPATH)

batch-dist:
	mkdir -p $(BIN_FSPATH)
	cp -r decksh/decksh__ajstarks/cmd/decksh/.bin/gobuild/* $(BIN_FSPATH)

	cp -r deck/deck__ajstarks/cmd/deckd/.bin/gobuild/* $(BIN_FSPATH)
	cp -r deck/deck__ajstarks/cmd/deckinfo/.bin/gobuild/* $(BIN_FSPATH)
	cp -r deck/deck__ajstarks/cmd/deckweb/.bin/gobuild/* $(BIN_FSPATH)
	cp -r deck/deck__ajstarks/cmd/deckweb/.bin/gobuild/* $(BIN_FSPATH)
	#cp -r deck/deck__ajstarks/cmd/fcdeck/.bin/gobuild/* $(BIN_FSPATH)
	#cp -r deck/deck__ajstarks/cmd/gcdeck/.bin/gobuild/* $(BIN_FSPATH)
	cp -r deck/deck__ajstarks/cmd/pdfdeck/.bin/gobuild/* $(BIN_FSPATH)
	cp -r deck/deck__ajstarks/cmd/pngdeck/.bin/gobuild/* $(BIN_FSPATH)
	cp -r deck/deck__ajstarks/cmd/svgdeck/.bin/gobuild/* $(BIN_FSPATH)
	
	cp -r giocanvas/giocanvas__ajstarks/gcdeck/.bin/giobuild/* $(BIN_FSPATH)

batch-dist-del:
	rm -rf $(BIN_FSPATH)

### RELEASE

DIST_FSPATH=$(PWD)/.release

batch-release-trans:
	# transform into flat folders. github only allow files not folders.

batch-release:
	go install github.com/tcnksm/ghr@v0.16.0

	
	ghr v0.4.0 .bin/windows_arm64/
batch-release-del:
	ghr -delete v0.1.0
	




deckd-run:
	# -listen Address:port (default: localhost:1958)
	# -dir working directory (default: ".")
	deckd -listen localhost:8080 -dir $(PWD)
	# http://localhost:8080/

	# https://github.com/ajstarks/deck/tree/master/cmd/deckd


decksh-run:
	decksh -h
gcdeck-start:
	gcdeck -h