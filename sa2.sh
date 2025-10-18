
#!/bin/bash

# Path to the file
FILE="/home/pi/Desktop/nvalues.txt"

# Default values
DEFAULT_T1=140
DEFAULT_T2=65

# Check if file exists and load values, otherwise use defaults
if [[ -f "$FILE" ]]; then
    # Read first two values from the file
    read T1 T2 < "$FILE"
else
    T1=$DEFAULT_T1
    T2=$DEFAULT_T2
fi


T3=$((T1*2))
T4=$((T2*2))

# Path to the file
FILE="/home/pi/Desktop/10values.txt"

# Default values
DEFAULT_T3=140
DEFAULT_T4=65

# Check if file exists and load values, otherwise use defaults
if [[ -f "$FILE" ]]; then
    # Read first two values from the file
    read T5 T6 < "$FILE"
else
    T5=$DEFAULT_T3
    T6=$DEFAULT_T4
fi


T7=$((T1*2))
T8=$((T2*2))

cd /tmp/ramdisk

#bash /home/pi/Desktop/startall6.sh 530 0.05&
SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED
myarray=(1 2 4 3 5 6 7 8 9)

#shuf -e ${myarray[@]}

FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi



while :
do
#shuf -e ${myarray[@]}
#RANDOM=$$
A=$(($RANDOM % 2))
#A=1
echo $A



sudo pkill -f adf435




#C=$(($RANDOM % 4 + 1))


B=8333

##ALWAYS ON

/tmp/ramdisk/adf43513 3000 25000000 $C $T3 $T4&
##







A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43514 3000 25000000 $C $T1 $T2&
else
/tmp/ramdisk/adf435142 3000 25000000 $C $T5 $T6&
fi

A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43515 3000 25000000 $C $T1 $T2&
else
/tmp/ramdisk/adf435152 3000 25000000 $C $T5 $T6&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43516 3000 25000000 $C $T1 $T2&
else
/tmp/ramdisk/adf435162 3000 25000000 $C $T5 $T6&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43517 3000 25000000 $C $T1 $T2&
else
/tmp/ramdisk/adf435172 3000 25000000 $C $T5 $T6&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43518 3000 25000000 $C $T1 $T2&
else
/tmp/ramdisk/adf435182 3000 25000000 $C $T5 $T6&
fi



A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43519 3000 25000000 $C $T1 $T2&
else
/tmp/ramdisk/adf435192 3000 25000000 $C $T5 $T6&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf4351 3000 25000000 $C $T1 $T2&
else
/tmp/ramdisk/adf43512s 3000 25000000 $C $T5 $T6&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43512 3000 25000000 $C $T1 $T2&
else
/tmp/ramdisk/adf435122 3000 25000000 $C $T5 $T6&
fi



echo "......................Full Coverage MODE......................"


sleep 1


done
