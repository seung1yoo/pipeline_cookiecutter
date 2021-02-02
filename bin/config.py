
import os
import sys
import yaml

class Utils:
    def __init__(self, config):
        self.config = config

    def get_targets(self, targets):
        ls = list()
        if 'prep' in targets:
            for sample in self.config["samples"]:
                ls.append(f'analysis/inbam/{sample}/{sample}.bam')
        if 'task' in targets:
            for sample in self.config["samples"]:
                ls.append(f'analysis/task/{sample}/{sample}.path')
        return ls

    def get_params(self, infn):
        infh = open(infn)
        params_dic = yaml.safe_load(infh)
        for prog, arg_dic in params_dic.items():
            for arg, value in arg_dic.items():
                key = f'params_{arg}_{value}'
                config[key] = value

class MakeConfig:
    def __init__(self, infn, pipedir, workdir):
        self.pipedir = pipedir
        self.workdir = workdir
        self.write_config_yaml(infn)

    def write_config_yaml(self, infn):
        outfh = open("config.yaml", "w")
        outfh.write(f'pipedir = {os.path.abspath(self.pipedir)}\n')
        _path_params = os.path.join('config','params.yaml')
        outfh.write(f'params = {os.path.join(os.path.abspath(self.pipedir), _path_params)}\n')
        outfh.write(f'workdir = {os.path.abspath(self.workdir)}\n')
        outfh.write('\n')
        outfh.write('samples:\n')
        for line in open(infn):
            items = line.rstrip('\n').split()
            sn = items[0]
            path = items[1]
            outfh.write(f'  {sn}:\n')
            outfh.write(f'    bam: {os.path.abspath(path)}\n')
        outfh.close()

def main(args):
    config_obj = MakeConfig(args.input_info,
                            args.pipedir,
                            args.workdir)


if __name__=='__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--input-info')
    parser.add_argument('--pipedir')
    parser.add_argument('--workdir')
    args = parser.parse_args()
    main(args)
