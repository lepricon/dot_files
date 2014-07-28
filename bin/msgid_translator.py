#! /usr/bin/env python

import sys, re, io, os

def universal_upper(string):
    if isinstance(string, str):
        return str.upper(string)
    elif isinstance(string, unicode):
        return unicode.upper(string)
    return string

def scan_file_for_msgids(file, dictionary):
    for line in file:
        m = re.search("#define\s+([0-9A-Z_]+)\s+0x([0-9a-fA-F]{4})", line)
        if not (m is None):
            dictionary[universal_upper(m.group(2))] = m.group(1)

def fill_dictionary_from_file(path, dictionary):
    try:
        file = io.open(path)
        scan_file_for_msgids(file, dictionary)
        file.close()
    except IOError: #as err:
        print("ERROR: File not found: " + path)

def sub_using_regex(line, regex,  dictionary):
    msgids = re.findall(regex, line)
    new_line = line
    for msgid in msgids:
        try:
            new_line = re.sub("0x" + msgid, "<" + dictionary[universal_upper(msgid)] + " (0x" + msgid + ")>", new_line)
        except KeyError: # as e:
           None # print("ERROR: msgId not found: \'" + universal_upper(msgid) + "\' in \n" + line) 
    return new_line

def substitute_msgids(log_path, dictionary):
    new_log_path = re.sub(r"(.+)\.(\w+)", r"\1.msgid.\2", log_path)
    new_log_file = io.open(new_log_path, "w")
    log_file = io.open(log_path)
    for line in log_file:
        if len(line) > 1:
            new_line = line
            new_line = sub_using_regex(new_line, "[mM]sgId\s*[=:]\s{0,1}0x([a-fA-F0-9]{4})", dictionary)
            new_line = sub_using_regex(new_line, "pay.oadId\W+0x([a-fA-F0-9]{4})", dictionary)
            new_line = sub_using_regex(new_line, "id:\s*0x([a-fA-F0-9]{4})", dictionary)
            new_line = sub_using_regex(new_line, "\(0x([a-fA-F0-9]{4}),", dictionary)
            new_log_file.write(new_line)

    log_file.close()
    new_log_file.close()
    print("Output was written to: " + new_log_path)

if __name__ == "__main__":
    path_external_msgs = "_Internal_Interfaces/DIR_ENV/I_Interface/Application_Env/Ln_Env/Messages/MessageId_Lte.h"
    path_uec_internal_msgs = "C_Application/SC_UEC/CP_InterfacesInt/Include/Messages/UecMessagesId.hpp"

    if len(sys.argv) > 1:
        log_path = sys.argv[1]
        if len(sys.argv) > 2:
            path_external_msgs = sys.argv[2]
            if len(sys.argv) > 3:
                path_uec_internal_msgs = sys.argv[3]
    else:
        print("USAGE: " + sys.argv[0] + " <app_log_filename> [<path to MessageId_Lte.h>] [<path to UecMessages.hpp>]")
        sys.exit(1)

#    print("Path to external messages: " + path_external_msgs)
#    print("Path to UEC internal messages: " + path_uec_internal_msgs)

    dictionary = {}
    fill_dictionary_from_file(path_external_msgs, dictionary)
    fill_dictionary_from_file(path_uec_internal_msgs, dictionary)

    substitute_msgids(log_path, dictionary)

