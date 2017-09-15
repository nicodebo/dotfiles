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

# Enable completion in the standard python shell if jedi is installed
# http://jedi.readthedocs.io/en/latest/docs/usage.html#tab-completion-in-the-python-shell
try:
    from jedi.utils import setup_readline
    setup_readline()
except ImportError:
    # Fallback to the stdlib readline completer if it is installed.
    # Taken from http://docs.python.org/2/library/rlcompleter.html
    print("Jedi is not installed, falling back to readline")
    try:
        import readline
        import rlcompleter
        readline.parse_and_bind("tab: complete")
    except ImportError:
        print("Readline is not installed either. No tab completion is enabled.")


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
