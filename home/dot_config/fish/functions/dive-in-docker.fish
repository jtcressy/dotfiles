function dive-in-docker --description "Inspect Docker image layers with dive"
    docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive -- $argv
end
