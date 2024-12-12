echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********


BB=120
BB1=241
BB2=272
BB3=293

A=0
C=0
D=350


if [ -z "$1" ]
then
echo "nothing"
else
D=$1
fi

while :
do

while [[ "$A" -lt "$D" ]] 
do



A=$(($A+1))
echo $A"hz Entrainment"

if [[ "$A" -lt "100" ]]
then

/home/pi/Desktop/testmodules/adf4351 280 25000000 $C&
/home/pi/Desktop/testmodules/adf43512 280.0000$A 25000000 $C&
/home/pi/Desktop/testmodules/adf43519 280.010000 25000000 $C


/home/pi/Desktop/testmodules/adf43513 200 25000000 $C&
/home/pi/Desktop/testmodules/adf43514 200.0000$A 25000000 $C&
fi

if [[ "$A" -gt "90" ]]
then

/home/pi/Desktop/testmodules/adf4351 280 25000000 $C&
/home/pi/Desktop/testmodules/adf43512 280.000$A 25000000 $C&
/home/pi/Desktop/testmodules/adf43519 280.010000 25000000 $C

/home/pi/Desktop/testmodules/adf43513 200 25000000 $C&
/home/pi/Desktop/testmodules/adf43514 200.000$A 25000000 $C&
fi
if [ -z "$1" ]
then
sleep 0.2
else

sleep $2
fi
done
done




sleep 0.7


exit





done

