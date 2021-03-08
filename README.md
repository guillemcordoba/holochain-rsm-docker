# Building an image

To build an image targeting a specific git commit of the [holochain repository](https://github.com/holochain/holochain), run this:

```bash
REVISION=cac00d4 docker build . -t guillemcordoba/rsm:cac00d4
```

The image is published [here](https://hub.docker.com/r/guillemcordoba/rsm/tags), tagged with the git commit hash (short version).
