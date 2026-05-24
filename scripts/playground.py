import os
import subprocess

os.environ["BUILD_DEBUG"] = "1"
process = subprocess.run(["sh", "scripts/playground.sh"])
