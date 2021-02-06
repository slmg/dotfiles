# Source aliases only if docker is installed.
command -v docker > /dev/null || {
    return
}

# image
alias dil='docker image ls'
alias dila="docker image ls -a"
alias dib='docker image build'
alias dibb='DOCKER_BUILDKIT=1 docker image build'
alias dill='docker image pull'
alias dip='docker image push'
alias dit='docker image tag'
alias dii='docker image inspect'
alias diid="docker image inspect --format='{{index .RepoDigests 0}}'"
alias dih='docker image history'
alias dir='docker image rm'
# rm vscode devcontainers (they tend to pile up)
alias dirvsc="dil | grep -E '^vsc-.*' | cut -d\  -f1 | xargs printf -- '%s:latest\n' | xargs docker image rm"
alias did='docker image prune'
alias dida='docker image prune -a'

# container
alias drl='docker container ls'
alias drla='docker container ls -a'
alias drr='docker container run'
alias drin='docker container run --rm -it'
alias drf='docker container diff'
alias drsta='docker container start'
alias drsto='docker container stop'
alias dra='docker container attach'
alias drx='docker container exec'
alias dri='docker container inspect'
alias drcp='docker container cp'
alias drlo='docker container logs'
alias drd='docker container prune'
alias drda='docker container prune -a'

# network
alias dnl='docker network ls'
alias dnc='docker network create'
alias dni='docker network inspect'
alias dncn='docker network connect'
alias dndcn='docker network disconnect'
alias dnr='docker network rm'
alias dnd='docker network prune'

# volume
alias dvl='docker volume ls'
alias dvc="docker volume create"
alias dvi='docker volume inspect'
alias dvim="docker volume inspect --format='{{.Mountpoint}}'"
alias dvr="docker volume rm"
# remove spam (un-named volume)
alias dvrs="docker volume ls | grep -oE '\w{64}' | xargs docker volume rm"
alias dvd="docker volume prune"
