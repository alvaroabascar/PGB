#!/usr/bin/env python3

import sys
from Filtering import filter_file, chain_functions, parse_row

if __name__ == '__main__':
    # function to parse each row of expressions, and produce True / False
    filtering_func = chain_functions(lambda x: parse_row(x),
                                     lambda x: map(lambda y: y > 1, x),
                                     lambda x: all(x))
    parsed_file = filter_file(filtering_func, sys.argv[1], skip = 2)
    print(''.join(parsed_file))

