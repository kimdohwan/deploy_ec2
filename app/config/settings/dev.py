from .base import *

secrets = json.load(open(os.path.join(SECRETS_DIR, 'dev.json')))

# static
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(ROOT_DIR, '.static')

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(ROOT_DIR, '.media')

# wsgi
WSGI_APPLICATION = 'config.wsgi.dev.application'

# db
DATABASES = secrets['DATABASES']
DEBUG = True
print(DATABASES)
# ALLOWED_HOSTS는 로컬에서는 없어도 localhost로 자동설정 됨
# ALLOWED_HOSTS = [
#     'localhost',
#     '.amazonaws.com',
#     '127.0.0.1',
# ]
