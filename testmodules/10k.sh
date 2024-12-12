#!/bin/bash





A=270
B=170
D=510
E=181
RANDOM=$$
while :
do




#$((A++))
#$((B++))
#$((D++))
$((E++))
$((F--))

echo $A

G=$(($RANDOM % 4 ))
H=$(($RANDOM % 4 ))

C=3
echo "C is " $C
./adf4351 $F 25000000 $G
./adf43512 $E.010000 25000000 $H

./adf43513 $F 25000000 $H
./adf43514 $F.010000 25000000 $G

./adf43515 $E 25000000 $H
./adf43516 $E.010000 25000000 $G

./adf43517 $E 25000000 $H
./adf43518 $E.010000 25000000 $G
./adf43519 183 25000000 $G

#sleep 0.1

if [[ $A -gt 310 ]]
then
A=270
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
