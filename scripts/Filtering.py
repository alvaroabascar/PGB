#!/usr/bin/env python3

import sys

def chain_functions(*functions):
    """ chain_functions(function1, function2, ...) --> function

    Given a set of functions, return a new function which applies all of
    them to an object, in order.

    Ex. for two functions:
    input: func1, func2
    output: a function f, such that f(object) = func2(func1(object))

    """
    def newfun(x):
        result = x
        for function in functions:
            result = function(result)
        return result
    return newfun

def parse_row(row):
    """ parse_row(row) -> iterable

    Given a row from the GTEX file:
    - remove newline
    - spit by tabs
    - skip first two fields (name and description)
    - turn fields into floats
    - return as iterable

    """
    filter_func = chain_functions(lambda x: x.strip(),
                                  lambda x: x.split('\t'),
                                  lambda x: x[2:],
                                  lambda x: map(float, x))
    return filter_func(row)

def filter_file(filter_func, filename, skip = 0):
    """ filter_file(function, filename, [skip = n]) -> list

    Given a function, a filename and an optional integer 'skip', open the
    file with name filename, skip 'skip' lines and return a list of rows
    for which the function returns true, along with the skipped rows.

    """
    with open(filename, 'r') as stream:
       # read two first lines (headers)
       newcontent = [stream.readline() for i in range(skip)]
       # store all the next lines (name, description, expressions)
       rows = stream.readlines()

    # filter rows for which the function returns true
    filtered_rows = filter(filter_func, rows)

    # join the filtered lines and the headers, which should be conserved
    newcontent.extend(filtered_rows)
    return newcontent
