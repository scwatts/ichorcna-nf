process ICHORCNA_RUN {
    tag "$meta.id"
    label 'process_low'

    // WARN: Version information not provided by tool on CLI. Please update version string below when bumping container versions.
    conda (params.enable_conda ? "bioconda::r-ichorcna=0.3.2" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/r-ichorcna:0.3.2--r41hdfd78af_0' :
        'quay.io/biocontainers/r-ichorcna:0.3.2--r41hdfd78af_0' }"

    input:
    tuple val(meta), path(tumor_wig), path(normal_wig)
    path gc_wig
    path map_wig
    path panel_of_normals
    path centromere

    output:
    tuple val(meta), path("*.cna.seg")    , emit: optimal_cna_seg
    tuple val(meta), path("*.params.txt") , emit: optimal_params
    path "${meta.id}/*_genomeWide.pdf"    , emit: optimal_genome_plot
    path "${meta.id}/*_genomeWide_n*pdf"  , emit: all_genome_plots
    path "versions.yml"                   , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    def pon = panel_of_normals ? "--normalPanel ${panel_of_normals}" : ''
    def centro = centromere ? "--centromere ${centromere}" : ''
    def normal_wig_arg = normal_wig ? "--NORMWIG ${normal_wig}" : ''
    def VERSION = '0.3.2' // WARN: Version information not provided by tool on CLI. Please update this string when bumping container versions.
    """
    runIchorCNA.R --id ${prefix} \\
        $args \\
        --WIG ${tumor_wig} \\
        ${normal_wig_arg} \\
        --id ${meta.id} \\
        --gcWig ${gc_wig} \\
        --mapWig ${map_wig} \\
        ${pon} \\
        ${centro} \\
        --outDir .

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        ichorcna: $VERSION
    END_VERSIONS
    """

    stub:
    """
    mkdir subdir/
    touch subdir/stub.genomeWide.pdf

    touch stub.cna.seg stub.params.txt versions.yml
    """
}
