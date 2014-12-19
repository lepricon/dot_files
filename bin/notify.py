#!/usr/bin/env python

import sys
import pynotify


def argumentsInString():
    body = ""
    for arg in sys.argv[2:]:
        body = body + arg + " "
    return body

def notificate():
    n = pynotify.Notification(sys.argv[1], argumentsInString(), "notification-message-im")
    n.set_urgency(pynotify.URGENCY_NORMAL)
    n.set_timeout(200)
    if not n.show():
            print "Failed to display notification"
            sys.exit(1)

if __name__ == '__main__':
        pynotify.init( "test" )
        notificate()
