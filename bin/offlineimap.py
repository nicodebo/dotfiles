#! /usr/bin/env python2
# -*- coding: utf-8 -*-

import subprocess
import sys
import logging
import os
import errno
from logging.handlers import RotatingFileHandler


def mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as exc:  # Python >2.5
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise


# Create a logger object
logger = logging.getLogger()
# Set logger to debug mode so that everything is captured
logger.setLevel(logging.DEBUG)
# format logger output time, level, message
formatter = logging.Formatter('%(asctime)s :: %(levelname)s :: %(message)s')
# create a handler that output log to a file in append mode with 1 backup and
# max size of 1Mo
log_file = os.path.join(os.getenv('XDG_CACHE_HOME'), 'offlineimap', 'get_pass.log')
# make sure the dir storing the log file exists
# os.makedirs(os.path.dirname(log_file), exist_ok=True) # python3
mkdir_p(os.path.dirname(log_file))
file_handler = RotatingFileHandler(log_file, 'a', 1000000, 1)
# on lui met le niveau sur DEBUG, on lui dit qu'il doit utiliser le formateur
# créé précédement et on ajoute ce handler au logger
file_handler.setLevel(logging.DEBUG)
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)


def get_pass(account):
    password_prg = "pass"
    mail_prefix = "Mail/"
    cmd = "{} {}{}".format(password_prg, mail_prefix, account)
    try:
        output = subprocess.check_output(cmd, shell=True).splitlines()[0]
    except subprocess.CalledProcessError as e:
        logger.exception("cmd: {} : failed".format(cmd))
        sys.exit("error getting passwords, see {}".format(log_file))
    else:
        logger.info("cmd: {} : succeed".format(cmd))
        return output.splitlines()[0]

# comment out the following lines for test purpose
# if __name__ == "__main__":
#     print("test user@email4.com")
#     print(get_pass("user@email4.com"))
