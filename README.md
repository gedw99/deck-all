# deck-all

Brings together the deck bits....

https://github.com/ajstarks/decksh

https://github.com/ajstarks/decksh

https://github.com/ajstarks/giocanvas

Deck is designed so that each part can use STD IO and so can be piped.

I compile the processors to WASM so that users can run it locally in a sandbox for security / privacy.

I then use NATS to run the pipeline. https://github.com/choria-io/asyncjobs for example uses nats to run pipelones of schedule or continuously.

## Build targets

OS: windows, darwin, linux, js, wasi1p
ARCH: amd64, arm64

TODO: linux arm64

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

## WASM RUNNERS

WASM RUnners: https://github.com/teamortix/golang-wasm

## WASI runners

https://github.com/stealthrocket/wasi-go/tree/main/cmd/wasirun

go install github.com/stealthrocket/wasi-go/cmd/wasirun@latest



## HTML

HTML output using s expressions...

https://codeberg.org/t73fde/sxpf
- sxpf - S-Expression Framework

https://codeberg.org/t73fde/sxhtml
- sxhtml - Generate HTML from S-Expressions

