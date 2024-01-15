perform_task() {
    echo $i
    # sleep 5
    sudo python3 create_finetune_tfrecords.py /mnt/disks/persist2/pile/raw_txt/train/shard$i pile_gitarx_shard$i --output-dir /home/haechan.an/mesh-transformer-jax/tfrecord
}

if [ ! -d "tfrecord" ]; then
    mkdir "tfrecord"
fi

max_processes=2

for i in {0..199} # max: 999 ; divide by regions
do
    # filter already created ones
    if [ $i -le 31 ]; then
        continue
    fi 

    perform_task $i &
    
    # Check the number of background processes
    if [[ $(jobs -p | wc -l) -ge $max_processes ]]; then
        wait  # Wait for the background processes to finish before starting new ones
    fi
done 