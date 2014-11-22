#!/usr/bin/env python3

import sys
from Filtering import filter_file, chain_functions, parse_row

TISSUE = 'Brain - Cortex'

if __name__ == '__main__':
    # build list with the gene ids
    with open(sys.argv[2]) as stream:
        stream.readline()
        nc_genes_ts = []
        for line in stream.readlines():
            nc_genes_ts.append(line.split('\t')[0])
    # function to parse each row of expressions, and produce True / False
    filtering_func = lambda x: x.split(' ')[0].split('.')[0] in nc_genes_ts
    parsed_file = filter_file(filtering_func, sys.argv[1], skip = 2)
    print(''.join(parsed_file))
