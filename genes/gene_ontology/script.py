#!/usr/bin/env python3

import sys

def parse(filename, fileout):
    with open(filename, 'r') as stream:
        lines = [line.strip().split() for line in stream.readlines()]
    for line in lines:
        line.pop(1) 

    for i in range(len(lines)):
        lines[i][0] += '#'
        lines[i] = lines[i][0] + ' '.join(lines[i][1:])

    with open(fileout, 'w') as stream:
        stream.write('\n'.join(lines))


if __name__ == '__main__':
  parse(sys.argv[1], sys.argv[2])
