#! /bin/sh
registryAddr=$5
imageName=${registryAddr}/$1
tag=$2
imagePort=$3
hostPort=$4

#停掉容器、删除容器、删除镜像
echo "(1)/opt/jenkins_shell/delete_image.sh $imageName $tag"
/opt/jenkins_shell/delete_image.sh $imageName $tag

#pull镜像
echo "(2)docker pull $imageName:$tag"
docker pull $imageName:$tag

#运行镜像
echo "(3)docker run --net=host -d -p ${imagePort}:${hostPort}  -t ${imageName}:$tag"
docker run --net=host -d -p ${imagePort}:${hostPort}  -t ${imageName}:$tag
