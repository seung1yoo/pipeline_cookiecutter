pipedir="/BiO/BioPeople/siyoo/pipeline/pipeline_cookiecutter"
cmd="python $pipedir/bin/config.py --input-info input_info --pipedir $pipedir --workdir $pipedir/test"
echo $cmd
cmd="snakemake --cores all -s $pipedir/pipeline.snakefile"
echo $cmd
cmd="rm -rf config.yaml analysis/ benchmarks/"
echo $cmd
cmd="mkdir logs"
echo $cmd
cmd="snakemake --cores all -s $pipedir/pipeline.snakefile --printshellcmds --cluster-config $pipedir/env/cluster.json --cluster 'qsub -V -o {config[workdir]}/{cluster.output} -e {config[workdir]}/{cluster.error} -pe smp {cluster.threads} -N {cluster.jobName} -S /bin/bash -q all.q'"
echo $cmd
cmd="rm -rf config.yaml analysis/ benchmarks/ logs/"
echo $cmd
