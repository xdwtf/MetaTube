from flask import Flask, json
from flask.logging import default_handler
from flask_sqlalchemy import SQLAlchemy
from flask_jsglue import JSGlue
from flask_migrate import Migrate
from flask_socketio import SocketIO
from distutils.util import strtobool
from config import Config

import logging
db = SQLAlchemy()
migrate = Migrate()
jsglue = JSGlue()
socketio = SocketIO()

logformat = logging.Formatter(fmt='[%(asctime)s] %(levelname)s [%(filename)s:%(lineno)d]: %(message)s', datefmt='%d-%m-%Y %H:%M')

console = logging.StreamHandler()
console.setFormatter(fmt=logformat)

logger = logging.Logger('default')
logger.addHandler(console)

from metatube.settings import bp as bp_settings
from metatube.overview import bp as bp_overview
from metatube.routes import error

from metatube.init import init as init_db

def create_app(config_class=Config):
    app = Flask(__name__, static_url_path='/static')
    app.config.from_object(config_class)
    app.config.update(
        FLASK_DEBUG=False,
        FLASK_ENV='production'
    )
    app.register_error_handler(Exception, error)
    app.logger.removeHandler(default_handler)
    app.logger.addHandler(logger)
    console.setLevel(int(app.config["LOG_LEVEL"]))
    socket_log = logger if strtobool(str(app.config["SOCKET_LOG"])) == 1 else False
    db.init_app(app)
    migrate.init_app(app, db, compare_type=True, ping_interval=60)
    jsglue.init_app(app)
    socketio.init_app(app, async_mode='gevent', json=json, engineio_logger=socket_log, logger=socket_log) # Allow maximum 10MB to be sent through web sockets
    app.register_blueprint(bp_overview)
    app.register_blueprint(bp_settings)
    init_db(app)
    return app

import metatube.database