FROM gcc:9 as builder
# compile rules from https://github.com/nbs-system/naxsi/wiki/naxsi-compile

# nginx:bullseye nginx version is 1.25.0
ENV NGINX_VER=1.25.0
ENV NAXSI_VER=1.3

RUN wget https://nginx.org/download/nginx-$NGINX_VER.tar.gz && \
    tar vxf nginx-$NGINX_VER.tar.gz && \
    git clone https://github.com/nbs-system/naxsi-rules && \
    git clone https://github.com/nbs-system/naxsi && \
    cd nginx-$NGINX_VER && \
    ./configure --add-dynamic-module=../naxsi/naxsi_src/ && \
    make modules

FROM nginx:bullseye


COPY --from=builder /nginx-1.25.0/objs/ngx_http_naxsi_module.so /etc/nginx/modules/
COPY --from=builder /naxsi/naxsi_config/naxsi_core.rules /etc/nginx/
COPY --from=builder /naxsi-rules/* /etc/naxsi/

ADD app /app
WORKDIR /app

ENV BACKEND=http://fakeserver:80

RUN cp -f /app/nginx/nginx.conf /etc/nginx/nginx.conf && \
    envsubst < /app/nginx/proxy.conf > /etc/nginx/conf.d/default.conf
    