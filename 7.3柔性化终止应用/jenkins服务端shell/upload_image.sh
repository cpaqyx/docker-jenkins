#! /bin/sh
#镜像名称
image_name=$1
#标签
image_tag=$2
#镜像仓库地址
registry_url=$3
#带仓库地址镜像名称
image_full_name=${registry_url}/$image_name

image_check_command=`docker images | grep -w $image_full_name  | awk '{print $3}'`
echo "（1）image_check_command=$image_check_command"
if [ "$image_check_command" !=  "" ] ; then
	#将仓库中的镜像名称删除
	docker rmi ${registry_url}/${image_name}:$image_tag
fi

echo "(2)docker tag ${image_name}:${image_tag} ${registry_url}/$image_name"

#必须要先将镜像的名称给变成  域名或ip/镜像名
docker tag ${image_name}:${image_tag} ${registry_url}/$image_name:$image_tag


#推送到本地的仓库上
echo "(3)docker push ${registry_url}/$image_name"
docker push ${registry_url}/$image_name:$image_tag

#删除本地镜像
echo "(4)docker rmi $image_name:${image_tag}"
#docker rmi ${registry_url}/$image_name:$image_tag
#docker rmi $image_name:${image_tag}

echo "OK"


