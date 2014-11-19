-- HOUSEKEEPING
DROP VIEW IF EXISTS housekeeping_genes;
CREATE VIEW housekeeping_genes AS
  SELECT DISTINCT
    g.*
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
    genes g
  WHERE
    g.id = subgenes.gene_id;

-- ALL GENES
DROP VIEW IF EXISTS all_genes;
CREATE VIEW all_genes AS
  SELECT DISTINCT
    g.*
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
    genes g
  WHERE
    g.id = subgenes.gene_id;

-- TISSUE SPECIFIC GENES
DROP VIEW IF EXISTS tissue_specific_genes;
CREATE VIEW tissue_specific_genes AS
  SELECT
    g.*,
    t.id AS specific_tissue_id,
    t.name AS specific_tissue_name
  FROM
    genes g,
    tissues t,
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
    gt.gene_id = g.id AND
    t.id = gt.tissue_id;
