#!/usr/bin/env nextflow

process sayHello {
    output:
        stdout
    script:
    """
    echo 'Hello world!'
    """
}

workflow {
    sayHello | view
}
