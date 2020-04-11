#! /bin/sh
#镜像名称
imageName=$1
tag=$2

#容器字符串
containerStr=`docker ps -a | grep -w ${imageName}:${tag}  | awk '{print $1}'`
imageStr=`docker images | grep -w $imageName  | awk '{print $3}'`

if [ "$imageStr" !=  "" ] ; then
    if [ "$containerStr" !=  "" ] ; then
        #停掉容器
        docker stop `docker ps -a | grep -w ${imageName}:${tag}  | awk '{print $1}'`

        #删除容器
        docker rm `docker ps -a | grep -w ${imageName}:${tag}  | awk '{print $1}'`

        #删除镜像
        docker rmi --force ${imageName}:${tag}
		
		echo "停止容器、删除镜像${imageName}:${tag}成功"
    else
         #删除镜像
        docker rmi --force ${imageName}:${tag}
		echo "删除镜像${imageName}:${tag}成功"
    fi
fi

