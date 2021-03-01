# lablocal

¿Verificaciones?



Hay que forzar la creación del lv o crearlo con shrink=no, si no, si ya existe, da error.

El fichero /etc/kubernetes/admin.conf no se puede copiar sin más. Hay que cambiarle los permisos antes de copiarlo a la home de root

Salida de kubeadmin init a fichero

El nfs montado con el flag no_root_squash para que los workers puedan escribir en el


Crear usuario ansible
Sudoers
Cambiar configuración sshd
Crear claves
Copiar las claves

#Instalación de collections necesarios para la ejecución de playbooks
ansible-playbook -i hosts -l master 00-conf_ansible.yaml

#Firewall parado así que hay que arrancarlo para que no den error las task de reglas de firewall
ansible-playbook -i hosts -l all 01-conf_ini.yaml

#Configuración de nfs
ansible-playbook -i hosts -l master 02-confignfs.yaml 

#Instalación de docker y kubernetes
ansible-playbook -i hosts -l all 03-container.yaml 

#Configuración nodo master
ansible-playbook -i hosts -l master 04-k8smaster.yaml

Recoger la salida para sustituir en el fichero de join de los workers roles/k8sworkers/tasks/02-kubeadm.yaml

#Configuración cilium
ansible-playbook -i hosts -l master 05-calico.yaml

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

#Configuración de los workers
ansible-playbook -i hosts -l workers 06-k8sworkers.yaml

[ansible@master-vm playbooks]$ sudo kubectl get nodes
NAME         STATUS   ROLES                  AGE     VERSION
master-vm    Ready    control-plane,master   8m57s   v1.20.4
worker1-vm   Ready    <none>                 3m39s   v1.20.4
worker2-vm   Ready    <none>                 3m40s   v1.20.4

#Despliegue de ingress
ansible-playbook -i hosts -l master 07-ingress.yaml

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

#Crear el usuario kubeadmin. Hay que crear un fichero con la contraseña
ansible-playbook -i hosts -l master 08-k8sadmin.yaml --vault-password-file passfile





Events:
  Type     Reason            Age                    From               Message
  ----     ------            ----                   ----               -------
  Warning  FailedScheduling  3m14s (x2 over 3m14s)  default-scheduler  0/3 nodes are available: 3 persistentvolumeclaim "nfs" not found.
  Normal   Scheduled         3m12s                  default-scheduler  Successfully assigned game/game-5f94d8fc6d-nkwkt to worker1-vm
  Warning  FailedMount       69s                    kubelet            Unable to attach or mount volumes: unmounted volumes=[nfs], unattached volumes=[nfs default-token-dn4gs]: timed out waiting for the condition
  Warning  FailedMount       63s (x9 over 3m11s)    kubelet            MountVolume.SetUp failed for volume "nfs" : mount failed: exit status 32
Mounting command: mount
Mounting arguments: -t nfs master.azure:/srv/nfs /var/lib/kubelet/pods/899ba4ed-10e5-48c7-a5c0-dbe9b0f8b041/volumes/kubernetes.io~nfs/nfs
Output: mount: /var/lib/kubelet/pods/899ba4ed-10e5-48c7-a5c0-dbe9b0f8b041/volumes/kubernetes.io~nfs/nfs: bad option; for several filesystems (e.g. nfs, cifs) you might need a /sbin/mount.<type> helper program.
