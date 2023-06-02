FROM intel/tadk-waf:v23.03.0

# default ml model, choice: ml dl
ENV WORK_MODEL=ml
ENV TADK_MODEL_DIR=/root/tadk_v23.03.0/model/anomaly_detect/ml_model
ENV BACKEND=fakeserver:80

ENV TADK_ROOT="/root/tadk_v23.03.0"
ENV LD_LIBRARY_PATH=$TADK_ROOT/build-root/install-root/lib:$TADK_ROOT/extern/daal/lib:$TADK_ROOT/extern/openvino/lib:$TADK_ROOT/extern/hs/lib:$LD_LIBRARY_PATH

ADD app /app

RUN apt update -y && \
    apt install -y gettext-base && \
    rm -rf /var/lib/apt/lists/* && \
    cp /app/tadk/start_nginx.sh /start_nginx.sh

# docker push kingfs/tadk:v23.03.0
