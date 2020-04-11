#! /bin/sh
registryAddr=$5
imageName=${registryAddr}/$1
tag=$2
imagePort=$3
hostPort=$4


#两个可以不用停止WEB服务就可以清空nohup.out的命令。
#第一种：cp /dev/null nohup.out
#第二种：cat /dev/null > nohup.out
cp /dev/null nohup.out
#sleep 2m
#停掉容器、删除容器、删除镜像
/opt/jenkins_shell/delete_image.sh $imageName $tag

#pull镜像
docker pull $imageName:$tag

#运行镜像
docker run --net=host -d -p ${imagePort}:${hostPort}  -t ${imageName}:$tag
