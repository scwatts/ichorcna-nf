class WorkflowIchorcna {

  public static get_ichorcna_inputs(ch) {
    // NOTE(SW): assuming single sample, breaking this assumption will cause dangeous problems
    // NOTE(SW): groupTuple here would be blocking anyway since size isn't _directly_ known at
    // run time; there could be a mix of tumor-only and tumor/normal inputs
    ch
      .toList()
      .map { d ->
        def tdata = get_readcount_wig_data(d, 'tumor')
        def ndata = get_readcount_wig_data(d, 'normal')
        [['id': tdata.id], tdata['wig'], ndata.get('wig', [])]
      }
  }

  private static get_readcount_wig_data(d, phenotype) {
    def index = d.findIndexOf { meta, wig -> meta.phenotype == phenotype }
    def ret = ['id': null, 'wig': null]
    if (index != -1) {
      def (meta, wig) = d[index]
      ret['id'] = meta.subject_id
      ret['wig'] = wig
    }
    return ret
  }
}
