## Usage

### Kubernetes
```bash
# start pod, execute command, exit and remove pod
k run -i --tty --rm kubernetes-admin-toolkit \
--image=adegoodyer/kubernetes-admin-toolkit:latest \
--restart=Never -- \
curl -L --head google.co.uk

# start pod, open shell
k run -i --tty --rm kubernetes-admin-toolkit \
--image=adegoodyer/kubernetes-admin-toolkit:latest \
--restart=Never

# execute command on running pod
k exec kubernetes-admin-toolkit -- ps aux

# open shell on running pod
k exec --stdin --tty kubernetes-admin-toolkit -- /bin/bash

# stop and remove pod
k delete po kubernetes-admin-toolkit

# alias (add to your .bashrc, .bash_profile, .zshrc etc)
alias kat="kubectl run -i --tty --rm ades-kubernetes-admin-toolkit --image=adegoodyer/kubernetes-admin-toolkit:latest --restart=Never"
```

### Docker
```bash
# run single command
d run -it --rm \
--name kubernetes-admin-toolkit \
adegoodyer/kubernetes-admin-toolkit:latest \
curl -L --head google.co.uk

# disposable container
d run -it --rm \
--name kubernetes-admin-toolkit \
adegoodyer/kubernetes-admin-toolkit:latest

# persistent container
d run -itd \
--name kubernetes-admin-toolkit \
adegoodyer/kubernetes-admin-toolkit:latest

# persistent container (specify network)
d run -itd \
--network host \
--name kubernetes-admin-toolkit \
adegoodyer/kubernetes-admin-toolkit:latest

# persistent container (network of another container)
# (must change CONTAINER_NAME)
d run -itd \
--network container:CONTAINER_NAME \
--name kubernetes-admin-toolkit \
adegoodyer/kubernetes-admin-toolkit:latest

# connect to persistent container
d exec -it kubernetes-admin-toolkit /bin/bash

# stop and remove persistent container
# (d kill won't always remove)
d stop kubernetes-admin-toolkit && \
d rm kubernetes-admin-toolkit
```
