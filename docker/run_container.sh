DATA_DIR='/media/dbutterfield3/T75'
REPO_DIR='/home/dbutterfield3/Research/RAFT-Stereo'

docker run -it \
    --name="raft-stereo" \
    --net="host" \
    --privileged \
    --gpus="all" \
    --workdir="/home/$USER/RAFT-Stereo" \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=/tmp/.Xauthority" \
    --env="USER_ID=$(id -u)" \
    --env="GROUP_ID=$(id -g)" \
    --volume="$REPO_DIR:/home/$USER/RAFT-Stereo" \
    --volume="$DATA_DIR:/home/$USER/data" \
    --volume="/home/$USER/.bash_aliases:/home/$USER/.bash_aliases" \
    --volume="/home/$USER/.ssh:/home/$USER/.ssh:ro" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$XAUTHORITY:/tmp/.Xauthority:ro" \
    raft-stereo  \
    /bin/bash
