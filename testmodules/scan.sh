cd /home/pi/Desktop/testmodules
BA=35
while :
do


BA=$(($BA+1))

if [  $BA -gt 4400  ]
then
	BA=35
fi

./adf43519 $BA 25000000 1
./adf43518 $BA 25000000 1
./adf43517 $BA 25000000 1
./adf43516 $BA 25000000 1
./adf43515 $BA 25000000 1
./adf43514 $BA 25000000 1
./adf43513 $BA 25000000 1
./adf43513 $BA 25000000 1
./adf4351 $BA 25000000 1

done