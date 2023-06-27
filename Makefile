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

include $(MAKE_FSPATH)/overmind.mk

#include $(MAKE_FSPATH)/icns.mk
include $(MAKE_FSPATH)/hcloud.mk
include $(MAKE_FSPATH)/contabo.mk

# https://github.com/gedw99/deck-all
GIT_SRC_NAME=deck-all
GIT_SRC_VERSION=main
GIT_SRC_UPSTREAM_ORG=gedw99
#GIT_SRC_UPSTREAM_FSNAME=$(PWD)
#GIT_SRC_ORIGIN_ORG=gedw99
GIT_SRC_ORIGIN_FSNAME=$(PWD)


# Pick source stream
#WORK_FSPATH=$(PWD)
#WORK_FSPATH=$(PWD)/$(GIT_SRC_UPSTREAM_FSNAME)
WORK_FSPATH=$(PWD)/$(GIT_SRC_ORIGIN_FSNAME)


this-git-all:
	$(MAKE) GIT_COMMIT_MESSAGE='blah' git-origin-push
this-dep-tool:



### BUILD

# build all git repos
include $(PWD)/batch.mk

all: batch-all



### BINARIES ( pick your OS ad ARCH )
DIST_FSPATH=$(PWD)/.bin/darwin_amd64
export PATH:=$(DIST_FSPATH):$(DIST_FSPATH)/gcdeck.app/Contents/MacOS:$(PATH)

### FONTS
# TODO: release them, so easy for users.
export DECKFONTS=$(PWD)/deckfonts/deckfonts__ajstarks


### HELP

decksh-help:
	decksh -h
pdfdeck-help:
	pdfdeck -h
svgdeck-help:
	svgdeck -h
gcdeck-help:
	gcdeck -h

### EXAMPLES

EX_OUT=$(PWD)/.out

ex-test:
	mkdir -p $(EX_OUT)
	@echo ""
	@echo "decksh > xml"
	cd $(PWD)/decksh/decksh__ajstarks && decksh test.dsh > $(EX_OUT)/test.xml
	
	# pdfdeck ( works )
	@echo ""
	@echo "pdfdeck > pdf"
	cd $(PWD)/decksh/decksh__ajstarks && pdfdeck -sans NotoSans-Regular -outdir $(EX_OUT) $(EX_OUT)/test.xml && open $(EX_OUT)/test.pdf

	# svgdeck ( works )
	@echo ""
	@echo "svgdeck > svg"
	cd $(PWD)/decksh/decksh__ajstarks && svgdeck -sans NotoSans-Regular -outdir $(EX_OUT) $(EX_OUT)/test.xml && open $(EX_OUT)/test-00001.svg

	# gcdeck ( works )
	# ISSUE: window resizing needs to be responsive.
	# ISSUE: no scrolling, so content drops off the edge.
	@echo ""
	@echo "gcdeck > app"
	cd $(PWD)/decksh/decksh__ajstarks && gcdeck -pagesize Widescreen test.xml

ex-short:
	# need deck font. Fix that later
	# from $(PWD)/decksh/decksh__ajstarks/doc/mkdeck-short.sh

	# Pick your fonts !
	@echo ""
	@echo "decksh > pdf"

	# broken for now...
	#cd $(PWD)/decksh/decksh__ajstarks/doc && decksh decksh-short.dsh | pdfdeck $* -pagesize 800,450 -sans GillSans -mono NotoMono-Regular -serif GillSans-Italic -stdout - > $(EX_OUT)/decksh-short.pdf
	
	cd $(PWD)/decksh/decksh__ajstarks/doc && decksh decksh-short.dsh | pdfdeck $* -pagesize 800,450 -sans NotoSans-Regular -mono NotoMono-Regular -serif NotoMono-Regular -stdout - > $(EX_OUT)/decksh-short.pdf

	open $(EX_OUT)/decksh-short.pdf

EX_VIZ_FSPATH=$(PWD)/deckviz/deckviz__ajstarks/bauhaus-lamp
EX_VIZ_NAME=lamp

ex-viz:
	cd $(EX_VIZ_FSPATH) && decksh $(EX_VIZ_NAME).dsh | pdfdeck $* -pagesize 800,450 -sans NotoSans-Regular -mono NotoMono-Regular -serif NotoMono-Regular -stdout - > $(EX_VIZ_NAME).pdf
	open $(EX_VIZ_FSPATH)/$(EX_VIZ_NAME).pdf

deckd-run:
	# try to use server and web gui, so we can quickly browse.

	# Its is ONLY designed for viewing already rednered to xml stuff
	deckd -dir $(EX_VIZ_FSPATH) -listen localhost:8080
	# http://localhost:8080/

	# http://localhost:8080/deck/

animate:
	# see https://github.com/ajstarks/openvg/blob/master/go-client/clock/clock.go
	# Its shitty. think about it more.

users:
	# looks like i can use this to wrap the deck commands directly.
	# a NATS stream might be better as its more flexible.
	# Cool this will be that deckd web can show the output as stuff streams to the disk that deckd is looking at.
	# can add NATS to decks and signal it that a file has changed, and it can then tell web viewers via an event
	# Yomorun presence system using web sockets / web transprt to sent event about what changed, and then Web client pulls it.
	## its a bit like basic htmx. 
	# Its clean and simple
	# can transpprt xml and pds, etc via NAST obj store and out to disk where ever that stream leads to.
	
	# https://github.com/harmonicinc-com/joebot 
	# its actually works and can punch through.
	

dev:
	## this is where we diff the udiff
	# can run nats leaf on each devs system so that we dont need to worry about hole punching.
	# again NATS streams can do it.
	# nats or https://github.com/nf/nux/blob/main/dev.go#L17

plugins:
	# capsule 
	# devs / users can write plugins.
	# renderers to twitter, email, youtube, other. Mattermost has some.


run-caddy:
	# no caddyfile needed
	$(MAKE) caddy-server-run-browse
	# http://localhost/

run-overmnd:
	# non demon
	$(MAKE) overmind-run

start-overmind:
	# demon
	$(MAKE) overmind-daemon-ops-start
	# need a web gui !!

	

