-- all genes (but can be changed)

-- SELECT
--   count(gene_id)*100.0 / (SELECT count(*) FROM tissue_specific_genes g WHERE g.specific_tissue_name = 'Brain - Cortex') as percent,
--   got.name,
--   got.domain
-- FROM
--   gene_ontology_terms got,
--   gene_ontology_terms_genes gotg,
--   tissue_specific_genes g
-- WHERE
--   g.specific_tissue_name = 'Brain - Cortex' AND
--   got.id = gotg.gene_ontology_term_id AND
--   g.id = gotg.gene_id AND
--   got.domain = 'biological_process'
-- GROUP BY got.id
-- ORDER BY count(gene_id) DESC;

-- SELECT
--   (count(got.id) * 100.0 / total.total) AS percent,
--   got.name
-- FROM
--   gene_ontology_terms got,
--   gene_ontology_terms_genes gotg,
--   tissue_specific_genes g,
--   (
--     SELECT
--       count(*) AS total
--     FROM
--       gene_ontology_terms got,
--       gene_ontology_terms_genes gotg,
--       tissue_specific_genes g
--     WHERE
--       g.specific_tissue_name = 'Brain - Cortex' AND
--       got.id = gotg.gene_ontology_term_id AND
--       g.id = gotg.gene_id AND
--       got.domain = 'biological_process'
--   ) AS total
-- WHERE
--   g.specific_tissue_name = 'Brain - Cortex' AND
--   got.id = gotg.gene_ontology_term_id AND
--   g.id = gotg.gene_id AND
--   got.domain = 'biological_process'
-- GROUP BY got.id
-- ORDER BY count(g.id) DESC;

SELECT
  count(got.id),
  total.total,
  -- (count(got.id) * 100.0 / total.total) AS percent,
  got.name
FROM
  gene_ontology_terms got,
  gene_ontology_terms_genes gotg,
  all_genes g,
  (
    SELECT
      count(*) AS total
    FROM
      gene_ontology_terms got,
      gene_ontology_terms_genes gotg,
      all_genes g
    WHERE
      got.id = gotg.gene_ontology_term_id AND
      g.id = gotg.gene_id AND
      got.domain = 'biological_process'
  ) AS total
WHERE
  got.id = gotg.gene_ontology_term_id AND
  g.id = gotg.gene_id AND
  got.domain = 'biological_process'
GROUP BY got.id
ORDER BY count(g.id) DESC;
