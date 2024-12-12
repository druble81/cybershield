cd /home/pi/Desktop/testmodules
BA=800
while :
do


BA=$(($BA+1))

if [  $BA -gt 4200  ]
then
	BA=800
fi

./adf43519 $BA 25000000 3

done