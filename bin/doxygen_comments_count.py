#!/usr/bin/env python

import sys, re

class State:
    normal = 0
    doxy_comment = 1

comment_multiline_start_1 = re.compile(r"[^/]*/\*\*")
comment_multiline_start_2 = re.compile(r"[^/]*/\*!")
comment_multiline_stop = re.compile(r"\*/")

comment_singleline_1 = re.compile("^\s*///\s")
comment_singleline_2 = re.compile("//!")

doxy_commented_lines = 0
state = State.normal
for line in sys.stdin:
    if state == State.normal:
        if comment_singleline_1.search(line) or comment_singleline_2.search(line):
            doxy_commented_lines += 1
        elif comment_multiline_start_1.search(line) or comment_multiline_start_2.search(line):
            doxy_commented_lines += 1
            state = State.doxy_comment

    if state == State.doxy_comment:
        doxy_commented_lines += 1
        if comment_multiline_stop.search(line):
            state = State.normal

print(doxy_commented_lines)
