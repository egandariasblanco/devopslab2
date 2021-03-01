# lablocal

¿Verificaciones?



Hay que forzar la creación del lv o crearlo con shrink=no, si no, si ya existe, da error.

El fichero /etc/kubernetes/admin.conf no se puede copiar sin más. Hay que cambiarle los permisos antes de copiarlo a la home de root

Salida de kubeadmin init a fichero

El nfs montado con el flag no_root_squash para que los workers puedan escribir en el