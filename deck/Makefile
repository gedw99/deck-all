# Assumes you have sc-make repo locally 
# and an env variable of $SC_MAKE_FSPATH pointing to the makefiles inside the sc-make repo.
# 
## example from $HOME/zshrc
#export SC_MAKE_FSPATH=/Users/apple/workspace/go/src/github.com/gedw99/sc-make/assets/.sc-make/make/

MAKE_FSPATH=$(SC_MAKE_FSPATH)
include $(MAKE_FSPATH)/help.mk
include $(MAKE_FSPATH)/git.mk

include $(MAKE_FSPATH)/caddy.mk
include $(MAKE_FSPATH)/go.mk
include $(MAKE_FSPATH)/gio.mk

#include $(MAKE_FSPATH)/icns.mk
include $(MAKE_FSPATH)/hcloud.mk
include $(MAKE_FSPATH)/contabo.mk

# https://github.com/ajstarks/deck
GIT_SRC_NAME=deck
GIT_SRC_VERSION=master
GIT_SRC_UPSTREAM_ORG=ajstarks
#GIT_SRC_UPSTREAM_FSNAME=$(PWD)
#GIT_SRC_ORIGIN_ORG=gedw99
#GIT_SRC_ORIGIN_FSNAME=$(PWD)



# Pick source stream
#WORK_FSPATH=$(PWD)
WORK_FSPATH=$(PWD)/$(GIT_SRC_UPSTREAM_FSNAME)
#WORK_FSPATH=$(PWD)/$(GIT_SRC_ORIGIN_FSNAME)


this-git-all:
	$(MAKE) GIT_COMMIT_MESSAGE='blah' git-origin-push
this-dep-tool:
	

# pick go src ( defaults to PWD)
#GO_SRC_FSPATH=$(WORK_FSPATH)
#GO_SRC_NAME=deck

# pick gio src ( defaults to PWD)
#GIO_SRC_FSPATH=$(WORK_FSPATH)
#GIO_SRC_NAME=bookmark-sync

# pick go target !
BIN_GO=$(GO_RUN_FSPATH)
#BIN_GO=$(GO_RUN_RELEASE_FSPATH)

# pick gio target !
BIN_GIO=$(GIO_RUN_FSPATH)
#BIN_GIO=$(GIO_RUN_RELEASE_FSPATH)

print:
	@echo ""
	@echo "-- GO --"
	@echo "GO_RUN_FSPATH:             $(GO_RUN_FSPATH)"
	@echo "GO_RUN_RELEASE_FSPATH:     $(GO_RUN_RELEASE_FSPATH)"

	@echo ""
	@echo "-- GIO --"
	@echo "GIO_RUN_FSPATH:            $(GIO_RUN_FSPATH)"
	@echo "GIO_RUN_RELEASE_FSPATH:    $(GIO_RUN_RELEASE_FSPATH)"
	@echo ""

build-go:
	$(MAKE) GO_SRC_GO_BIN_NAME=gotip GO_SRC_FSPATH=$(WORK_FSPATH)/cmd/deckd GO_SRC_NAME=deckd go-build
	$(MAKE) GO_SRC_GO_BIN_NAME=gotip GO_SRC_FSPATH=$(WORK_FSPATH)/cmd/deckinfo GO_SRC_NAME=deckinfo go-build
	$(MAKE) GO_SRC_GO_BIN_NAME=gotip GO_SRC_FSPATH=$(WORK_FSPATH)/cmd/deckweb GO_SRC_NAME=deckweb go-build
	
	$(MAKE) GO_SRC_GO_BIN_NAME=gotip GO_SRC_FSPATH=$(WORK_FSPATH)/cmd/pdfdeck GO_SRC_NAME=pdfdeck go-build
	$(MAKE) GO_SRC_GO_BIN_NAME=gotip GO_SRC_FSPATH=$(WORK_FSPATH)/cmd/pngdeck GO_SRC_NAME=pngdeck go-build
	$(MAKE) GO_SRC_GO_BIN_NAME=gotip GO_SRC_FSPATH=$(WORK_FSPATH)/cmd/svgdeck GO_SRC_NAME=svgdeck go-build
	
build-go-all:
	
	$(MAKE) GO_SRC_GO_BIN_NAME=gotip GO_SRC_FSPATH=$(WORK_FSPATH)/cmd/deckd GO_SRC_NAME=deckd go-build-all
	$(MAKE) GO_SRC_GO_BIN_NAME=gotip GO_SRC_FSPATH=$(WORK_FSPATH)/cmd/deckinfo GO_SRC_NAME=deckinfo go-build-all
	$(MAKE) GO_SRC_GO_BIN_NAME=gotip GO_SRC_FSPATH=$(WORK_FSPATH)/cmd/deckweb GO_SRC_NAME=deckweb go-build-all
	
	$(MAKE) GO_SRC_GO_BIN_NAME=gotip GO_SRC_FSPATH=$(WORK_FSPATH)/cmd/pdfdeck GO_SRC_NAME=pdfdeck go-build-all
	$(MAKE) GO_SRC_GO_BIN_NAME=gotip GO_SRC_FSPATH=$(WORK_FSPATH)/cmd/pngdeck GO_SRC_NAME=pngdeck go-build-all
	$(MAKE) GO_SRC_GO_BIN_NAME=gotip GO_SRC_FSPATH=$(WORK_FSPATH)/cmd/svgdeck GO_SRC_NAME=svgdeck go-build-all

build-clean:
	$(MAKE) go-clean-bin-ls
	$(MAKE) go-clean-bin-run

run-go:
	$(MAKE) go-run

build-gio:


build-gio-all:
	
run-gio:
	$(MAKE) gio-run



ARGS=-address 127.0.0.1:8080 -verbose
FILE=$(PWD)/test.txt

# go
0:
	$(BIN_GO)
1:
	$(BIN_GO) -h
2:
	touch $(FILE)
	$(BIN_GO) $(ARGS) $(FILE)

# gio
10:
	open $(BIN_GIO)

