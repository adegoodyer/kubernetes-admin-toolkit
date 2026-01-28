## Usage

### Kubernetes
```bash
# one-off command
k run -i --tty --rm k8s-toolkit \
--image=adegoodyer/kubernetes-admin-toolkit:latest \
--restart=Never -- \
curl -L --head google.co.uk

# interactive shell (removes pod after exiting shell)
k run -i --tty --rm k8s-toolkit \
--image=adegoodyer/kubernetes-admin-toolkit:latest \
--restart=Never

# long-running pod (no interactive shell, need to exec in later)
k run k8s-toolkit \
--image=adegoodyer/kubernetes-admin-toolkit:latest \
--restart=Never --command -- \
tail -f /dev/null

# execute subsequent commands on running pod
k exec k8s-toolkit -- ps aux

# open shell on running pod
k exec --stdin --tty k8s-toolkit -- /bin/bash

# remove pod
k delete po k8s-toolkit
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
