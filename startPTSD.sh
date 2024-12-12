#!/bin/bash

C=0


clear
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
while :
do

#/home/pi/Desktop/testmodules/adf43519& 
#/home/pi/Desktop/testmodules/adf43516&
#/home/pi/Desktop/testmodules/adf43515& 
#/home/pi/Desktop/testmodules/adf43517& 
#/home/pi/Desktop/testmodules/adf43518& 

#/home/pi/Desktop/testmodules/adf43514& 
#/home/pi/Desktop/testmodules/adf43513&


#/home/pi/Desktop/testmodules/adf4351& 
#/home/pi/Desktop/testmodules/adf43512

#sleep $((($RANDOM % 50 + 25)/100))

/home/pi/Desktop/testmodules/adf43519& 
/home/pi/Desktop/testmodules/adf43516&
/home/pi/Desktop/testmodules/adf43515& 
/home/pi/Desktop/testmodules/adf43517& 
/home/pi/Desktop/testmodules/adf43518& 
/home/pi/Desktop/testmodules/adf43514& 
/home/pi/Desktop/testmodules/adf43513&
/home/pi/Desktop/testmodules/adf4351& 
/home/pi/Desktop/testmodules/adf43512

BBB=$(($RANDOM % 9 + 1))
BBB2=$(($RANDOM % 9 + 1))
BBB3=$(($RANDOM % 9 + 1))



/home/pi/Desktop/testmodules/adf4351 "245."$BBB"00000" 25000000 $C&
/home/pi/Desktop/testmodules/adf43512 "275."$BBB"00130" 25000000 $C&
/home/pi/Desktop/testmodules/adf43513 "240."$BBB"00130" 25000000 $C&
/home/pi/Desktop/testmodules/adf43514 "240."$BBB2"00000" 25000000 $C&
/home/pi/Desktop/testmodules/adf43515 "280."$BBB2"00130" 25000000 $C&
/home/pi/Desktop/testmodules/adf43516 "280."$BBB2"00130" 25000000 $C&
/home/pi/Desktop/testmodules/adf43517 "250."$BBB3"00000" 25000000 $C&
/home/pi/Desktop/testmodules/adf43518 "250."$BBB3"00420" 25000000 $C&
#/home/pi/Desktop/testmodules/adf43519 "250."$BBB3"00000" 25000000 $C&

sleep 1800


done
