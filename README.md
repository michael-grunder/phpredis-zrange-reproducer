## Redis ZRANGE WITHSCORES segfault reproducer

This repo attempts to reproduce a `PhpRedis` `ZRANGE` segfault when serialization/compression is enabled.

### Build and Run

```sh
# Build and then run the repo
docker build -t zrange-reproducer .
docker run --rm zrange-reproducer
```
