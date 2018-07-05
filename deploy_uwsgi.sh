#!/usr/bin/env bash

IDENTITY_FILE="$HOME/.ssh/fc-doh.pem"
USER="ubuntu"
HOST="ec2-52-79-201-93.ap-northeast-2.compute.amazonaws.com"
PROJECT_DIR="$HOME/projects/deploy/ec2-deploy"
SERVER_DIR="/home/ubuntu/project"

CMD_CONNECT="ssh -i ${IDENTITY_FILE} ${USER}@${HOST}"

echo " -Start deploy"

echo " -Kill all runserver"

ssh -i ${IDENTITY_FILE} ${USER}@${HOST} rm -rf ${SERVER_DIR}
echo " -Delete server files"

scp -q -i ${IDENTITY_FILE} -r ${PROJECT_DIR} ${USER}@${HOST}:${SERVER_DIR}
echo " -Upload files"

${CMD_CONNECT} "pkill -9 -ef :8000"
${CMD_CONNECT} "pkill -9 -ef uwsgi"
UWSGI_PATH="/home/ubuntu/.local/share/virtualenvs/project-ipe16O64/bin/uwsgi"

${CMD_CONNECT} "cd ${SERVER_DIR} && nohup ${UWSGI_PATH} --ini .config/uwsgi_http_web.ini &>/dev/null &"
echo " -UWSGI server execute"

#VENV_PATH=$(${CMD_CONNECT} "cd ${SERVER_DIR} && pipenv --venv")
#UWSGI_PATH="${VENV_PATH}/bin/uwsgi"
#echo " -Get python path($UWSGI_PATH)"

#UWSGI_CMD="nohup /home/ubuntu/.local/share/virtualenvs/project-ipe16O64/bin/uwsgi \
#--http :8000 \
#--home /home/ubuntu/.local/share/virtualenvs/project-ipe16O64 \
#--chdir /home/ubuntu/project/app \
#--module config.wsgi &>/dev/null &"
#echo $UWSGI_CMD
#${CMD_CONNECT} "cd ${SERVER_DIR} && ${UWSGI_CMD}"
#echo " -Execute runserver"

#uwsgi \
#--http :8000 \
#--home /home/ubuntu/.local/share/virtualenvs/project-ipe16O64 \
#--chdir /home/ubuntu/project/app \
#--module config.wdgi