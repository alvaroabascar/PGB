#!/usr/bin/env bash

rm -f data.sqlite

sqlite3 data.sqlite < schema.sql
sqlite3 data.sqlite < views.sql

python3 load_data.py
