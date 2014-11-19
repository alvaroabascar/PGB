#!/usr/bin/env python3

import sqlite3
import csv, gzip

# open database
db_connection = sqlite3.connect("data.sqlite")
db_cursor = db_connection.cursor()

# read main file to load
main_file = "../data/GTEx_Analysis_RNA-seq_selected_tissues.txt.gz"

with gzip.open(main_file, mode='rt') as csv_file:
    # the first line is pure shit
    csv_file.readline()
    # now we create the reader with the right header
    reader = csv.DictReader(csv_file, delimiter="\t")

    # fill in tissues
    tissue_ids = {}
    for tissue in reader.fieldnames:
        if tissue != 'Gene' and tissue != 'Protein':
            db_cursor.execute("INSERT INTO tissues (name) VALUES (?)", [tissue])
            tissue_ids[tissue] = db_cursor.lastrowid
    db_connection.commit()

    # fill in genes & expressions
    for row in reader:
        # create gene
        db_cursor.execute("INSERT INTO genes (ensembl_id) VALUES (?)", [row['Gene'].split(".")[0]])
        gene_id = db_cursor.lastrowid
        for key, value in row.items():
            if key != 'Protein' and key != 'Gene':
                # add expression to tissue and gene
                db_cursor.execute("INSERT INTO expressions (gene_id, tissue_id, expression) VALUES (?,?,?)", [gene_id, tissue_ids[key], value])

# fill in dn and ds values in mouse orthologs
dnds_file = "../data/absolutely_all_genes_dnds.txt"
with open(dnds_file, mode='rt') as csv_file:
    # create reader
    reader = csv.DictReader(csv_file, delimiter="\t")

    for row in reader:
        if row['Ensembl Gene ID'] and row['Mouse Ensembl Gene ID'] and row['dN'] and row['dS']:
            db_cursor.execute("SELECT id FROM genes WHERE ensembl_id = ?", [row['Ensembl Gene ID']])
            gene_id = db_cursor.fetchone()[0]

            if gene_id:
                #insert row in orthologs
                db_cursor.execute("INSERT INTO ortholog_genes (species, ensembl_id, gene_id, dn, ds, dnds) VALUES (?, ?, ?, ?, ?, ?)", ['Mus musculus', row['Mouse Ensembl Gene ID'], gene_id, float(row['dN']), float(row['dS']), float(row['dN'])/float(row['dS'])])

# fill in dn and ds values in mouse orthologs
biotype_file = "../data/absolutely_all_genes_biotype.txt"
with open(biotype_file, mode='rt') as csv_file:
    # create reader
    reader = csv.DictReader(csv_file, delimiter="\t")

    for row in reader:
        if row['Ensembl Gene ID'] and row['Gene Biotype']:
            db_cursor.execute("UPDATE genes SET biotype = ? WHERE ensembl_id = ?", [row['Gene Biotype'], row['Ensembl Gene ID']])

db_connection.commit()
db_connection.close()

