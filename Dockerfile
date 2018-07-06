FROM        ec2-deploy:base

ENV         PROJECT_DIR     /srv/project

RUN         apt -y install nginx

COPY        .   ${PROJECT_DIR}
WORKDIR     ${PROJECT_DIR}

#ENV         VENV_PATH $(pipenv --venv) 환경변수 설정 이렇게는 안된다
RUN         export VENV_PATH=$(pipenv --venv); echo $VENV_PATH;
ENV         VENV_PATH       $VENV_PATH

#CMD         pipenv run uwsgi --ini ${PROJECT_DIR}/.config/uwsgi_http.ini

#CMD         nginx -g 'daemon off;'