git pull
ansible-playbook --inventory="${component_name}-dev.kanchanadevisujan.online," roboshop.yml -e component_name="${component_name}" -e ansible_user=devops -e ansible_password=Devops@12345
