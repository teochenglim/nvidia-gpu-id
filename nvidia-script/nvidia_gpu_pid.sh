#!/bin/bash

#docker inspect --format '{{ .State.Pid }}' $(docker ps -q)
#systemctl status docker | grep PID | cut -d" " -f4
docker_main_pid=`systemctl status docker | grep PID | cut -d" " -f4`
#echo "docker main pid: $docker_main_pid"

docker_process_pid=`python children.py $docker_main_pid`
#echo "docker process pid: $docker_process_pid"

#nvidia-smi pmon -c 1 | egrep -v "gpu|Idx|-" | awk '{print $1":"$2":"}'
nvidia_pids=`nvidia-smi pmon -c 1 -s m | egrep -v "gpu|Idx|-" | awk '{print $1":"$2":"$4}'`
#echo "nvidia pids: $nvidia_pids"


echo "========================================================================================="
echo "gpu_id:process_id:docker_container_id:memory_used(in MB)"
echo "========================================================================================="
for i in $nvidia_pids
do
  #echo $i
  gpu_id=`echo $i | cut -d: -f1`
  pid_id=`echo $i | cut -d: -f2`
  mem_used=`echo $i | cut -d: -f3` 
  #print $gpu_id
  #print $pid_id
  container_id=`python get_parent.py $pid_id $docker_process_pid`
  echo "#"$gpu_id":"$pid_id":"$container_id":"$mem_used
done
echo "========================================================================================="
echo "1. use 'nvidia-smi' to find which process is using which GPU"
echo "2. use 'ps auxf' to find which process is locking the GPU"
echo "3. use 'docker inspect docker_container_id' to find out which container is using the GPU"
echo "========================================================================================="
