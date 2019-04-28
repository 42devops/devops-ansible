health:
	@ansible-playbook -i environments/prod health.yml
ping:
	@ansible -i environments/prod all -m ping
bkstatus:
	@ansbile -i environments/prod backend_server -m shell -a "sudo supervisorctl status"
login_error:
	@ansbile -i environments/prod iam_server -m shell -a "grep -i $(iam_username) /opt/dss/log/keycloak/server.log* |grep error"
download:
	@echo "start download local install file to ./script/binaries dir."
	@script/download.sh
	@echo "done~ Enjoy!"
dist:
	@echo "start copy local install file to ./roles/X/files dir."
	@rsync -a script/binaries/prometheus-*.tar.gz roles/prometheus/files
	@rsync -a script/binaries/node_exporter-*.tar.gz roles/node_exporter/files
	@rsync -a script/binaries/blackbox_*.tar.gz roles/blackbox_exporter/files
	@rsync -a script/binaries/mysqld_*.tar.gz roles/mysql_exporter/files
	@rsync -a script/binaries/alertmanager-*.tar.gz roles/alertmanager/files
	@echo "done~ Enjoy!"
encrypt:
	@ansbile-vault encrypt environments/prod/hosts
decrypt:
	@ansible-vault decrypt environments/prod/hosts