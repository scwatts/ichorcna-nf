# ichorCNA example Nextflow pipeline

## Stub runs
> Used to demostrate relation between processes

Run with only BAM/BAI input:
```bash
nextflow run main.nf -params-file params.json -stub
```

Run with pre-generated reference WIG files:
```bash
nextflow run main.nf -params-file params_with_pregen_wigs.json -stub
```
