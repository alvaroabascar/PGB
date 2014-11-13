#!/usr/bin/env python3

import sys
from Filtering import filter_file, chain_functions, parse_row

TISSUE = 'Brain - Cortex'

if __name__ == '__main__':
    with open(sys.argv[1]) as stream:
        stream.readline() # skip first line
        tissues = stream.readline().strip().split('\t')
        tissue_to_column = {tissue: i-2 for tissue, i in
                                        zip(tissues, range(len(tissues)))}

    # function to parse each row of expressions, and produce True / False
    filtering_func = chain_functions(
            lambda x: parse_row(x),
            lambda x: list(map(lambda y: y > 1, x)),
            lambda x: x[tissue_to_column[TISSUE]] and x.count(True) <= 3)
    parsed_file = filter_file(filtering_func, sys.argv[1], skip = 2)
    print(''.join(parsed_file))
