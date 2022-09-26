# Creating reference files

## Reference read and GC counts

Create BowTie1 indices for our 1000genomes hg38 noalt (unpatched) genome, then create 1-bp resolution mappability bigwig
for 151 bp reads

> Creating this bigwig can take around 24 hours. The bowtie process *must* produce position-ordered output so not easy
> to optimise without larger changes to the associated scripts.

```bash
mkdir -p 1_reference_counts/ data/

ln -s /Users/stephen/repos/reference_data/reference_data/genomes/hg38_noalt.fa ./data/
generateMap.pl -b data/hg38_noalt.fa

read_length=151
generateMap.pl \
  --window ${read_length} \
  --output 1_reference_counts/hg38_noalt.fa.map.${read_length}.bw \
  ./data/hg38_noalt.fa
```

For each given window size generate GC count wig and generate mappability wig file from 1-bp resolution mappaibilty bigwig

```bash
chromosomes="$(echo chr{1..22} | tr ' ' ,),chrX"

window_sizes="500000 1000000"
for window_size in ${window_sizes}; do

  mapCounter > 1_reference_counts/hg38_noalt.fa.map_counts.${read_length}.${window_size}.wig \
    --window ${window_size} \
    --chromosome ${chromosomes} \
    1_reference_counts/hg38_noalt.fa.map.${read_length}.bw;

  gcCounter > 1_reference_counts/hg38_noalt.fa.gc.${window_size}.wig \
    --window ${window_size} \
    --chromosome ${chromosomes} \
    ./data/hg38_noalt.fa;

done
```

## Other

```bash
mkdir -p 2_other/

URL_BASE=https://github.com/broadinstitute/ichorCNA/raw/master/inst/extdata

# GRCh38 centromere
wget -P 2_other/ ${URL_BASE}/GRCh38.GCA_000001405.2_centromere_acen.txt

# 1000 kb, 500 kb window panel of normals
wget -P 2_other/ ${URL_BASE}/HD_ULP_PoN_hg38_1Mb_median_normAutosome_median.rds
wget -P 2_other/ ${URL_BASE}/HD_ULP_PoN_hg38_500kb_median_normAutosome_median.rds
```
