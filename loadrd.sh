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

SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED


#!/bin/bash

RUN_FILE="/tmp/ramdisk/running.txt"
RUN_FILE2="/tmp/ramdisk/running2.txt"
A1_FILE="/tmp/ramdisk/A1.txt"
A2_FILE="/tmp/ramdisk/A2.txt"

# Check if running.txt exists and contains "running"
if [[ -f "$RUN_FILE" && "$(cat $RUN_FILE)" == "running" ]]; then
    echo "$1" > "$A1_FILE"
    echo "$2" > "$A2_FILE"
pkill -f sleep
    exit 0
else
    echo "running" > "$RUN_FILE"
    echo "$1" > "$A1_FILE"
    echo "$2" > "$A2_FILE"

    # Placeholder for additional code
    # Add your custom code below this line

if [[ -f "$RUN_FILE2" && "$(cat $RUN_FILE)" == "running" ]]; then


while :
do

    A1=$(< /tmp/ramdisk/A1.txt)
    A2=$(< /tmp/ramdisk/A2.txt)


    cat /dev/null > /tmp/ramdisk/SG3.TXT
    clear
    
    # Validate arguments
    if [[ -z $1 || -z $A2 || $A1 -ge $A2 ]]; then
        echo "Usage: $0 <start_number> <end_number>"
        exit 1
    fi
    
    start=$A1
    end=$A2
    range=$((end - start + 1))

    # Calculate the divisor
    divisor=$(( (range + 99) / 100 ))

 

    # Output the result 

    B=$divisor
    echo "$B"

    rand_num=0


    A=$(($A1 + rand_num))

    segment_size=$(( (range + divisor - 1) / divisor ))


    while [[ $A -lt $A2 ]]
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
    echo b is $B

    sleep 15  

    done


else

    ###############################
    A1=$(< /tmp/ramdisk/A1.txt)
    A2=$(< /tmp/ramdisk/A2.txt)


    cat /dev/null > /tmp/ramdisk/SG3.TXT
    clear


    #!/bin/bash

    # Validate arguments
    if [[ -z $1 || -z $A2 || $A1 -ge $A2 ]]; then
        echo "Usage: $0 <start_number> <end_number>"
        exit 1
    fi

    start=$A1
    end=$A2
    range=$((end - start + 1))

    # Calculate the divisor
    divisor=$(( (range + 99) / 100 ))

    # Assign the result to a variable
    segment_size=$(( (range + divisor - 1) / divisor ))

    # Output the result

    B=$divisor
    echo "$B"

    rand_num=0



    A=$(($A1 + rand_num))


    while [[ $A -lt $A2 ]]
    do

    if [[ $segment_size -ge 20 ]]; then
        rand_num=$((RANDOM % $segment_size))
    fi

        printf "%s\n" $A   >> /tmp/ramdisk/SG3.TXT
        A=$(($A+$(($B))))
    done


    printf "\n"    >> /tmp/ramdisk/SG3.TXT
    A=900
    echo done setting primaries
    echo b is $B

    echo "running" > "$RUN_FILE2"
    echo "" > "$RUN_FILE"

    pkill -f sleep

    exit

fi
fi
