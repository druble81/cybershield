clear
echo  **********----------Pain Mode RUNNING----------**********
echo  **********----------Pain Mode RUNNING----------*********

sudo pkill -f adf4351

/home/pi/Desktop/testmodules/adf43519& 
/home/pi/Desktop/testmodules/adf43516&
/home/pi/Desktop/testmodules/adf43515& 
/home/pi/Desktop/testmodules/adf43517& 
/home/pi/Desktop/testmodules/adf43518& 
/home/pi/Desktop/testmodules/adf43514& 
/home/pi/Desktop/testmodules/adf43513&
/home/pi/Desktop/testmodules/adf4351& 
/home/pi/Desktop/testmodules/adf43512

RANDOM=$$

A=$(($RANDOM % 2 + 35))
B=$(($RANDOM % 2 + 37))



/home/pi/Desktop/testmodules/adf43513 $A.000040 25000000 0
/home/pi/Desktop/testmodules/adf43512 $B.000010 25000000 0
/home/pi/Desktop/testmodules/adf4351 $A 25000000 0
/home/pi/Desktop/testmodules/adf43514 $B 25000000 0

#/home/pi/Desktop/testmodules/adf43515 36.000040 25000000 0
#/home/pi/Desktop/testmodules/adf43516 38.100010 25000000 0
#/home/pi/Desktop/testmodules/adf43517 35 25000000 0
#/home/pi/Desktop/testmodules/adf43518 38.1 25000000 0
