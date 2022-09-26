include { HMMCOPY_READCOUNTER } from '../modules/nf-core/modules/hmmcopy/readcounter/main'
include { ICHORCNA_RUN        } from '../modules/nf-core/modules/ichorcna/run/main'


ch_data_tumor = Channel.of(
  [
    [id: params.tumor_id, 'phenotype': 'tumor', 'subject_id': params.subject_id],
    file(params.tumor_bam, checkIfExists: true),
    file(params.tumor_bai, checkIfExists: true),
  ],
)

if (params.normal_bam) {
  ch_data_normal = Channel.of(
    [
      [id: params.normal_id, 'phenotype': 'normal', 'subject_id': params.subject_id],
      file(params.normal_bam, checkIfExists: true),
      file(params.normal_bai, checkIfExists: true),
    ],
  )
  ch_data = ch_data_tumor.mix(ch_data_normal)
} else {
  ch_data = ch_data_tumor
}


ch_centromeres = file(params.centromeres, checkIfExists: true)
ch_wig_gc = file(params.wig_gc, checkIfExists: true)
ch_wig_map = file(params.wig_map, checkIfExists: true)
if (params.panel_of_normals) {
  ch_panel_of_normals = file(params.panel_of_normals, checkIfExists: true)
} else {
  ch_panel_of_normals = []
}


workflow ICHORCNA {

  HMMCOPY_READCOUNTER(
    ch_data,
  )

  ch_inchorcna_inputs = WorkflowIchorcna.get_ichorcna_inputs(HMMCOPY_READCOUNTER.out.wig)
  ICHORCNA_RUN(
    ch_inchorcna_inputs,
    ch_wig_gc,
    ch_wig_map,
    ch_panel_of_normals,
    ch_centromeres,
  )

}
