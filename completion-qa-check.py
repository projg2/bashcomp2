#!/usr/bin/env python
# QA check for issues with bash completion autoloader.
# Usage:
#  ./get-completions | ./completion-qa-check.py

import os.path, sys

def main(*args):
	compdb = {}
	all_cmds = set()
	all_files = set()

	for l in sys.stdin:
		path, *compls = l.split()
		bn = os.path.basename(path)
		rpath = os.path.realpath(path)

		all_files.add(bn)

		if not compls:
			print('%s: does not declare any completions (load error?)' % bn)
		elif bn not in compls:
			print('%s: does not declare completion for %s' % (bn, bn))

		for c in compls:
			if c in compdb and compdb[c] != rpath:
				print('%s: duplicate completion for %s (previously in %s)'
						% (bn, c, compdb[c]))
			compdb[c] = rpath

			if c.startswith('/'):
				print('%s: absulute paths in completions can not work (have: %s)'
						% (bn, c))
			else:
				all_cmds.add(c)

	for c in all_cmds:
		if c not in all_files:
			print('%s: missing completion symlink for command (declared in %s)'
					% (c, compdb[c]))

if __name__ == '__main__':
	sys.exit(main(*sys.argv[1:]))
