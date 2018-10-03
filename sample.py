import json
with open("481621.json") as f:
    data = json.load(f)
    print(data["num"])
    
