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

## Reference files

HMMcopy resource files are specific to reference assembly and read library format. I have generated resource files for
our hg38 assembly version and 151 bp library format. These are located in `./data/resource_files/`.

See [RESOURCE_FILES.md](RESOURCE_FILES.md) for further details.
