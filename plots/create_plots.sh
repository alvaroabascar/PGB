R CMD BATCH boxplot_expr_all.r
echo "1 done"
R CMD BATCH boxplot_expr_hk.r
echo "2 done"
R CMD BATCH boxplot_expr_ts_nmost.r
echo "3 done"
R CMD BATCH boxplot_expr_ts.r
echo "4 done"
R CMD BATCH ncrna.r
echo "5 done"
rm *Rout
