systemctl stop docker;
systemctl stop docker.socket;
systemctl status docker | cat;

systemctl stop containerd;
systemctl status containerd | cat;
