#!/bin/bash





A=35
#B=170
#D=510
#E=181
RANDOM=$$
while :
do




$((A++))
#$((B++))
#$((D++))
$((E++))
$((F--))

echo $A

G=$(($RANDOM % 4 ))
H=$(($RANDOM % 4 ))

C=3
echo "C is " $C
./adf4351 $A 25000000 $G
./adf43512 $A.010000 25000000 $H

./adf43513 $A 25000000 $H
./adf43514 $A.010000 25000000 $G

./adf43515 $A 25000000 $H
./adf43516 $A.010000 25000000 $G

./adf43517 $A 25000000 $H
./adf43518 $A.010000 25000000 $G
#./adf43519 183 25000000 $G

sleep 0.1

if [[ $A -gt 4000 ]]
then
A=35
B=170
fi


if [[ $D -gt 570 ]]
then
D=510

fi
if [[ $F -lt 181 ]]
then
F=184
fi

if [[ $E -gt 184 ]]
then
E=181

fi
clear
done
