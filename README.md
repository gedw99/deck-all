# deck-all

This is a batch building for Deck used in the Open Science project...

Currently only:

https://github.com/ajstarks/decksh

https://github.com/ajstarks/decksh

https://github.com/ajstarks/giocanvas


Deck is well designed in that each part can use STD IO and so can be piped in a chain, allowing flexibility of use cases.

For Security reasons, I compile the processors to WASM as well as traditional targets. 

To server the WASM and WASI19 and WASI2P, i use https://github.com/stealthrocket/wasi-go/tree/main/cmd/wasirun to wrap the wasi with a host runner. This currently requires GoTip.

To run the pipelines, I use NATS.

To Server the pipelines, I use https://github.com/choria-io/asyncjobs to run them on a schedule or as continuously jobs.

## Build targets

OS: windows, darwin, linux

ARCH: amd64, arm64, js, wasm, wasip1, wasip2, web_wasm

TODO: 
- linux arm64
- wasi2p

```sh
├── darwin_amd64
│   ├── deckd
│   ├── deckinfo
│   ├── decksh
│   ├── deckweb
│   ├── gcdeck.app
│   │   └── Contents
│   ├── pdfdeck
│   ├── pngdeck
│   └── svgdeck
├── darwin_arm64
│   ├── deckd
│   ├── deckinfo
│   ├── decksh
│   ├── deckweb
│   ├── gcdeck.app
│   │   └── Contents
│   ├── pdfdeck
│   ├── pngdeck
│   └── svgdeck
├── js_wasm
│   ├── deckd.wasm
│   ├── deckinfo.wasm
│   ├── decksh.wasm
│   ├── deckweb.wasm
│   ├── pdfdeck.wasm
│   ├── pngdeck.wasm
│   └── svgdeck.wasm
├── linux_amd64
│   ├── deckd
│   ├── deckinfo
│   ├── decksh
│   ├── deckweb
│   ├── gcdeck
│   ├── pdfdeck
│   ├── pngdeck
│   └── svgdeck
├── linux_arm64
│   └── gcdeck
├── wasip1_wasm
│   ├── deckd.wasm
│   ├── deckinfo.wasm
│   ├── decksh.wasm
│   ├── deckweb.wasm
│   ├── pdfdeck.wasm
│   ├── pngdeck.wasm
│   └── svgdeck.wasm
├── web_wasm
│   └── gcdeck.web
│       ├── index.html
│       ├── main.wasm
│       └── wasm.js
├── windows_amd64
│   ├── deckd.exe
│   ├── deckinfo.exe
│   ├── decksh.exe
│   ├── deckweb.exe
│   ├── gcdeck.exe
│   ├── pdfdeck.exe
│   ├── pngdeck.exe
│   └── svgdeck.exe
└── windows_arm64
    ├── deckd.exe
    ├── deckinfo.exe
    ├── decksh.exe
    ├── deckweb.exe
    ├── gcdeck.exe
    ├── pdfdeck.exe
    ├── pngdeck.exe
    └── svgdeck.exe
```

## Releases

TODO: flatten build outputs so they can be uploaded to github releases


## WASM Runners

WASM Runners: https://github.com/teamortix/golang-wasm

## WASI Runners

https://github.com/stealthrocket/wasi-go/tree/main/cmd/wasirun

go install github.com/stealthrocket/wasi-go/cmd/wasirun@latest


## HTML Rendering

HTML output using s expressions piped off deck xml will allow a static HTTP output, but require a composite rendering system that needs to be worked on.

https://codeberg.org/t73fde/sxpf
- sxpf - S-Expression Framework

https://codeberg.org/t73fde/sxhtml
- sxhtml - Generate HTML from S-Expressions

## Reactivity

TODO: HTMX patterns to be added, so that users can interact with the decks at runtime.

https://htmx.org/

https://htmx.org/examples/
