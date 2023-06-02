#!/bin/bash

export LD_LIBRARY_PATH=$TADK_LD_LIBRARY_PATH:$LD_LIBRARY_PATH

if [ "${WORK_MODEL}" == "dl" ]; then
    export TADK_MODEL_DIR=$TADK_ROOT/model/anomaly_detect/dl_model
    echo "export TADK_MODEL_DIR=$TADK_ROOT/model/anomaly_detect/dl_model" >> /etc/profile
else
    export TADK_MODEL_DIR=$TADK_ROOT/model/anomaly_detect/ml_model
    echo "export TADK_MODEL_DIR=$TADK_ROOT/model/anomaly_detect/ml_model" >> /etc/profile
fi

source /etc/profile

envsubst < /app/nginx/nginx.conf > /usr/local/nginx/conf/nginx.conf

/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf 

while :;
do
    sleep 3600;
done
