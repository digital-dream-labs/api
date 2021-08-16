
# API

[Protocol buffers](https://developers.google.com/protocol-buffers/docs/proto3) for all of the magical back-end services that make vector work!

  
## Protocol buffers
|Directory| Description |
|--|--|
| proto/chipper | Wire protocol for the voice service |
| proto/jdocs | Wire protocol for the document store service |
| proto/token | Wire protocol for the token service |

## Building

To regenerate protocol buffers:

```sh
# make protos
```


```
// To build an individual proto
make proto dir=proto/chipper file=chipperpb
```
