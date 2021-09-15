# How To:
## Store ENV Variables in Django/Wagtail
*Source:* [GrimmStar](https://github.com/Grimmstar/.dotfiles)

This *How-To* assumes that an already existing Django project is being used.
It will not cover the steps to install and create said project.

## [Python-Decouple](https://github.com/henriquebastos/python-decouple/)
Install `python-decouple` into the virtualenv using `pip`:
```bash
pip install python-decouple

# Add to requirements.txt
pip freeze > requirements.txt
```

## Setting things up
The application settings can be stored either in environment variables or in a `.env` file at the project root (where `manage.py` exists). Decouple will search for these in below order
1. Environment variables
2. In .env file at project root
Create an `.env` file in the project root and add all `settings` variables that you want to keep private, with a single variable and value per line. Do not include quotation marks.
```
# .env

# Key Config
SECRET_KEY=example_secret_key
API_KEY=exampleapitoken

# Debug Config
DEBUG=True
TEMPLATE_DEBUG=True

# Hosts Config
ALLOWED_HOSTS=.localhost, .herokuapp.com, 127.0.0.1
INTERNAL_IPS=127.0.0.1

# Database Config
DB_NAME=example_database
DB_USER=example_user
DB_PASSWORD=example_password
DB_HOST=127.0.0.1

# Email Config
EMAIL_PORT=25
EMAIL_HOST=smtp.exampledomain.com
```

## Updating the settings
The values stored in `.env` file or environment variables can be used in application via `config` object. By default, `config` returns a `string`. But Django needs values for `settings` such as `DEBUG` to be a boolean and `EMAIL_PORT` to be a integer. An additional parameter, ‘cast’, can be added to `config` so that value will be converted to a specified type before assignment.

With the above example, modify the settings file as follows:
```
# settings/base.py

import os
from decouple import config, Csv

SECRET_KEY = config('SECRET_KEY')

# Debug must be either `True` or `False`, so tell `python-decouple` that it is looking for a boolean value:
DEBUG = config('DEBUG', cast=bool)
TEMPLATE_DEBUG = config('TEMPLATE_DEBUG', default=True, cast=bool)
# You can also set default values, in case the variable isn't defined in the .env file

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': config('DB_NAME'),
        'USER': config('DB_USER'),
        'PASSWORD': config('DB_PASSWORD'),
        'HOST': config('DB_HOST'),
        'PORT': '',
    }
}

# It expects `EMAIL_PORT` to be an integer.
EMAIL_PORT = config('EMAIL_PORT', cast=int)
EMAIL_HOST = config('EMAIL_HOST')

# In the case of the `ALLOWED_HOSTS`, Django expects a list:
ALLOWED_HOSTS = config('ALLOWED_HOSTS', cast=Csv())

# Same with `INTERNAL_IPS`:
INTERNAL_IPS = config('INTERNAL_IPS', cast=Csv())
```

## Update `.gitignore`
To keep the variables a secret, you don't want to include them with the source code.
```
# .gitignore

# Environments
env/*
venv/*
.venv/*

.env
```

It's also a good idea to keep a `.env.example` template in the root of the project, for other users:
```
# .env.example

# Key Config
SECRET_KEY=
API_KEY=

# Debug Config
DEBUG=
TEMPLATE_DEBUG=

# Hosts Config
ALLOWED_HOSTS=
INTERNAL_IPS=

# Database Config
DB_NAME=
DB_USER=
DB_PASSWORD=
DB_HOST=

# Email Config
EMAIL_PORT=
EMAIL_HOST=
```

