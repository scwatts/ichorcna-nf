include { HMMCOPY_READCOUNTER } from '../modules/nf-core/modules/hmmcopy/readcounter/main'
include { ICHORCNA_RUN        } from '../modules/nf-core/modules/ichorcna/run/main'


ch_data = Channel.of(
  [
    [id: params.subject_name],
    file(params.bam, checkIfExists: true),
    file(params.bai, checkIfExists: true),
  ],
)


workflow ICHORCNA {


  HMMCOPY_READCOUNTER(
    ch_data,
  )

  ICHORCNA_RUN(
    HMMCOPY_READCOUNTER.out.wig,
    ch_wig_gc,
    ch_wig_map,
    [], // panel_of_normals (optional)
    [], // centromere (optional)
  )

}
