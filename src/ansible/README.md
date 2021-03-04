# Pasos

Crear usuario ansible

Sudoers

Cambiar configuración sshd

Crear claves

Copiar las claves

## Instalación de collections necesarios para la ejecución de playbooks
`ansible-playbook -i hosts -l master 00-conf_ansible.yaml`

## Firewall parado así que hay que arrancarlo para que no den error las task de reglas de firewall
`ansible-playbook -i hosts -l all 01-conf_ini.yaml`

## Configuración de nfs
`ansible-playbook -i hosts -l master 02-confignfs.yaml`

## Instalación de docker y kubernetes
`ansible-playbook -i hosts -l all 03-container.yaml`

## Configuración nodo master
`ansible-playbook -i hosts -l master 04-k8smaster.yaml`

Recoger la salida para sustituir en el fichero de join de los workers roles/k8sworkers/tasks/02-kubeadm.yaml

## Configuración cilium
`ansible-playbook -i hosts -l master 05-cilium.yaml`
```bash
[ansible@master-vm playbooks]$ sudo kubectl get pods -A
NAMESPACE     NAME                                READY   STATUS    RESTARTS   AGE
kube-system   cilium-fchd8                        1/1     Running   0          93s
kube-system   cilium-operator-696dc48d8d-dp2nt    1/1     Running   0          93s
kube-system   coredns-74ff55c5b-8v95g             1/1     Running   0          3m7s
kube-system   coredns-74ff55c5b-qxzmp             1/1     Running   0          3m7s
kube-system   etcd-master-vm                      1/1     Running   0          3m17s
kube-system   kube-apiserver-master-vm            1/1     Running   0          3m17s
kube-system   kube-controller-manager-master-vm   1/1     Running   0          3m17s
kube-system   kube-proxy-q7q6h                    1/1     Running   0          3m7s
kube-system   kube-scheduler-master-vm            1/1     Running   0          3m17s
```
## Configuración de los workers
`ansible-playbook -i hosts -l workers 06-k8sworkers.yaml`
```bash
[ansible@master-vm playbooks]$ sudo kubectl get nodes
NAME         STATUS   ROLES                  AGE     VERSION
master-vm    Ready    control-plane,master   8m57s   v1.20.4
worker1-vm   Ready    <none>                 3m39s   v1.20.4
worker2-vm   Ready    <none>                 3m40s   v1.20.4
```
## Despliegue de ingress
`ansible-playbook -i hosts -l master 07-ingress.yaml`
```bash
[ansible@master-vm playbooks]$ sudo kubectl get pods -A -w
NAMESPACE            NAME                                       READY   STATUS    RESTARTS   AGE
haproxy-controller   haproxy-ingress-67f7c8b555-sw95z           1/1     Running   0          27s
haproxy-controller   ingress-default-backend-78f5cc7d4c-jr9v4   1/1     Running   0          28s
kube-system          cilium-8n6z9                               1/1     Running   0          5m
kube-system          cilium-fchd8                               1/1     Running   0          8m23s
kube-system          cilium-operator-696dc48d8d-dp2nt           1/1     Running   0          8m23s
kube-system          cilium-vmb97                               1/1     Running   0          4m59s
kube-system          coredns-74ff55c5b-8v95g                    1/1     Running   0          9m57s
kube-system          coredns-74ff55c5b-qxzmp                    1/1     Running   0          9m57s
kube-system          etcd-master-vm                             1/1     Running   0          10m
kube-system          kube-apiserver-master-vm                   1/1     Running   0          10m
kube-system          kube-controller-manager-master-vm          1/1     Running   0          10m
kube-system          kube-proxy-5qxdz                           1/1     Running   0          5m
kube-system          kube-proxy-q7q6h                           1/1     Running   0          9m57s
kube-system          kube-proxy-zgpc4                           1/1     Running   0          4m59s
kube-system          kube-scheduler-master-vm                   1/1     Running   0          10m
```
## Crear el usuario kubeadmin. 
> Hay que crear un fichero con la contraseña
`ansible-playbook -i hosts -l master 08-k8sadmin.yaml --vault-password-file passfile`
