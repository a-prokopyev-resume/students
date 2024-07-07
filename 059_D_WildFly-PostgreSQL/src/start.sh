if ! dpkg -al | grep ansible; then
	apt-get update;
	apt-get install --yes ansible;
fi;

ansible-galaxy collection install community.docker;
apt-get remove -y docker.io;
ansible-playbook ansible.yml;
#ansible-playbook  -e @vars/super.yml  ansible.yml;
#ansible-playbook -vvv  -e @vars/super.env.json  ansible.yml;
# ansible-playbook -e @vars/main.yml test.yml -i inventory/prod2.yml;
./compose.sh logs

