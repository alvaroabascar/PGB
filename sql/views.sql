-- HOUSEKEEPING
DROP VIEW IF EXISTS housekeeping_gene_expressions;
CREATE VIEW housekeeping_gene_expressions AS
  SELECT
    g.ensembl_id as gene_ensembl_id,
    g.biotype as gene_biotype,
    e.gene_id,
    t.name as tissue,
    e.tissue_id,
    e.expression
  FROM
    (
      SELECT
        e.gene_id
      FROM
        expressions e
      WHERE
        e.expression > 1
      GROUP BY gene_id
      HAVING COUNT(tissue_id) = (SELECT COUNT(*) FROM tissues)
    ) AS subgenes,
    genes g,
    tissues t,
    expressions e
  WHERE
    e.gene_id = subgenes.gene_id AND
    g.id = e.gene_id AND
    t.id = e.tissue_id;

-- ALL GENES
DROP VIEW IF EXISTS all_gene_expressions;
CREATE VIEW all_gene_expressions AS
  SELECT
    g.ensembl_id as gene_ensembl_id,
    g.biotype as gene_biotype,
    e.gene_id,
    t.name as tissue,
    e.tissue_id,
    e.expression
  FROM
    (
      SELECT
        e.gene_id
      FROM
        expressions e
      WHERE
        e.expression > 1
      GROUP BY gene_id
      HAVING COUNT(tissue_id) >= 1
    ) AS subgenes,
    genes g,
    tissues t,
    expressions e
  WHERE
    e.gene_id = subgenes.gene_id AND
    g.id = e.gene_id AND
    t.id = e.tissue_id;

-- TISSUE SPECIFIC GENES
DROP VIEW IF EXISTS tissue_specific_gene_expressions;
CREATE VIEW tissue_specific_gene_expressions AS
  SELECT
    g.ensembl_id as gene_ensembl_id,
    g.biotype as gene_biotype,
    e.tissue_id,
    e.gene_id,
    e.expression,
    t2.name as specified_tissue,
    t2.id as specified_tissue_id
  FROM
    genes g,
    tissues t,
    tissues t2,
    expressions e,
    (
      SELECT
        e.gene_id, e.tissue_id
      FROM
        expressions e,
        (
          SELECT DISTINCT
            e.gene_id
          FROM
            expressions e
          WHERE
            e.expression > 1
          GROUP BY gene_id
          HAVING COUNT(tissue_id) <= 3
        ) valid_genes
      WHERE
        e.gene_id = valid_genes.gene_id AND
        e.expression > 1
    ) as gt
  WHERE
    gt.gene_id = e.gene_id AND
    g.id = e.gene_id AND
    t2.id = gt.tissue_id AND
    t.id = e.tissue_id;
