import psutil
import sys

parent = psutil.Process(int(sys.argv[1]))
children = parent.children()

child_pids = [p.pid for p in children]
#print(child_pids)

def get_dockerd_pid(pids):
  for pid in pids:
    try:
      p = psutil.Process(pid)
      #print("debug:", p.pid, p.name(), p.cmdline())
      if p.cmdline()[0] == "docker-containerd" and p.cmdline()[2] == "unix:///var/run/docker/libcontainerd/docker-containerd.sock":
        return p.pid
      else:
        pass
    except (psutil.NoSuchProcess):
      return -1


dockerd_pid = get_dockerd_pid(child_pids)
if (dockerd_pid):
  print(dockerd_pid)
