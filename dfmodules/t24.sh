clear
echo  **********--------- Low Triple Heterodyne Forty TBS----------**********


#####   PRIMARY FREQ's  
#####   These will alter penetration depth
#####   range is 35-4300   4300 will have very shallow depth. 35 will offer deepest
#####   the power levels will be strongest between 400-2700

####TO SET PRIMARY RANGE######
##START OF 350 and Length of 100 is 350-450

STARTFREQ1=4000
LENGTH1=200
STARTFREQ2=1000
LENGTH2=3200
STARTFREQ3=300
LENGTH3=3100
STARTFREQ4=300
LENGTH4=3100
STARTFREQ5=4200
LENGTH5=200
STARTFREQ6=4000
LENGTH6=200
STARTFREQ7=1000
LENGTH7=3200
STARTFREQ8=1000
LENGTH8=3200




##### Freq for heterodyne effect
##### please use the format "000000"
##### 10hz would be "000010"
##### 10khz would be "010000"

hz1="0000"$(($RANDOM % 5 + 27)).$(($RANDOM % 10000))
hz2="0000"$(($RANDOM % 5 + 27)).$(($RANDOM % 10000))																																																																																																				
hz3="0000"$(($RANDOM % 5 + 27)).$(($RANDOM % 10000))
hz4="0000"$(($RANDOM %  5 + 27)).$(($RANDOM % 10000))
hz5="0000"$(($RANDOM % 5 + 27)).$(($RANDOM % 10000))
hz9="000"$(($RANDOM % 540 + 100)).$(($RANDOM % 10000))




#hz1="000050"
#hz2="000050"
#hz3="000050"
#hz4="000050"

## please make 9th antenna piggy  back off 1st antenna for .10 seconds before
## moving to second set of antennas with .6 break inbetween... then to 3rd and 4th
## then 1.2 second gap and restart with another antenna... randomly... 
### 300 hz aapart from hrrent heterodyne 


hz12="0"$(($RANDOM % 300 + 10000))
hz22="0"$(($RANDOM % 100 + 20000))
hz32="0"$(($RANDOM % 100 + 30000))
hz42="000"$(($RANDOM % 540 + 100))
hz52="000"$(($RANDOM % 540 + 100))
hz92="000"$(($RANDOM % 361 + 250))##############NEW ONE FOR 9#############################

##### Power LEVEL
##### use 0 - 3

p1=3
p2=3
p3=3
p4=3
p5=3

p12=3
p22=3
p32=3
p42=3
p52=3

##### PULSE LENGTH
##### 0.00005 = 50 microseconds

pulselength=0.170

pulselength2=0.170

holdprimarymax=19
holdprimary=19

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
if [[ "$holdprimary" -eq "$holdprimarymax" ]]
then
echo "Primary Changing"
holdprimary=0
##please make thislast 20 seconds##
carrier1=$(($RANDOM % $LENGTH1 + $STARTFREQ1)).$(($RANDOM % 10000))
carrier2=$(($RANDOM % $LENGTH2 + $STARTFREQ2)).$(($RANDOM % 10000))
carrier3=$(($RANDOM % $LENGTH3 + $STARTFREQ3)).$(($RANDOM % 10000))
carrier4=$(($RANDOM % $LENGTH4 + $STARTFREQ4)).$(($RANDOM % 10000))

carrier12=$(($RANDOM % $LENGTH5 + $STARTFREQ5)).$(($RANDOM % 10000))
carrier22=$(($RANDOM % $LENGTH6 + $STARTFREQ6)).$(($RANDOM % 10000))
carrier32=$(($RANDOM % $LENGTH7 + $STARTFREQ7)).$(($RANDOM % 10000))
carrier42=$(($RANDOM % $LENGTH8 + $STARTFREQ8)).$(($RANDOM % 10000))
fi
clear
echo  **********----------Triple Heterodyne Forty TBS----------**********
echo carrier 1 $carrier1
echo carrier 2 $carrier2
echo carrier 3 $carrier3
echo carrier 4 $carrier4
echo carrier 5 $carrier12
echo carrier 6 $carrier22
echo carrier 7 $carrier32
echo carrier 8 $carrier42


#######################This will add a range to hz1##########################
#hz1="0"$(($RANDOM % 300 + 300))
#######################This will add a range to hz1##########################
#######################This will add a range to hz2##########################
#hz2="000"$(($RANDOM % 540 + 300))
#######################This will add a range to hz2##########################
#######################This will add a range to hz3##########################
#hz3="0"$(($RANDOM % 50 + 300))
########################This will add a range to hz3##########################
#######################This will add a range to hz4##########################
#hz4="0000"$(($RANDOM % 6 + 300))
#######################This will add a range to hz4##########################

#######################This will let you exclude a range from a range###############
rnd=$(($RANDOM % 100 + 1))
while [ $rnd -gt 16 ] | [  $rnd -lt 25 ]
do
rnd=$(($RANDOM % 100 + 1))
done
#hz5=$rnd


####PULSE 2
#######################This will add a range to hz1##########################
#hz12="0"$(($RANDOM % 300 + 300))
#######################This will add a range to hz1##########################
#######################This will add a range to hz2##########################
#hz22="000"$(($RANDOM % 540 + 300))
#######################This will add a range to hz2##########################
#######################This will add a range to hz3##########################
#hz32="0"$(($RANDOM % 50 + 300))
#######################This will add a range to hz3##########################
#######################This will add a range to hz4##########################
#hz42="0000"$(($RANDOM % 6 + 300))
#######################This will add a range to hz4##########################

#######################This will let you exclude a range from a range###############
rnd=$(($RANDOM % 100 + 1))
while [ $rnd -gt 16 ] | [  $rnd -lt 25 ]
do
rnd=$(($RANDOM % 100 + 1))
done
#hz52=$rnd

hz12="0"$(($RANDOM % 500 + 12000)).$(($RANDOM % 10000))
hz22="0"$(($RANDOM % 640 + 12360)).$(($RANDOM % 10000))
hz32="0"$(($RANDOM % 500 + 10646)).$(($RANDOM % 10000))
hz42="0"$(($RANDOM % 300 + 14002)).$(($RANDOM % 10000))
hz52="0"$(($RANDOM %  500 + 12054)).$(($RANDOM % 10000))
hz92="0"$(($RANDOM %  500 + 12054)).$(($RANDOM % 10000))

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
sleep 0.01
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
/home/pi/Desktop/testmodules/adf43519 $carrier3.$hz9 25000000 $p4&

holdprimary=$(($holdprimary+1))
echo $holdprimary
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
sleep 0.1
fi


####ACTIVATE MODULES#####
/home/pi/Desktop/testmodules/adf4351 $carrier12 25000000 $p12&
/home/pi/Desktop/testmodules/adf43512 $carrier12.$hz12 25000000 $p12&
/home/pi/Desktop/testmodules/adf43513 $carrier22 25000000 $p22&
/home/pi/Desktop/testmodules/adf43514 $carrier22.$hz22 25000000 $p22&
/home/pi/Desktop/testmodules/adf43515 $carrier32 25000000 $p32&
/home/pi/Desktop/testmodules/adf43516 $carrier32.$hz32 25000000 $p32&
/home/pi/Desktop/testmodules/adf43519 $carrier32.$hz92 25000000 $p32&
/home/pi/Desktop/testmodules/adf43517 $carrier42 25000000 $p42&
/home/pi/Desktop/testmodules/adf43518 $carrier42.$hz42 25000000 $p42&


sleep $pulselength2



fi

done