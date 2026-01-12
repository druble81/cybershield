#!/bin/bash


A="$1"
B="$2"

# If 2nd argument is 4200, force it to 4400
if [[ "$B" -eq 4200 ]]; then
    B=4400
fi





    if [ -f /tmp/ramdisk/adf4351 ]; then
	sudo /home/pi/Desktop/loadrd "$A" "$B" 1
	#$(($RANDOM % 5 + 1))
        exit
    fi

amixer set Master mute

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

cp n3/adf4351 /tmp/ramdisk/adf43512sn3
cp n3/adf43512 /tmp/ramdisk/adf435122n3
cp n3/adf43513 /tmp/ramdisk/adf435132n3
cp n3/adf43514 /tmp/ramdisk/adf435142n3
cp n3/adf43515 /tmp/ramdisk/adf435152n3
cp n3/adf43516 /tmp/ramdisk/adf435162n3
cp n3/adf43517 /tmp/ramdisk/adf435172n3
cp n3/adf43518 /tmp/ramdisk/adf435182n3
cp n3/adf43519 /tmp/ramdisk/adf435192n3

cp n4/adf4351 /tmp/ramdisk/adf43512sn4
cp n4/adf43512 /tmp/ramdisk/adf435122n4
cp n4/adf43513 /tmp/ramdisk/adf435132n4
cp n4/adf43514 /tmp/ramdisk/adf435142n4
cp n4/adf43515 /tmp/ramdisk/adf435152n4
cp n4/adf43516 /tmp/ramdisk/adf435162n4
cp n4/adf43517 /tmp/ramdisk/adf435172n4
cp n4/adf43518 /tmp/ramdisk/adf435182n4
cp n4/adf43519 /tmp/ramdisk/adf435192n4

cp 10k2/adf4351 /tmp/ramdisk/adf43512sk2
cp 10k2/adf43512 /tmp/ramdisk/adf435122k2
cp 10k2/adf43513 /tmp/ramdisk/adf435132k2
cp 10k2/adf43514 /tmp/ramdisk/adf435142k2
cp 10k2/adf43515 /tmp/ramdisk/adf435152k2
cp 10k2/adf43516 /tmp/ramdisk/adf435162k2
cp 10k2/adf43517 /tmp/ramdisk/adf435172k2
cp 10k2/adf43518 /tmp/ramdisk/adf435182k2
cp 10k2/adf43519 /tmp/ramdisk/adf435192k2

cp 10k3/adf4351 /tmp/ramdisk/adf43512sk3
cp 10k3/adf43512 /tmp/ramdisk/adf435122k3
cp 10k3/adf43513 /tmp/ramdisk/adf435132k3
cp 10k3/adf43514 /tmp/ramdisk/adf435142k3
cp 10k3/adf43515 /tmp/ramdisk/adf435152k3
cp 10k3/adf43516 /tmp/ramdisk/adf435162k3
cp 10k3/adf43517 /tmp/ramdisk/adf435172k3
cp 10k3/adf43518 /tmp/ramdisk/adf435182k3
cp 10k3/adf43519 /tmp/ramdisk/adf435192k3

cp 10k4/adf4351 /tmp/ramdisk/adf43512sk4
cp 10k4/adf43512 /tmp/ramdisk/adf435122k4
cp 10k4/adf43513 /tmp/ramdisk/adf435132k4
cp 10k4/adf43514 /tmp/ramdisk/adf435142k4
cp 10k4/adf43515 /tmp/ramdisk/adf435152k4
cp 10k4/adf43516 /tmp/ramdisk/adf435162k4
cp 10k4/adf43517 /tmp/ramdisk/adf435172k4
cp 10k4/adf43518 /tmp/ramdisk/adf435182k4
cp 10k4/adf43519 /tmp/ramdisk/adf435192k4

SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED





    cat /dev/null > /tmp/ramdisk/SG3.TXT
    clear
    
    start=$A
    end=$B
    range=$((end - start + 1))

    # Calculate the divisor
    divisor=$(( (range + 4599) / 4500 ))

 

    # Output the result 

    C=$divisor
    echo "$C"

    rand_num=0


    A=$(($A + rand_num))

    segment_size=$(( (range + divisor - 1) / divisor ))


    while [[ $A -le $end ]]

    do

     

        printf "%s\n" $A   >> /tmp/ramdisk/SG3.TXT
        A=$(($A+$(($C))))
    
    done

    printf "\n"    >> /tmp/ramdisk/SG3.TXT