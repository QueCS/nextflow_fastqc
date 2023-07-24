#!/usr/bin/env nextflow

params.reads = "${HOME}/nextflow_projects/nextflow_fastqc/data/*.fastq.gz"
params.outdir = "${HOME}/nextflow_projects/nextflow_fastqc/res"

log.info """\
        
        Parameters in use:
        reads: ${params.reads}
        outdir: ${params.outdir}
        """

process run_fastqc {
    input:
        path reads from params.reads
    script:
        """
        fastqc ${reads} -o ${params.outdir}
        """
}

workflow {
    run_fastqc
}

workflow.onComplete {
    log.info """\
        Pipeline execution summary:
        Completed at: ${workflow.complete}
        Duration    : ${workflow.duration}
        Success     : ${workflow.success}
        workDir     : ${workflow.workDir}
        exit status : ${workflow.exitStatus}
        """
}
