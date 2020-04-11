#! /bin/sh
registry_url=$5
image_name=${registry_url}/$1
image_tag=$2
image_port=$3
host_port=$4
eureka_url=$6

# 截取到服务名称,如fastwave/fastwave-service-admin，载取后变为fastwave-service-admin
service_withprefix_name=$1
service_name_array=(${service_withprefix_name//\// })
service_name=${service_name_array[1]}

#向eureka发送指令，让服务停止，即不再接收新的请求，这样终止服务将更柔性化
echo "nohup sh /opt/jenkins_shell/disable_service.sh ${service_name} ${image_port} ${eureka_url}"
nohup sh /opt/jenkins_shell/disable_service.sh ${service_name} ${image_port} ${eureka_url}

# 休眠一段时间，建议设置超过90秒以上，演示可以设置为30秒
# sleep 2m
sleep 30s

#两个可以不用停止WEB服务就可以清空nohup.out的命令。
#第一种：cp /dev/null nohup.out
#第二种：cat /dev/null > nohup.out
cp /dev/null nohup.out
#sleep 2m
#停掉容器、删除容器、删除镜像
/opt/jenkins_shell/delete_image.sh $image_name $image_tag

#pull镜像
docker pull $image_name:$image_tag

#运行镜像
docker run --net=host -d -p ${image_port}:${host_port}  -t ${image_name}:$image_tag
