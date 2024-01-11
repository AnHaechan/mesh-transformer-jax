perform_task() {
    echo $i
    # sleep 5
    sudo python3 create_finetune_tfrecords.py /mnt/disks/persist2/pile/raw_txt/train/shard$i pile_gitarx_shard$i --output-dir /mnt/disks/persist2/pile/tfrecord/train
}

max_processes=32

for i in {1..999}
do
    perform_task $i &
    
    # Check the number of background processes
    if [[ $(jobs -p | wc -l) -ge $max_processes ]]; then
        wait  # Wait for the background processes to finish before starting new ones
    fi
done 