# Intro: nvidia-gpu-id

Are you using Nvidia-DGX1 as a shared resource?
Having trouble to map your DGX-1 container with GPU? 
Having unknown process to locked some of the GPU and you can't find who is the user?

With any of above, you want may want my script.

# To install

### 1. Just git clone it or download it using zip.
```
$ git clone https://github.com/teochenglim/nvidia-gpu-id
```

### 2. Install it at /usr/local/bin

```
$ cd nvidia-gpu-id
$ sudo chmod -R a+x *
$ sudo chown -R root:root * 
$ sudo mv * /usr/local/bin/ 
```

### 3. run is as if like other nvidia-smi family commands
### I assumed /usr/local/bin is in your PATH
### You can do it in by appending ~/.bashrc below
### export PATH=$PATH:/usr/local/bin

### This script also need psutil
### Shall work on both Python2 and Python3
```
$ pip install psutil
```

### 4. run it
```
$ nvidia-gpu-pid
```

### 5. Questions? Please write to teochenglim@gmail.com

#### 5.1 Why don't you map "user id" but the "container id"?
#### 5.1a Because you might not have such info for "user id" mapping, most users are granted with "docker group" permission. When user create a new container, that's no user information it in. A work around is all users shall have a form of username, or name their docker base on their user name.

