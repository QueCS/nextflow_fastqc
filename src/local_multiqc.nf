#!/usr/bin/env nextflow

params.fastq = "${HOME}/nextflow_projects/nextflow_fastqc/data/*.fastq.gz"
params.outdir = "${HOME}/nextflow_projects/nextflow_fastqc/res"

fastq_list_ch = Channel.fromPath(params.fastq, checkIfExists: true)

process run_fastqc {
    container = "${HOME}/singularity_images/fastqc_latest.sif"
    publishDir params.outdir, mode: "copy"
    tag "${fastq}"
    input:
        path fastq
    output:
        path("fastqc_${fastq}_logs")
    script:
        """\
        mkdir -p fastqc_${fastq}_logs
        fastqc -o fastqc_${fastq}_logs -q ${fastq}
        """
}

process run_multiqc {
    container = "${HOME}/singularity_images/multiqc_latest.sif"
    publishDir params.outdir, mode: "copy"
    tag "On all fastqc outputs in res/"
    input:
        path("*")
    output:
        path("multiqc_report.html")
    script:
        """\
        multiqc .
        """
}

workflow {
    run_fastqc(fastq_list_ch)
    run_multiqc(run_fastqc.out.collect())
}
