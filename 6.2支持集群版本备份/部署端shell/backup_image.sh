#! /bin/sh
#镜像名称
image_name=$1
#标签
image_tag=$2
#镜像仓库地址
registry_url=$3
#备份tag
image_bak_tag=$4

#带仓库地址镜像名称
image_full_name=$registry_url/$image_name

colunm3='$3'

# 获取当前正在运行的镜像
echo "docker images | grep -w $image_full_name  | awk '{print $colunm3}'"
image_check_command=`docker images | grep -w $image_full_name  | awk '{print $colunm3}'`
if [ "$image_check_command" !=  "" ] ; then
	# 将运行的镜像，重新修改tag命名为备份tag
	echo "docker tag ${image_full_name}:${image_tag} ${image_full_name}:${image_bak_tag}"
	docker tag ${image_full_name}:${image_tag} ${image_full_name}:${image_bak_tag}
	# 将备份的镜像发送到镜像仓库，备份起来
	echo "docker push ${image_full_name}:${image_bak_tag}"
	docker push ${image_full_name}:${image_bak_tag}
	#将本地刚重命名的镜像删除
	echo "docker rmi ${registry_url}/${image_name}:$image_bak_tag"
	docker rmi ${registry_url}/${image_name}:$image_bak_tag
fi


