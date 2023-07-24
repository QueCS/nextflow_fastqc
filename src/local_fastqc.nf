#!/usr/bin/env nextflow

params.fastq = "${HOME}/nextflow_projects/nextflow_fastqc/data/*.fastq.gz"
params.outdir = "${HOME}/nextflow_projects/nextflow_fastqc/res"

fastq_list_ch = Channel.fromPath(params.fastq, checkIfExists: true)

process run_fastqc {
    publishDir params.outdir, mode: "copy"
    tag "${fastq}"
    input:
        path fastq
    output:
        path("fastqc_${fastq}_logs"), emit: fastqc_ch
    script:
        """\
        mkdir -p fastqc_${fastq}_logs
        fastqc -o fastqc_${fastq}_logs -q ${fastq}
        """
}

workflow {
    run_fastqc(fastq_list_ch)
}
