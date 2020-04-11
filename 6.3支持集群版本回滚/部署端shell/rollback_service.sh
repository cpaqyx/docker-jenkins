#! /bin/sh
registry_url=$5
image_name=$1
image_tag=$2
image_port=$3
host_port=$4
eureka_url=$6
image_bak_tag=$7
image_full_name=$registry_url/$image_name

# 截取到服务名称,如fastwave/fastwave-service-admin，载取后变为fastwave-service-admin
service_withprefix_name=$1
service_name_array=(${service_withprefix_name//\// })
service_name=${service_name_array[1]}

#停掉容器、删除容器、删除镜像
echo "停掉容器、删除容器、删除镜像"
/opt/jenkins_shell/delete_image.sh $image_full_name $image_tag

#pull镜像
echo "docker pull $image_full_name:$image_bak_tag"
docker pull $image_full_name:$image_bak_tag

#运行镜像
echo "docker run --net=host -d -p ${image_port}:${host_port}  -t ${image_full_name}:$image_bak_tag"
docker run --net=host -d -p ${image_port}:${host_port}  -t ${image_full_name}:$image_bak_tag
