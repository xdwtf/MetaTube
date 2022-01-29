#!/usr/bin/env python3
# coding: utf-8

from metatube import create_app, socketio
from gevent import get_hub
from distutils.util import strtobool
import os
if __name__ == "__main__":
    app = create_app()
    port = os.environ.get('PORT)
    host = os.environ.get('HOST)
    debug = os.environ.get('DEBUG', False)
    log_output = os.environ.get('LOG', True)
    get_hub().NOT_ERROR += (KeyboardInterrupt,)
    try:
        print(u'Starting the webserver on http://%s:%s...'%(host, port))
        socketio.run(app, str(host), int(port), log_output=strtobool(str(log_output)))
    except KeyboardInterrupt:
        print('Stopped server because of KeyboardInterrupt')
