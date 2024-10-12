import sys
import argparse

#create -t argument
parser = argparse.ArgumentParser()
parser.add_argument('-t', '--target', required=True, choices=["titi", "tata", "toto"], nargs="+", dest="value")

#extract value from namespace
args = parser.parse_args(sys.argv[1:])

#print result
print(' '.join(args.value))
