#!/usr/bin/env nextflow

params.fastq = "${HOME}/nextflow_projects/nextflow_fastqc/data/*.fastq.gz"
params.outdir = "${HOME}/nextflow_projects/nextflow_fastqc/res/fastqc"

process run_fastqc {
    input:
        path fastq
    output:
        path ""
    script:
        """\
        mkdir -p ${params.outdir}
        fastqc ${fastq} -o ${params.outdir}
        """
}

workflow {
    fastq_list_ch = Channel.fromPath(params.fastq, checkIfExists: true)
    run_fastqc(fastq_list_ch)
    run_fastqc.out.view()
}
