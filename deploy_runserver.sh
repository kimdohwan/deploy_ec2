#!/usr/bin/env bash

IDENTITY_FILE="$HOME/.ssh/fc-doh.pem"
USER="ubuntu"
HOST="ec2-52-79-201-93.ap-northeast-2.compute.amazonaws.com"
PROJECT_DIR="$HOME/projects/deploy/ec2-deploy"
SERVER_DIR="/home/ubuntu/project"

CMD_CONNECT="ssh -i ${IDENTITY_FILE} ${USER}@${HOST}"

echo " -Start deploy"

${CMD_CONNECT} "pkill -9 -ef runserver"
echo " -Kill all runserver"

ssh -i ${IDENTITY_FILE} ${USER}@${HOST} rm -rf ${SERVER_DIR}
echo " -Delete server files"

scp -q -i ${IDENTITY_FILE} -r ${PROJECT_DIR} ${USER}@${HOST}:${SERVER_DIR}
echo " -Upload files"

#서버 접속 후 server_dir로 이동, pienv에서 --venv로 가상환경의 경로 가져오기
VENV_PATH=$(${CMD_CONNECT} "cd ${SERVER_DIR} && pipenv --venv")
#가상환겨의 경로에 /bin/python을 붙여 서버에서 사용하는 python의 경로 만들기
PYTHON_PATH="${VENV_PATH}/bin/python"
echo " -Get python path($PYTHON_PATH)"

#runserver를 background에서 실행해주는 커맨드 nohup
RUNSERVER_CMD="nohup ${PYTHON_PATH} manage.py runserver 0:8000 &>/dev/null &"
echo $RUNSERVER_CMD
#서버 접속후 프로젝트의 app폴더까지 이동한 후 runserver 실행
${CMD_CONNECT} "cd ${SERVER_DIR}/app && ${RUNSERVER_CMD}"
echo " -Execute runserver"