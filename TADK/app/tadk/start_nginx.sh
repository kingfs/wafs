#!/bin/bash

# export TADK_ROOT="/root/tadk_v23.03.0"
# export LD_LIBRARY_PATH=$TADK_ROOT/build-root/install-root/lib:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=$TADK_ROOT/extern/daal/lib:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=$TADK_ROOT/extern/openvino/lib:$LD_LIBRARY_PATH
# export LD_LIBRARY_PATH=$TADK_ROOT/extern/hs/lib:$LD_LIBRARY_PATH

if [ "${WORK_MODEL}" == "dl" ]; then
    echo "export TADK_MODEL_DIR=$TADK_ROOT/model/anomaly_detect/dl_model" >> /etc/profile
else
    echo "export TADK_MODEL_DIR=$TADK_ROOT/model/anomaly_detect/ml_model" >> /etc/profile
fi

source /etc/profile

envsubst < /app/nginx/nginx.conf > /usr/local/nginx/conf/nginx.conf

/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf 

while :;
do
    sleep 3600;
done
