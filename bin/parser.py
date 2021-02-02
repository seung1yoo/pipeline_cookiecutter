
import os
import sys

class Task:
    def __init__(self, input, output, threads, option):
        self.input = input
        self.output = output
        self.threads = threads
        self.option = option
        self.write_output()

    def write_output(self):
        outfh = open(self.output, 'w')
        outfh.write(f'{self.input}\n')
        outfh.write(f'{self.threads}\n')
        outfh.write(f'{self.option}\n')
        outfh.close()

def main(args):

    if args.subparser_name in ['task']:
        task = Task(args.input, args.output,
                    args.threads, args.option)



if __name__=='__main__':
    import argparse
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest='subparser_name')

    subparser = subparsers.add_parser('task')
    subparser.add_argument('--input')
    subparser.add_argument('--threads')
    subparser.add_argument('--option')
    subparser.add_argument('--output')

    args = parser.parse_args()
    main(args)
