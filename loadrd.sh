#!/bin/bash
sudo bash /home/pi/Desktop/ramdisk.sh
cd /home/pi/Desktop
bash fixpermissions.sh
cp 10k/adf4351 /tmp/ramdisk/adf43512s
cp 10k/adf43512 /tmp/ramdisk/adf435122
cp 10k/adf43513 /tmp/ramdisk/adf435132
cp 10k/adf43514 /tmp/ramdisk/adf435142
cp 10k/adf43515 /tmp/ramdisk/adf435152
cp 10k/adf43516 /tmp/ramdisk/adf435162
cp 10k/adf43517 /tmp/ramdisk/adf435172
cp 10k/adf43518 /tmp/ramdisk/adf435182
cp 10k/adf43519 /tmp/ramdisk/adf435192
cp alloffrd.sh /tmp/ramdisk/alloffrd.sh
cp /bin/pkill /tmp/ramdisk/pkill


cp adf4351 /tmp/ramdisk/adf4351
cp adf43512 /tmp/ramdisk/adf43512
cp adf43513 /tmp/ramdisk/adf43513
cp adf43514 /tmp/ramdisk/adf43514
cp adf43515 /tmp/ramdisk/adf43515
cp adf43516 /tmp/ramdisk/adf43516
cp adf43517 /tmp/ramdisk/adf43517
cp adf43518 /tmp/ramdisk/adf43518
cp adf43519 /tmp/ramdisk/adf43519
cp loadrd.sh /tmp/ramdisk/loadrd.sh





cp n2/adf4351 /tmp/ramdisk/adf43512sn
cp n2/adf43512 /tmp/ramdisk/adf435122n
cp n2/adf43513 /tmp/ramdisk/adf435132n
cp n2/adf43514 /tmp/ramdisk/adf435142n
cp n2/adf43515 /tmp/ramdisk/adf435152n
cp n2/adf43516 /tmp/ramdisk/adf435162n
cp n2/adf43517 /tmp/ramdisk/adf435172n
cp n2/adf43518 /tmp/ramdisk/adf435182n
cp n2/adf43519 /tmp/ramdisk/adf435192n


SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED


#!/bin/bash


A=$1



    cat /dev/null > /tmp/ramdisk/SG3.TXT
    clear
    
    
    start=$1
    end=$2
    range=$((end - start + 1))

    # Calculate the divisor
    divisor=$(( (range + 1999) / 2000 ))

 

    # Output the result 

    B=$divisor
    echo "$B"

    rand_num=0


    A=$(($A + rand_num))

    segment_size=$(( (range + divisor - 1) / divisor ))


    while [[ $A -lt $2 ]]
    do

    # Assign the result to a variable
    

    if [[ $segment_size -ge 20 ]]; then
        rand_num=$((RANDOM % $segment_size))
    fi
        printf "%s\n" $A   >> /tmp/ramdisk/SG3.TXT
        A=$(($A+$(($B))))
    done


    printf "\n"    >> /tmp/ramdisk/SG3.TXT
    A=900
    echo done setting primaries

