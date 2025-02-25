process SAMPLESHEET_CHECK {
    tag "${samplesheet}"

    container "karchinlab/bulktcr:1.0"

    publishDir "${params.output}/pipeline_info/", mode: "copy", overwrite: "true"

    input:
    path samplesheet

    output:
    path 'samplesheet_utf8.csv'    , emit: samplesheet_utf8
    path 'samplesheet_stats.txt'

    script: 
    """
    #!/bin/bash
    
    iconv -t utf-8 $samplesheet > samplesheet_utf8.csv

    csvstat samplesheet_utf8.csv > samplesheet_stats.txt
    """

    stub:
    """
    #!/bin/bash

    touch samplesheet_utf8.csv
    touch samplesheet_stats.txt
    """
}
