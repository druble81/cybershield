cd /home/pi/Desktop/testmodules









SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED








FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi


E=3
D=1





while :
do







x=$((RANDOM % 3 + 1))

offset=100000
#echo $offset

for (( i=1; i<=27; i++ ))
do
offset=$(($offset + RANDOM % 900000))
done
hz1="000005"
offset=100000
#echo $offset

for (( i=1; i<=27; i++ ))
do
offset=$(($offset + RANDOM % 900000))
done
hz2="000007"
offset=100000
#echo $offset

for (( i=1; i<=27; i++ ))
do
offset=$(($offset + RANDOM % 900000))
done
hz3="000012"
offset=100000
#echo $offset

for (( i=1; i<=27; i++ ))
do
offset=$(($offset + RANDOM % 900000))
done
hz4="0000019"

BA=$((RANDOM % 99 + 1))
##BA=33
BB=$((RANDOM % 20 + 1))
#BB=$(($BB))
#BB=3



hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))




BB=$(($RANDOM % 10 + 495))
BB1=$BB
BB2=$BB
BB3=$BB


echo V2K

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1 25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))

BB=$(($RANDOM % 200 + 4200))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))

echo V2K

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB".000010" 25000000 $C&
##100000

./adf43513 $BB1".000011" 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2".000017" 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3".000019" 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))



BB=$(($RANDOM % 55 + 85))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
echo V2K

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1 25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))


BB=$(($RANDOM % 190 + 4200))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
echo V2K

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1 25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))

BB=$(($RANDOM % 100 + 950))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
#echo QUAD H

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1  25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))

BB=$(($RANDOM % 200 + 1500))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
#echo QUAD H

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1  25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))

BB=$(($RANDOM % 200 + 3000))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
#echo QUAD H

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1 25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))

BB=$(($RANDOM % 200 + 3400))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
#echo QUAD H

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1 25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))

BB=$(($RANDOM % 200 + 3800))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
#echo QUAD H

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1 25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))

BB=$(($RANDOM % 195 + 4000))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
#echo QUAD H

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1 25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))

BB=$(($RANDOM % 35 + 85))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
#echo QUAD H

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB".000007" 25000000 $C&
##100000

./adf43513 $BB1".000005" 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2".000017" 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3".000019" 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))


BB=$(($RANDOM % 195 + 2800))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
#echo QUAD H

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1 25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))

BB=$(($RANDOM % 550 + 1760))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
#echo QUAD H

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1 25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))

BB=$(($RANDOM % 11 + 995))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
#echo QUAD H

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1 25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))

BB=$(($RANDOM % 15 + 89))
BB1=$BB
BB2=$BB
BB3=$BB

hz1=$(($offset+$(($RANDOM%3+5))))
hz2=$(($offset+$(($RANDOM%3+19))))
hz3=$(($offset+$(($RANDOM%3+12))))
hz4=$(($offset+$(($RANDOM%3+7))))
#echo QUAD H

#./adf43519 4130 25000000 $C


./adf4351 $BB 25000000 $C&
./adf43512 $BB.$hz1 25000000 $C&
##100000

./adf43513 $BB1.$hz2 25000000 $C&
./adf43514 $BB1 25000000 $C&
##110000

####################10000

./adf43515 $BB2 25000000 $C&
./adf43516 $BB2.$hz3 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$hz4 25000000 $C&
./adf43518 $BB3 25000000 $C
##200003

####################10001

#10000 - 100001 = 1hz
sleep 0.00$(($RANDOM % 9 + 1))


done
/home/pi/Desktop/testmodules/adf43519& 
/home/pi/Desktop/testmodules/adf43516& 
/home/pi/Desktop/testmodules/adf43515& 
/home/pi/Desktop/testmodules/adf43517& 
/home/pi/Desktop/testmodules/adf43518& 
/home/pi/Desktop/testmodules/adf43514& 
/home/pi/Desktop/testmodules/adf43513&
/home/pi/Desktop/testmodules/adf4351& 
/home/pi/Desktop/testmodules/adf43512

done
