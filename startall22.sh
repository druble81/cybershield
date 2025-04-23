clear
echo  **********----------SPECIAL RUNNING----------**********
SA=0

#####   PRIMARY FREQ's  
#####   These will alter penetration depth
#####   range is 35-4300   4300 will have very shallow depth. 35 will offer deepest
#####   the power levels will be strongest between 400-2700

carrier1="500"
carrier2="35"
carrier3="1000"
carrier4="200"

carrier12="500"
carrier22="35"
carrier32="1000"
carrier42="200"

##### Freq for heterodyne effect
##### please use the format "000000"
##### 10hz would be "000010"
##### 10khz would be "010000"

hz1="000300"
hz2="000010"
hz3="000005"
hz4="000080"
hz5="000130"

hz12="000299"
hz22="000009"
hz32="000004"
hz42="000079"
hz52="000129"

##### Power LEVEL
##### use 0 - 3

p1=3
p2=3
p3=3
p4=3
p5=3

p12=2
p22=2
p32=2
p42=2
p52=2

##### PULSE LENGTH
##### 0.00005 = 50 microseconds

pulselength=0.0001
pulselength2=0.01

###TURN ON 2nd PULSE###
###1 = ON
###0 = OFF

twopulse=1

##### PULSE OR CONSTANT
##### 1 = Pulse
##### 0 = Constant

#1st Pulse
pulse=1

#2nd Pulse
secondpulse=1


##############DO NOT EDIT BELOW THIS LINE#################################


while :
do





#######################This will add a range to hz1##########################
#hz1="0"$(($RANDOM % 20000 + 10000))
#######################This will add a range to hz1##########################
#######################This will add a range to hz2##########################
hz2="0"$(($RANDOM % 15 + 20015))
#######################This will add a range to hz2##########################
#######################This will add a range to hz3##########################
hz3="0"$(($RANDOM % 150 + 30015))
#######################This will add a range to hz3##########################
#######################This will add a range to hz4##########################
#hz4="0000"$(($RANDOM % 4 + 12))
#######################This will add a range to hz4##########################





####TURN OFF MODULES####
if [[ $pulse -gt 0 ]]
then
/home/pi/Desktop/testmodules/adf43519& 
/home/pi/Desktop/testmodules/adf43516&
/home/pi/Desktop/testmodules/adf43515& 
/home/pi/Desktop/testmodules/adf43517& 
/home/pi/Desktop/testmodules/adf43518& 
/home/pi/Desktop/testmodules/adf43514& 
/home/pi/Desktop/testmodules/adf43513&
/home/pi/Desktop/testmodules/adf4351&
/home/pi/Desktop/testmodules/adf43512&
fi


####ACTIVATE MODULES#####
/home/pi/Desktop/testmodules/adf4351 $carrier1 25000000 $p1&
/home/pi/Desktop/testmodules/adf43512 $carrier1.$hz1 25000000 $p1&
/home/pi/Desktop/testmodules/adf43513 $carrier2 25000000 $p2&
/home/pi/Desktop/testmodules/adf43514 $carrier2.$hz2 25000000 $p2&
/home/pi/Desktop/testmodules/adf43515 $carrier3 25000000 $p3&
/home/pi/Desktop/testmodules/adf43516 $carrier3.$hz3 25000000 $p3&
/home/pi/Desktop/testmodules/adf43517 $carrier4 25000000 $p4&
/home/pi/Desktop/testmodules/adf43518 $carrier4.$hz4 25000000 $p4&


sleep $pulselength

if [[ $twopulse -gt 0 ]]
then
####TURN OFF MODULES####
if [[ $secondpulse2 -gt 0 ]]
then
/home/pi/Desktop/testmodules/adf43519& 
/home/pi/Desktop/testmodules/adf43516&
/home/pi/Desktop/testmodules/adf43515& 
/home/pi/Desktop/testmodules/adf43517& 
/home/pi/Desktop/testmodules/adf43518& 
/home/pi/Desktop/testmodules/adf43514& 
/home/pi/Desktop/testmodules/adf43513&
/home/pi/Desktop/testmodules/adf4351&
/home/pi/Desktop/testmodules/adf43512&
fi


####ACTIVATE MODULES#####
/home/pi/Desktop/testmodules/adf4351 $carrier12 25000000 $p12&
/home/pi/Desktop/testmodules/adf43512 $carrier12.$hz12 25000000 $p12&
/home/pi/Desktop/testmodules/adf43513 $carrier22 25000000 $p22&
/home/pi/Desktop/testmodules/adf43514 $carrier22.$hz22 25000000 $p22&
/home/pi/Desktop/testmodules/adf43515 $carrier32 25000000 $p32&
/home/pi/Desktop/testmodules/adf43516 $carrier32.$hz32 25000000 $p32&
/home/pi/Desktop/testmodules/adf43517 $carrier42 25000000 $p42&
/home/pi/Desktop/testmodules/adf43518 $carrier42.$hz42 25000000 $p42&


sleep $pulselength2

SA=$(($SA+1))
echo $SA
if [[ $SA -gt 10 ]]
then
bash /home/pi/Desktop/startall.sh&
sleep 3
sudo bash alloffrd.sh
SA=0
fi

fi

done
