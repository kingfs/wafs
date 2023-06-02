# 构建Naxsi

```bash
docker build \
    --build-arg "HTTP_PROXY=${HTTP_PROXY}" \
    --build-arg "HTTPS_PROXY=${HTTP_PROXY}" \
    --build-arg "NO_PROXY=localhost,127.0.0.1" \
    -t naxsi .
```

```bash
docker build --build-arg "HTTP_PROXY=${HTTP_PROXY}" --build-arg "HTTPS_PROXY=${HTTP_PROXY}" -t nginx-naxsi .
```
