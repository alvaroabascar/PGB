scripts=$(ls *.r)

a=1
for script in $scripts; do
  printf "Executing $script... "
  R CMD BATCH $script
  printf " [ OK ]\n"
done

rm *Rout
