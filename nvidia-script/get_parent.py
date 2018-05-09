import psutil
import sys

docker_pid = int(sys.argv[2])
#docker_pid = 2911

def get_parent_id(pid):
  me = psutil.Process(pid)
  #print(me.pid, me.ppid(), me.name())
  try:
    if me.ppid() == docker_pid:
      return me.pid
    else:
      return get_parent_id(me.ppid())
  except (psutil.NoSuchProcess):
    # If no such process found, maybe orphan process
    return -1

#me = psutil.Process(3136)
#print(sys.argv[1])
me = psutil.Process(int(sys.argv[1]))
ppid = get_parent_id(me.pid)
if (ppid):
  me = psutil.Process(ppid)
  print(me.cmdline()[1])
else:
  print "error"
