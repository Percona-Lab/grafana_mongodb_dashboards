#!/usr/bin/env python

'''
This cleans the items in 'templating', 'time' and 'refresh' section of an exported Grafana
dashboard template by setting the item's 'options' array, 'current' hash to be empty, template 
'refresh' to true and time to now-1h, 10 sec refresh.

This is useful as exported templates contain the current values the developer was testing
with, which should not go into the shared templates
'''

import os
import sys
import json

if len(sys.argv) >= 2:
	fileName = sys.argv[1]
else:
	print "Usage: [template json file]"
	sys.exit(1)

if os.path.isfile(fileName):
	fh = open(fileName)
	data = json.loads(fh.read())
	fh.close()

	if 'templating' in data and 'list' in data['templating']:
		for item in data['templating']['list']:
			item['current'] = {}
			item['options'] = []
			item['refresh'] = True
	else:
		print "ERROR: problem finding 'templating' section in file!"
		sys.exit(1)

        if 'time' in data:
		data['time']['from'] = "now-1h"
		data['time']['to'] = "now"
        else:
                print "ERROR: problem finding 'time' section in file!"
                sys.exit(1)

	if 'refresh' in data:
		data['refresh'] = "10s"
	else:
		print "ERROR: problem finding 'refresh' section in file!"
		sys.exit(1)

	tmpFileName = fileName + ".tmp"
	tmpFh = open(tmpFileName, "w")
	jsonOut = json.dumps(data, sort_keys=True, indent=4, separators=(',', ': '))
	tmpFh.write(jsonOut)
	tmpFh.close()

	os.rename(tmpFileName, fileName)
	print "OK"
else:
	print "ERROR: cannot find file!"
	sys.exit(1)
