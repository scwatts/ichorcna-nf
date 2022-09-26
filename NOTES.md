* aim is to observe how CNV segments reported by ichorCNA compare to FFPE WGS PURPLE results
    - may need to tune parameters futher, change PON, etc

* bin size should be >=500_000 where no matched normal since germline CNVs may confound, can be lower with matched
  normal
    - https://github.com/broadinstitute/ichorCNA/issues/42

* author generally trusts results generated using 1_000_000 windows
    - https://github.com/broadinstitute/ichorCNA/issues/42

* creation of PON
    - pregen one for only 1000 kb and 500kb windows
    - composition not immediately clear
    - https://github.com/broadinstitute/ichorCNA/wiki/Create-Panel-of-Normals

* detection limit: reliable down to 3% TFx at ~0.1x whole genome coverage
    - https://github.com/broadinstitute/ichorCNA/issues/16

* for chromosomes with lower coverage, they can be excluded from training

* all solutions should be examined

* impact of excluding ALT alignments unknown
