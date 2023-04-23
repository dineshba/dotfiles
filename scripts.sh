function previewSelection {
    directory=$1
    if [ ! -z  "$directory" ]; then
        if [ ! -d "$directory" ]; then
            # cat but with syntax highlighting
            bat --color=always "$directory"
        else
            # ls with colors and git-aware
            exa --color=always -l --git --git-ignore -h $directory
        fi
    fi
}

# Export the function
export -f previewSelection

function godir {
    directory=$(fd -E vendor -d 5 . ${2:-${HOME}}/ | fzf --query ${1:-""} --color 16 --preview "previewSelection {}" --height 80%  )
    if [ ! -z  "$directory" ]; then
        if [ ! -d "$directory" ]; then
            # Its a file. cd to the directory.
            cd $(dirname "$directory")
        else
            # cd to the directory
            cd $directory
        fi
    fi
}

function gogo {
    godir ${1:-""} $GOPATH
}

alias utils="kubectl exec -it deploy/utils -n default bash"

docker_clean_images() {
    echo ">>> Select images to be removed"
    list=( $(docker images | awk '{print $1":"$2}' | fzf -m) )
    echo $list
    [ -z "$list" ] && echo "No images selected to remove" || docker rmi ${list[@]}
}

#docker shortcuts from https://gist.githubusercontent.com/ashokgowtham/676e5103c6b8f08cb8334381219bdbca/raw/75ce3a1e55a15a8182ea56c8219101b6ae9c7f5a/docker_shortcuts

docker_exec() {
    echo ">>> Select container to exec into"
    list=( $(docker ps | grep -v CONTAINER | fzf --height=10 --layout=reverse --inline-info | cut -d ' ' -f 1) )
    echo $list
    [ -z "$list" ] && echo "No container to exec" || docker exec -it ${list[@]} ${@:-sh}
}
docker_service_ps() {
    echo ">>> Select service name"
    list=( $(docker service ls | fzf --height=10 --layout=reverse --inline-info | cut -d ' ' -f 1) )
    echo $list
    [ -z "$list" ] && echo "No services found" || docker service ps ${list[@]}
}
docker_container_stop() {
    echo ">>> Select containers to stop"
    list=( $(docker ps | fzf --height=10 --layout=reverse --inline-info --multi | cut -d ' ' -f 1) )
    # echo $list
    [ -z "$list" ] && echo "No containers to stop" || docker container stop -t 1 ${list[@]}
}
docker_container_stop_all() {
    echo ">>> stopping all running containers"
    list=( $(docker ps -q) )
    if [[ -z "$list" ]]
    then
        echo "No containers to stop"
        return 0
    else
        echo -n "Number of containers running: "
        echo $(echo $list | wc -l)
        read -p "Are you sure? " -n 1 -r
        echo    # (optional) move to a new line
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            docker container stop -t 1 ${list[@]}
            return 0
        else
            echo "Cancelled!"
            return 1
        fi
    fi
}
docker_container_rm() {
    echo ">>> Select containers to delete"
    list=( $(docker ps | fzf --height=10 --layout=reverse --inline-info --multi | cut -d ' ' -f 1) )
    # echo $list
    [ -z "${list[*]}" ] && echo "No containers to delete" || docker container rm ${list[@]}
}
docker_container_rm_all() {
    docker_container_stop_all
    echo ">>> deleting all containers"
    list=( $(docker container ls -a -q) )
    # echo $list
    [ -z "$list" ] && echo "No containers to delete" || docker container rm ${list[@]}
}
docker_image_rm_all() {
    docker_container_rm_all
    echo ">>> deleting all images"
    list=( $(docker image ls -a -q) )
    # echo $list
    [ -z "$list" ] && echo "No images to delete" || docker image rm ${list[@]}
}
docker_network_rm_all() {
    echo ">>> deleting all networks"
    docker network prune -f
}
docker_volume_rm_all() {
    echo ">>> deleting all volumes"
    docker volume prune -f
}
docker_rm_all() {
    docker_image_rm_all
    sleep 3
    docker_volume_rm_all
    docker_network_rm_all
}
docker_logs() {
    echo ">>> Select container see logs"
    list=( $(docker ps | fzf --height=10 --layout=reverse --inline-info | cut -d ' ' -f 1) )
    echo $list
    [ -z "$list" ] && echo "No container to see logs" || docker logs -f ${list[@]}
}
