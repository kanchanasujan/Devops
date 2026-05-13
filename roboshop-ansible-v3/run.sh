git pull
ansible-playbook --inventory="${component_name}-dev.kanchanadevisujan.online," roboshop.yml -e component_name="${component_name}" -e ansible_user=devops -e ansible_password=Devops@12345

ansible-playbook  -i "${1}-dev.rdevopsb89.online," roboshop.yml -e component_name="${1}" -e ansible_user=devops -e ansible_password=Devops@12345

ansible-playbook --inventory="frontend-dev.kanchanadevisujan.online," roboshop.yml -e component_name=frontend -e ansible_user=devops -e ansible_password=Devops@12345


ansible-playbook --inventory="mysql-dev.kanchanadevisujan.online," roboshop.yml -e component_name=mysql -e ansible_user=devops -e ansible_password=Devops@12345


ansible-playbook --inventory="catalogue-dev.kanchanadevisujan.online," roboshop.yml -e component_name=catalogue -e ansible_user=devops -e ansible_password=Devops@12345
