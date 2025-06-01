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


A=0
C=1

while [[ "$A" -lt "$1" ]] 
do


A=$(($A+10))
echo $A"hz Entrainment"

if [[ "$A" -lt "100" ]]
then

/home/pi/Desktop/testmodules/adf4351 380 25000000 $C&
/home/pi/Desktop/testmodules/adf43512 380.0000$A 25000000 $C&
/home/pi/Desktop/testmodules/adf43519 380.0000$A 25000000 $C&

/home/pi/Desktop/testmodules/adf43515 155 25000000 $C&
/home/pi/Desktop/testmodules/adf43516 155.0000$A 25000000 $C&

/home/pi/Desktop/testmodules/adf43517 280 25000000 $C&
/home/pi/Desktop/testmodules/adf43518 280.0000$A 25000000 $C&


/home/pi/Desktop/testmodules/adf43513 320 25000000 $C&
/home/pi/Desktop/testmodules/adf43514 320.0000$A 25000000 $C&
fi

if [[ "$A" -gt "90" ]]
then

/home/pi/Desktop/testmodules/adf4351 380 25000000 $C&
/home/pi/Desktop/testmodules/adf43512 380.000$A 25000000 $C&
/home/pi/Desktop/testmodules/adf43519 380.000$A 25000000 $C&

/home/pi/Desktop/testmodules/adf43515 155 25000000 $C&
/home/pi/Desktop/testmodules/adf43516 155.000$A 25000000 $C&

/home/pi/Desktop/testmodules/adf43517 280 25000000 $C&
/home/pi/Desktop/testmodules/adf43518 280.000$A 25000000 $C&


/home/pi/Desktop/testmodules/adf43513 320 25000000 $C&
/home/pi/Desktop/testmodules/adf43514 320.000$A 25000000 $C&
fi

sleep 1

done

