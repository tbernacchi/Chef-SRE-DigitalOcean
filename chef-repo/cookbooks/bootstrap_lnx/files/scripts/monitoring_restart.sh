#!/bin/bash
## A fim de garantir a disponibilidade do serviço,
## deverá estar funcional uma monitoração do processo Node e Web para caso de falha,
## o mesmo deve reiniciar ou subir novamente os serviços em caso de anomalia;

# Lockfile
LOCK="/tmp/nodews-lock"

# Status file
MESSAGE="status.txt"

# Lock
fn_check_lock() {
	if [ -e $LOCK ]; then
		echo "Arquivo de lock $LOCK encontrado, saindo..."
                	exit 0
                else
                        echo $$ > $LOCK
			fn_check_ws
	fi
}

fn_check_ws_ps () {
serv=nginx
PS=`ps -ef | grep $serv | grep -v grep`
	if [ "$?" -eq "1" ]; then
		systemctl start $serv > /dev/null && systemctl status $serv > $MESSAGE
		fn_send_email
	fi
}

fn_check_app_hello (){
serv=hello
PS=`ps -ef | grep node | grep -v grep`
	if [ "$?" -eq "1" ]; then
		systemctl start $serv > /dev/null && systemctl status $serv > $MESSAGE
		fn_send_email
	fi
}


fn_send_email() {
	/bin/mail -s "Service $serv was DOWN on `hostname` and was restarted - `date +%d/%m/%Y`" tbernacchi@gmail.com < $MESSAGE
}

fn_check_ws_ps
fn_check_app_hello
rm -f $MESSAGE
