# ichorCNA Nextflow pipeline

## nf-core modules changes

I've modified the nf-core `ichorcna/run` module to:

* allow tumour-only and tumour/normal inputs,
* include a stub section, and
* use functioning container images

## Stub runs

> Used to demostrate relation between processes

```bash
nextflow run main.nf -params-file params.json -stub
```
