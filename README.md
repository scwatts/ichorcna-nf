# ichorCNA Nextflow pipeline

## nf-core modules changes

I've modified the nf-core `ichorcna/run` module to allow tumour-only and tumour/normal inputs. Stubs have also been
added to each module.

## Stub runs
> Used to demostrate relation between processes

```bash
nextflow run main.nf -params-file params.json -stub
```

## Misc

The centromere file downloaded from:
<https://raw.githubusercontent.com/broadinstitute/ichorCNA/master/inst/extdata/GRCh38.GCA_000001405.2_centromere_acen.txt>
