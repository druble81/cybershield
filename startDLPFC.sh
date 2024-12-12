clear
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********

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

C=0
#sleep 0.1
#echo "PULSE   " $(($RANDOM % 9999999))
#sleep 0.5


/home/pi/Desktop/testmodules/adf43519& 
/home/pi/Desktop/testmodules/adf43516&
/home/pi/Desktop/testmodules/adf43515& 
/home/pi/Desktop/testmodules/adf43517& 
/home/pi/Desktop/testmodules/adf43518& 
/home/pi/Desktop/testmodules/adf43514& 
/home/pi/Desktop/testmodules/adf43513&
/home/pi/Desktop/testmodules/adf4351& 
/home/pi/Desktop/testmodules/adf43512

BBB=0
#$(($RANDOM % 9 + 1))
BBB2=0
#$(($RANDOM % 9 + 1))
BBB3=0
#$(($RANDOM % 9 + 1))
BBB4=0
#$(($RANDOM % 9 + 1))
BBB5=0
#$(($RANDOM % 9 + 1))

/home/pi/Desktop/testmodules/adf4351 "257."$BBB5"00000" 25000000 $C
/home/pi/Desktop/testmodules/adf43512 "257."$BBB5"00003" 25000000 $C
/home/pi/Desktop/testmodules/adf43515 "257."$BBB"00000" 25000000 $C
/home/pi/Desktop/testmodules/adf43516 "257."$BBB"00005" 25000000 $C

/home/pi/Desktop/testmodules/adf43517 "258."$BBB2"00000" 25000000 $C
/home/pi/Desktop/testmodules/adf43518 "258."$BBB2"00005" 25000000 $C

/home/pi/Desktop/testmodules/adf4351 "259."$BBB3"00000" 25000000 $C
/home/pi/Desktop/testmodules/adf43512 "259."$BBB3"00001" 25000000 $C

/home/pi/Desktop/testmodules/adf43513 "256."$BBB4"00000" 25000000 $C
/home/pi/Desktop/testmodules/adf43514 "256."$BBB4"00005" 25000000 $C



#sleep 0.5
sleep 1200

done
