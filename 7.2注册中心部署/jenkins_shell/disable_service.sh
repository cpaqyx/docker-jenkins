#!/bin/sh
image_name=$1
host_port=$2
eureka_url=$3

# 获取本地IP地址，以centos7以上版本为参考（其它版本命令需要作调整）
# ip=`ifconfig eth0|grep broadcast |awk '{print $2}'`
ip=`ip a | grep inet | grep -v inet6 | grep -v 127 | sed 's/^[ \t]*//g' | cut -d ' ' -f2 |cut -d '/' -f1 | awk 'NR==1'`

# 这里假定本机有eurake(如不存在或集群需多次尝试)
# 示例：http://10.101.43.197:8761/eureka/apps/fastwave-service-admin/fastwave-service-admin:10.101.43.197:8764/status?value=OUT_OF_SERVICE
echo "curl -X PUT -i http://${eureka_url}/eureka/apps/${image_name}/${image_name}:${ip}:${host_port}/status?value=OUT_OF_SERVICE"
curl -X PUT -i http://${eureka_url}/eureka/apps/${image_name}/${image_name}:${ip}:${host_port}/status?value=OUT_OF_SERVICE
