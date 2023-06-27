print:

IN_TEST=/Users/apple/workspace/go/src/github.com/gedw99/deck-all/.bin

IN=$(PWD)/in
#IN=/Users/apple/workspace/go/src/github.com/gedw99/deck-all/.bin

OUT=$(PWD)/out
#OUT=/Users/apple/workspace/go/src/github.com/gedw99/deck-all/.release

clean:
	rm -rf $(OUT)
	rm -rf $(OUT)
in-prime:
	# copy test data in.
	rm -rf $(IN)
	mkdir -p $(IN)
	
	cp -r $(IN_TEST)/darwin_amd64 $(IN)
	cp -r $(IN_TEST)/web_wasm $(IN)
out-prime:
	rm -rf $(OUT)
	mkdir -p $(OUT)

	
run: in-prime out-prime
	
	# MUST use gotip, becaue go messes up the zip
	gotip run . --in $(IN) --out $(OUT)

test-exe:
	#chmod +x $(OUT)/deckd
	$(OUT)/darwin_amd64_deckd -h

test-unzip-web:
	unzip $(OUT)/web_wasm_gcdeck.web.zip
	#open $(OUT)/darwin_amd64_gcdeck.app
test-unzip-app:
	unzip $(OUT)/darwin_amd64_gcdeck.app.zip
	open $(OUT)/darwin_amd64_gcdeck.app
	 
	
