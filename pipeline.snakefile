
import os

from snakemake.utils import min_version
min_version('5.31.1')

from bin.config import Utils

configfile: "config.yaml"
utils = Utils(config)
utils.get_params(config['params'])

targets = list()
targets.append('prep')
targets.append('task')

rule all:
    input: utils.get_targets(targets)

rule prep:
    input:
        bam = lambda wildcards: config["samples"][wildcards.sample]['bam']
    output:
        bam = 'analysis/inbam/{sample}/{sample}.bam'
    shell:
        "ln -s {input.bam} {output.bam}"

rule task:
    input:
        bam = 'analysis/inbam/{sample}/{sample}.bam'
    output:
        txt = "analysis/task/{sample}/{sample}.path"
    message: "running task for {sample}"
    benchmark: "benchmarks/task_1.txt"
    threads: 4
    params:
        option = config['params_task_option']
    shell:
        "python bin/parser.py task"
        " --input {input.bam}"
        " --threads {threads}"
        " --option {params.option}"
        " --output {output.txt}"


