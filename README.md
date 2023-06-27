# deck-all

Brings together the deck bits....

https://github.com/ajstarks/decksh

https://github.com/ajstarks/decksh

https://github.com/ajstarks/giocanvas

Deck is designed so that each part can use STD IO and so can be piped.

I compile the processors to WASM so that users can run it locally in a sandbox for security / privacy.

I then use NATS to run the pipeline. https://github.com/choria-io/asyncjobs for example uses nats to run pipelones of schedule or continuously.


## future work

HTML output using s expressions...

https://codeberg.org/t73fde/sxpf
- sxpf - S-Expression Framework

https://codeberg.org/t73fde/sxhtml
- sxhtml - Generate HTML from S-Expressions

