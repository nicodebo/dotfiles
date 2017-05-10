#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Compatibilité Python 3
# from __future__ import unicode_literals, print_function, absolute_import

# Quelques modules de la lib standard
import sys
import os
import subprocess

# Modules additionnels potentiellement présents
# try:
    # import requests
# except ImportError:
    # pass

# Environnement virtuel ?
env = os.environ.get('VIRTUAL_ENV')

if env:
    env_name = os.path.basename(env)

    # Affiche le nom de l'environnement virtuel dans le prompt
    try:
        __IPYTHON__
    except NameError:
        sys.ps1 = '({0}) {1} '.format(env_name, getattr(sys, 'ps1', '>>>'))
    else:
        from IPython.terminal.prompts import Prompts, Token
        class MyPrompt(Prompts):
             def in_prompt_tokens(self, cli=None):
                 return [(Token, '({0})'.format(env_name)),
                         (Token.Prompt, ' >>> ')]
        ip=get_ipython()
        ip.prompts = MyPrompt(ip)

    # Affiche la liste des modules qui ont été installés avec pip
    print("\nVirtualenv '{}' contains:".format(env_name))
    cmd = subprocess.check_output(
        [env + "/bin/pip", "freeze"],
        stderr=subprocess.STDOUT
    )
    try:
        cmd = cmd.decode('utf8')
    except Exception:
        pass

    modules = [
        "'{}'".format(m.split('==')[0])  # exemple: u'Django==1.8.4' => u'Django'
        for m in cmd.strip().split("\n")
    ]
    print(', '.join(sorted(modules)) + '\n')


print('Use Python startup script : {}\n'.format(os.environ.get('PYTHONSTARTUP')))
