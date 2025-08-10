cd /home/pi/Desktop/testmodules
D=0
E=3
C=1
while :
do


if [ "$D" -eq "$E" ]
then
D=0
E=$((RANDOM%30+5))
fi


if [  "$D" -eq "1"  ]
then


A=$((RANDOM%10+1))
B=$((RANDOM%10+10))

while [[ "$A" -lt "$B" ]] 
do

if [ -z "$1" ]
then
echo ""
else

echo custom
/home/pi/Desktop/testmodules/adf4351 380 25000000 3&
/home/pi/Desktop/testmodules/adf43512 380.$1 25000000 2&
/home/pi/Desktop/testmodules/adf43519 380.$1 25000000 2&

/home/pi/Desktop/testmodules/adf43515 355 25000000 $C&
/home/pi/Desktop/testmodules/adf43516 355.$1 25000000 $C&

/home/pi/Desktop/testmodules/adf43517 980 25000000 $C&
/home/pi/Desktop/testmodules/adf43518 980.$1 25000000 $C&


/home/pi/Desktop/testmodules/adf43513 300 25000000 $C&
/home/pi/Desktop/testmodules/adf43514 300.$1 25000000 $C&
exit

fi



if [[ "$A" -lt "100" ]]
then

/home/pi/Desktop/testmodules/adf4351 380 25000000 3&
/home/pi/Desktop/testmodules/adf43512 380.0000$A 25000000 2&
/home/pi/Desktop/testmodules/adf43519 380.0000$A 25000000 2&

/home/pi/Desktop/testmodules/adf43515 355 25000000 $C&
/home/pi/Desktop/testmodules/adf43516 355.0000$A 25000000 $C&

/home/pi/Desktop/testmodules/adf43517 380 25000000 $C&
/home/pi/Desktop/testmodules/adf43518 380.0000$A 25000000 $C&


/home/pi/Desktop/testmodules/adf43513 300 25000000 $C&
/home/pi/Desktop/testmodules/adf43514 300.0000$A 25000000 $C&
fi

if [[ "$A" -gt "90" ]]
then

/home/pi/Desktop/testmodules/adf4351 380 25000000 3&
/home/pi/Desktop/testmodules/adf43512 380.000$A 25000000 2&
/home/pi/Desktop/testmodules/adf43519 380.000$A 25000000 2&

/home/pi/Desktop/testmodules/adf43515 355 25000000 $C&
/home/pi/Desktop/testmodules/adf43516 355.000$A 25000000 $C&

/home/pi/Desktop/testmodules/adf43517 380 25000000 $C&
/home/pi/Desktop/testmodules/adf43518 380.000$A 25000000 $C&


/home/pi/Desktop/testmodules/adf43513 300 25000000 $C&
/home/pi/Desktop/testmodules/adf43514 300.000$A 25000000 $C&


fi

#echo $A"hz Entrainment"
A=$(($A+1))








done

fi

/home/pi/Desktop/testmodules/adf4351 380 25000000 3&
/home/pi/Desktop/testmodules/adf43512 380.000420 25000000 2&
/home/pi/Desktop/testmodules/adf43519 380.000420 25000000 2&

/home/pi/Desktop/testmodules/adf43515 355 25000000 $C&
/home/pi/Desktop/testmodules/adf43516 355.000120 25000000 $C&

/home/pi/Desktop/testmodules/adf43517 980 25000000 $C&
/home/pi/Desktop/testmodules/adf43518 980.000420 25000000 $C&


/home/pi/Desktop/testmodules/adf43513 300 25000000 $C&
/home/pi/Desktop/testmodules/adf43514 300.000120 25000000 $C&



D=$(($D + 1))






















BA=$((RANDOM % 99 + 1))
##BA=33
BB=$((RANDOM % 20 + 1))
#BB=$(($BB+3))
#BB=3


BB=$(($RANDOM % 75 + 35))
echo V2K

#./adf43519 4130 25000000 3


./adf4351 $BB 25000000 3&
./adf43512 $BB".100000" 25000000 3&
##100000

./adf43513 $(($BB+1))".110001" 25000000 3&
./adf43514 $(($BB+1)) 25000000 3&
##110000

####################10000

./adf43515 $(($BB+2)) 25000000 3&
./adf43516 $(($BB+2))".210000" 25000000 3&
#echo ./adf43516 $BB".210001" 25000000 3&
##210001

./adf43517 $(($BB+3))".200001" 25000000 3&
./adf43518 $(($BB+3)) 25000000 3
##200003

####################10001

#10000 - 100001 = 1hz



BB=$(($RANDOM % 100 + 950))
#echo QUAD H

#./adf43519 4130 25000000 3


./adf4351 $BB 25000000 3&
./adf43512 $BB".100001" 25000000 3&
##100000

./adf43513 $(($BB+1))".110000" 25000000 3&
./adf43514 $(($BB+1)) 25000000 3&
##110000

####################10000

./adf43515 $(($BB+2)) 25000000 3&
./adf43516 $(($BB+2))".210000" 25000000 3&
#echo ./adf43516 $BB".210001" 25000000 3&
##210001

./adf43517 $(($BB+3))".200001" 25000000 3&
./adf43518 $(($BB+3)) 25000000 3
##200003

####################10001

#10000 - 100001 = 1hz


BB=$(($RANDOM % 200 + 1500))
#echo QUAD H

#./adf43519 4130 25000000 3


./adf4351 $BB 25000000 3&
./adf43512 $BB".100001" 25000000 3&
##100000

./adf43513 $(($BB+1))".110000" 25000000 3&
./adf43514 $(($BB+1)) 25000000 3&
##110000

####################10000

./adf43515 $(($BB+2)) 25000000 3&
./adf43516 $(($BB+2))".210000" 25000000 3&
#echo ./adf43516 $BB".210001" 25000000 3&
##210001

./adf43517 $(($BB+3))".200001" 25000000 3&
./adf43518 $(($BB+3)) 25000000 3
##200003

####################10001

#10000 - 100001 = 1hz


BB=$(($RANDOM % 200 + 3000))
#echo QUAD H

#./adf43519 4130 25000000 3


./adf4351 $BB 25000000 3&
./adf43512 $BB".100003" 25000000 3&
##100000

./adf43513 $(($BB+1))".110000" 25000000 3&
./adf43514 $(($BB+1)) 25000000 3&
##110000

####################10000

./adf43515 $(($BB+2)) 25000000 3&
./adf43516 $(($BB+2))".210000" 25000000 3&
#echo ./adf43516 $BB".210001" 25000000 3&
##210001

./adf43517 $(($BB+3))".200003" 25000000 3&
./adf43518 $(($BB+3)) 25000000 3
##200003

####################10001

#10000 - 100001 = 1hz


BB=$(($RANDOM % 200 + 3400))
#echo QUAD H

#./adf43519 4130 25000000 3


./adf4351 $BB 25000000 3&
./adf43512 $BB".100005" 25000000 3&
##100000

./adf43513 $(($BB+1))".110000" 25000000 3&
./adf43514 $(($BB+1)) 25000000 3&
##110000

####################10000

./adf43515 $(($BB+2)) 25000000 3&
./adf43516 $(($BB+2))".210000" 25000000 3&
#echo ./adf43516 $BB".210001" 25000000 3&
##210001

./adf43517 $(($BB+3))".200005" 25000000 3&
./adf43518 $(($BB+3)) 25000000 3
##200003

####################10001

#10000 - 100001 = 1hz


BB=$(($RANDOM % 200 + 3800))
#echo QUAD H

#./adf43519 4130 25000000 3


./adf4351 $BB 25000000 3&
./adf43512 $BB".100001" 25000000 3&
##100000

./adf43513 $(($BB+1))".110000" 25000000 3&
./adf43514 $(($BB+1)) 25000000 3&
##110000

####################10000

./adf43515 $(($BB+2)) 25000000 3&
./adf43516 $(($BB+2))".210000" 25000000 3&
#echo ./adf43516 $BB".210001" 25000000 3&
##210001

./adf43517 $(($BB+3))".200001" 25000000 3&
./adf43518 $(($BB+3)) 25000000 3
##200003

####################10001

#10000 - 100001 = 1hz


BB=$(($RANDOM % 195 + 4000))
#echo QUAD H

#./adf43519 4130 25000000 3


./adf4351 $BB 25000000 3&
./adf43512 $BB".100005" 25000000 3&
##100000

./adf43513 $(($BB+1))".110000" 25000000 3&
./adf43514 $(($BB+1)) 25000000 3&
##110000

####################10000

./adf43515 $(($BB+2)) 25000000 3&
./adf43516 $(($BB+2))".210000" 25000000 3&
#echo ./adf43516 $BB".210001" 25000000 3&
##210001

./adf43517 $(($BB+3))".200005" 25000000 3&
./adf43518 $(($BB+3)) 25000000 3
##200003

####################10001

#10000 - 100001 = 1hz


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
