FROM debian:bullseye-slim as builder
# compile rules from https://github.com/nbs-system/naxsi/wiki/naxsi-compile

ADD app /app

ENV NGINX_VER=1.24.0
ENV NAXSI_VER=1.3

RUN apt update -y && \
    apt install -y wget git gcc make libpcre2-dev libssl-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://nginx.org/download/nginx-$NGINX_VER.tar.gz && \
    tar vxf nginx-$NGINX_VER.tar.gz && \
    git clone https://github.com/nbs-system/naxsi-rules && \
    git clone https://github.com/nbs-system/naxsi && \
    cd nginx-$NGINX_VER && \
    ./configure --prefix=/etc/nginx --add-dynamic-module=../naxsi/naxsi_src  --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-g -O2 -ffile-prefix-map=/data/builder/debuild/nginx-1.24.0/debian/debuild-base/nginx-1.24.0=. -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie' && \
    make && \
    make install DESTDIR=/opt && \
    cd /opt/ && tar zcvf nginx.1.24.tgz *

FROM debian:bullseye-slim

COPY --from=builder /opt/nginx.1.24.tgz /opt
COPY --from=builder /naxsi/naxsi_config/naxsi_core.rules /etc/nginx/
COPY --from=builder /naxsi-rules/* /etc/naxsi/

ADD app /app
WORKDIR /app

ENV BACKEND=http://fakeserver:80

RUN apt update -y && \
    apt install -y gettext-base && \
    rm -rf /var/lib/apt/lists/* && \
    addgroup --system --gid 101 nginx && \
    adduser --system --disabled-login --ingroup nginx --no-create-home --home /nonexistent --gecos "nginx user" --shell /bin/false --uid 101 nginx && \
    tar xvf /opt/nginx.1.24.tgz -C / && \
    cp -f /app/nginx/nginx.conf /etc/nginx/nginx.conf && \
    mkdir -p /etc/nginx/conf.d/ && \
    envsubst < /app/nginx/proxy.conf > /etc/nginx/conf.d/default.conf
    