pipedir="/BiO/BioPeople/siyoo/pipeline/pipeline_cookiecutter"
cmd="python $pipedir/bin/config.py --input-info input_info --pipedir $pipedir --workdir $pipedir/test"
echo $cmd
cmd="snakemake --cores all -s $pipedir/pipeline.snakefile"
echo $cmd
