pipedir="/BiO/BioPeople/siyoo/pipeline/pipeline_cookiecutter"
cmd="python $pipedir/bin/config.py --input-info input_info --pipedir $pipedir --workdir $pipedir/test"
echo $cmd
cmd="snakemake --cores all -s $pipedir/pipeline.snakefile"
echo $cmd
cmd="rm -rf config.yaml analysis/ benchmarks/"
echo $cmd
cmd="snakemake --cores all -s $pipedir/pipeline.snakemake --printshellcmds --cluster-config $pipedir/envs/cluster.json --cluster 'qsub -V -o {config[workdir]}/{cluster.output} -e {config[workdir]}/{cluster.error} -pe smp {cluster.threads} -N {cluster.jobName} -S /bin/bash -q all.q'"
echo $cmd
