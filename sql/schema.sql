
-- Genes

DROP TABLE IF EXISTS genes;
CREATE TABLE genes (
  id INTEGER PRIMARY KEY NOT NULL,
  ensembl_id VARCHAR(255) NOT NULL UNIQUE,
  biotype VARCHAR(255)
  -- hgnc_id VARCHAR UNIQUE
);

-- Tissues

DROP TABLE IF EXISTS tissues;
CREATE TABLE tissues (
  id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL UNIQUE
);

-- Gene expressions

DROP TABLE IF EXISTS expressions;
CREATE TABLE expressions (
  id INTEGER PRIMARY KEY NOT NULL,
  expression FLOAT NOT NULL,

  gene_id INTEGER NOT NULL,
  tissue_id INTEGER NOT NULL
);

-- Orthologs

DROP TABLE IF EXISTS ortholog_genes;
CREATE TABLE ortholog_genes (
  id INTEGER PRIMARY KEY NOT NULL,

  species VARCHAR(255) NOT NULL,
  ensembl_id VARCHAR(255) NOT NULL,
  gene_id INTEGER NOT NULL,

  dn FLOAT,
  ds FLOAT,
  dnds FLOAT
);

-- Gene ontology terms

DROP TABLE IF EXISTS gene_ontology_terms;
CREATE TABLE gene_ontology_terms (
  id INTEGER PRIMARY KEY NOT NULL,

  accession VARCHAR(255) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  domain VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS gene_ontology_terms_genes;
CREATE TABLE gene_ontology_terms_genes (
  id INTEGER PRIMARY KEY NOT NULL,

  gene_ontology_term_id INTEGER NOT NULL,
  gene_id INTEGER NOT NULL
);
