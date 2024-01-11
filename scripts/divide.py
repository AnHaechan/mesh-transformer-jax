#
# `sudo python3 divide.py`
#
import os

os.chdir("/mnt/disks/persist2/pile/raw_txt/train")

NUM_SHARDS = 1000
# for shard_idx in range(NUM_SHARDS):
#     os.mkdir(f"shard{shard_idx}")

shard_idx = 0
NUM_FILES_TOTAL = len(os.listdir("."))
NUM_FILES_PER_SHARD = NUM_FILES_TOTAL // NUM_SHARDS

for idx, txt_file_path in enumerate(os.listdir(".")):
    if not txt_file_path.endswith(".txt"): continue

    # e.g. txt_file_path = 16162292.txt
    os.rename(txt_file_path, f"shard{shard_idx}/{txt_file_path}")

    if idx >= NUM_FILES_PER_SHARD * (1 + shard_idx):
        print(f"shard_idx {shard_idx}")
        shard_idx += 1

# TODO: move rest of the files to the last shard manaully.