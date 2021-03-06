#!/usr/bin/env python3

import traceback
import os
from mpd import MPDClient


def checktag():
    client = MPDClient()

    mpd_host = 'localhost'
    mpd_port = '6600'
    mpd_pass = ''

    if 'MPD_HOST' in os.environ:
        mpd_connection = os.environ['MPD_HOST'].split('@')
        if len(mpd_connection) == 1:
            mpd_host = mpd_connection[0]
        elif len(mpd_connection) == 2:
            mpd_host = mpd_connection[1]
            mpd_pass = mpd_connection[0]
        else:
            print('Unable to parse MPD_HOST, using defaults')

    if 'MPD_PORT' in os.environ:
        mpd_port = os.environ['MPD_PORT']

    client.connect(mpd_host, mpd_port)
    if mpd_pass:
        client.password(mpd_pass)

    search = input("Which tag to search for? (album, albumartist, date)> ")
    tagpool = client.search('filename', '')

    for tag in tagpool:
        newpool = []
        if 'directory' not in tag:
            if search not in tag:
                newpool.append(tag)
        for entry in newpool:
            if 'file' in entry:
                print(entry['file'])


def main():
    checktag()


try:
    main()
except Exception as e:
    print(traceback.format_exc())
