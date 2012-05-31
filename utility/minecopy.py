#!/usr/bin/python
import time,sys
from ctypes import *

key_press_delay = 10000
editor_wait_delay = 0.1
xdo=cdll.LoadLibrary("libxdo.so.2")
xdo_context=xdo.xdo_new(None)

def typeout(string):
    xdo.xdo_type(xdo_context, 0, string, key_press_delay)

def typekeys(keysyms):
    for key in keysyms:
	xdo.xdo_keysequence(xdo_context, 0, key, key_press_delay)
	time.sleep(editor_wait_delay)

def copyfile(filename):
    f = open(filename)
    data = f.read()
    typeout("rm "+filename[:-4]+"\nedit "+filename[:-4]+"\n")
    time.sleep(editor_wait_delay)
    typeout(data)
    typekeys(["ctrl","Return","ctrl","Left","Return"])

if __name__ == "__main__":
    print "Select minecraft window now!"
    time.sleep(5)
    for filename in sys.argv[1:]:
        copyfile(filename)
