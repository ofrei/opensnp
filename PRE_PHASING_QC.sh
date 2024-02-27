prefix=$1
output=$2
PLINK=plink

$PLINK --bfile $prefix --chr 1-22 --out $prefix.step0 --make-bed || true
$PLINK --bfile $prefix.step0 --list-duplicate-vars ids-only suppress-first --out $prefix.step1a || true
$PLINK --bfile $prefix.step0 --exclude $prefix.step1a.dupvar --make-bed --out $prefix.step1a || true
$PLINK --bfile $prefix.step1a --snps-only just-acgt --make-bed --out $prefix.step1b || true

awk '{ if (($5=="T" && $6=="A")||($5=="A" && $6=="T")||($5=="C" && $6=="G")||($5=="G" && $6=="C")) print $2, "ambig" ; else print $2 ;}' $prefix.step1b.bim | grep ambig > $prefix.step1b.snplist.txt  || true
$PLINK --bfile $prefix.step1b --exclude $prefix.step1b.snplist.txt --make-bed --out $output || true

