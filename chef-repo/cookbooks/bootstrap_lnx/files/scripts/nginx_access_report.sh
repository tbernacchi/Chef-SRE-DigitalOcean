#!/bin/bash
## Desenvolva um script que parseie o log de acesso do servidor Web,
## o mesmo deverá rodar diariamente e enviar por e-mail um simples relatório,
## com a frequência das requisições e o respectivo código de resposta (ex:5 /index.html 200).
FILE="/var/log/nginx/access.log"

nginx_report() {
	/bin/cat /var/log/nginx/access.log | awk '{ print $7,$9 }' | sort| uniq -c > report.txt
	/bin/mail -s "Nginx access.log report - `date +%d/%m/%Y`" tbernacchi@gmail.com < report.txt
	rm -f report.txt
}
nginx_report
