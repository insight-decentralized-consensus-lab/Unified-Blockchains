import json
import sys, os

if(len(sys.argv)>1):
    infile = sys.argv[1]
else:
    print("run via:")
    print("python3 "+sys.argv[0]+" <input-file>")
    sys.exit(1)
    
with open(infile) as f:
    data = json.load(f)

print(data)

                            
