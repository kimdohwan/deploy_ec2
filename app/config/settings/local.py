from .base import *

# static
STATIC_URL = '/static/'
MEDIA_URL = '/media/'
STATIC_ROOT = os.path.join(ROOT_DIR, '.static')
MEDIA_ROOT = os.path.join(ROOT_DIR, '.media')

# wsgi
WSGI_APPLICATION = 'config.wsgi.application'

# db
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}

DEBUG = True

ALLOWED_HOSTS = [
    'localhost',
    '.amazonaws.com',
    '127.0.0.1',
]
