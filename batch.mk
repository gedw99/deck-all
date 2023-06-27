# DOES THEM all in one hit...
# this can run as a CI makefile on github workflows. we just need the outputs to go to out own S3. 
# then nats can deploy them in real time as they are asked for by a pipleine !!
#- nats just pulls them off S3 and places them in the call path. like a proxy Faas...

BATCH_BIN_FSPATH=$(PWD)/.bin

batch-print:
	@echo ""
	@echo "BATCH_BIN_FSPATH:     $(BATCH_BIN_FSPATH)"

	$(MAKE) batch-bin-print



batch-all: batch-git batch-build-all batch-bin



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
	
	
### BUILD


batch-build:
	mkdir -p $(BATCH_BIN_FSPATH)
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

batch-bin-print:
	tree  $(BATCH_BIN_FSPATH)

batch-bin:
	mkdir -p $(BATCH_BIN_FSPATH)
	cp -r decksh/decksh__ajstarks/cmd/decksh/.bin/gobuild/* $(BATCH_BIN_FSPATH)

	cp -r deck/deck__ajstarks/cmd/deckd/.bin/gobuild/* $(BATCH_BIN_FSPATH)
	cp -r deck/deck__ajstarks/cmd/deckinfo/.bin/gobuild/* $(BATCH_BIN_FSPATH)
	cp -r deck/deck__ajstarks/cmd/deckweb/.bin/gobuild/* $(BATCH_BIN_FSPATH)
	cp -r deck/deck__ajstarks/cmd/deckweb/.bin/gobuild/* $(BATCH_BIN_FSPATH)
	#cp -r deck/deck__ajstarks/cmd/fcdeck/.bin/gobuild/* $(BATCH_BIN_FSPATH)
	#cp -r deck/deck__ajstarks/cmd/gcdeck/.bin/gobuild/* $(BATCH_BIN_FSPATH)
	cp -r deck/deck__ajstarks/cmd/pdfdeck/.bin/gobuild/* $(BATCH_BIN_FSPATH)
	cp -r deck/deck__ajstarks/cmd/pngdeck/.bin/gobuild/* $(BATCH_BIN_FSPATH)
	cp -r deck/deck__ajstarks/cmd/svgdeck/.bin/gobuild/* $(BATCH_BIN_FSPATH)
	
	cp -r giocanvas/giocanvas__ajstarks/gcdeck/.bin/giobuild/* $(BATCH_BIN_FSPATH)

batch-bin-del:
	rm -rf $(BATCH_BIN_FSPATH)



### RELEASE

BATCH_RELEASE_FSPATH=$(PWD)/.release
BATCH_RELEASE_VER=0.0.0

batch-release-trans:
	# transform everything in .bin into flat file structure and into .release

batch-release:
	# push to github releases
	go install github.com/tcnksm/ghr@v0.16.0
	
	ghr -debug $(BATCH_RELEASE_VER) $(BATCH_BIN_FSPATH)/darwin_amd64
batch-release-del:
	ghr -delete $(BATCH_RELEASE_VER)
