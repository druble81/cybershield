#!/bin/bash
sudo bash /home/pi/Desktop/ramdisk.sh
cd /home/pi/Desktop
bash fixpermissions.sh
cp 10k/adf4351 /tmp/ramdisk/adf43512s
cp 10k/adf43512 /tmp/ramdisk/adf435122
cp 10k/adf43513 /tmp/ramdisk/adf435132
cp 10k/adf43514 /tmp/ramdisk/adf435142
cp 10k/adf43515 /tmp/ramdisk/adf435152
cp 10k/adf43516 /tmp/ramdisk/adf435162
cp 10k/adf43517 /tmp/ramdisk/adf435172
cp 10k/adf43518 /tmp/ramdisk/adf435182
cp 10k/adf43519 /tmp/ramdisk/adf435192
cp alloffrd.sh /tmp/ramdisk/alloffrd.sh
cp /bin/pkill /tmp/ramdisk/pkill

cp adf4351 /tmp/ramdisk/adf4351
cp adf43512 /tmp/ramdisk/adf43512
cp adf43513 /tmp/ramdisk/adf43513
cp adf43514 /tmp/ramdisk/adf43514
cp adf43515 /tmp/ramdisk/adf43515
cp adf43516 /tmp/ramdisk/adf43516
cp adf43517 /tmp/ramdisk/adf43517
cp adf43518 /tmp/ramdisk/adf43518
cp adf43519 /tmp/ramdisk/adf43519
cp loadrd.sh /tmp/ramdisk/loadrd.sh

cat /dev/null > /tmp/ramdisk/SG3.TXT

A=300

while [[ $A -lt 400 ]]
do
 printf "%s\n" $A   >> /tmp/ramdisk/SG3.TXT
A=$(($A+1))
done
exit
A=900

while [[ $A -lt 1000 ]]
do
 printf "%s\n" $A   >> /tmp/ramdisk/SG3.TXT
A=$(($A+1))
done
exit

 printf "%s\n" 4180   >> /tmp/ramdisk/SG3.TXT

printf "%s\n" 4080   >> /tmp/ramdisk/SG3.TXT



 printf "%s\n" 750   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 850   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 950   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1050   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1150   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1350   >> /tmp/ramdisk/SG3.TXT


 printf "%s\n" 1450   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1550   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1650   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1750   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2135   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 4090   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 3050   >> /tmp/ramdisk/SG3.TXT

done

#printf "%s\n" 60   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 100   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 120   >> /tmp/ramdisk/SG3.TXT



#printf "%s\n" 100   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 125   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 150   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 175   >> /tmp/ramdisk/SG3.TXT

#printf "%s\n" 200   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 225   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 250   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 275   >> /tmp/ramdisk/SG3.TXT 

#printf "%s\n" 300   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 325   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 350   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 375   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 400   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 425   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 450   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 475   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 500   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 525   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 550   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 575   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 600   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 625   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 650   >> /tmp/ramdisk/SG3.TXT
#printf "%s\n" 675   >> /tmp/ramdisk/SG3.TXT



 #printf "%s\n" 700   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 800   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 900   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1000   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1100   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 1200   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1300   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1400   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1500   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1600   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1700   >> /tmp/ramdisk/SG3.TXT

 #printf "%s\n" 725   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 825   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 925   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 1025   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 1125   >> /tmp/ramdisk/SG3.TXT
# printf "%s\n" 1225   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1325   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1425   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1525   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1625   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1725   >> /tmp/ramdisk/SG3.TXT

 #printf "%s\n" 750   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 850   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 950   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1050   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1150   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 1250   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1350   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1450   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1550   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1650   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1750   >> /tmp/ramdisk/SG3.TXT

 #printf "%s\n" 775   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 875   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 975   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1075   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1175   >> /tmp/ramdisk/SG3.TXT
# printf "%s\n" 1275   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1375   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1475   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1575   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1675   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1775   >> /tmp/ramdisk/SG3.TXT

done
exit

 
 printf "%s\n" 2000   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2100   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2200   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2300   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 2700   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 2600   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 2500   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1800   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1900   >> /tmp/ramdisk/SG3.TXT
 

 printf "%s\n" 2050   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2150   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2250   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2350   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 2750   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 2650   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 2550   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1850   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1950   >> /tmp/ramdisk/SG3.TXT

 printf "%s\n" 2025   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2125   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2225   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2325   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 2725   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 2625   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 2525   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1825   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 1925   >> /tmp/ramdisk/SG3.TXT

 printf "%s\n" 2075   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2175   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2275   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2375   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 2775   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 2675   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 2575   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 1875   >> /tmp/ramdisk/SG3.TXT
 #printf "%s\n" 1975   >> /tmp/ramdisk/SG3.TXT

exit
done
 printf "%s\n" 2800   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2900   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3000   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3100   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3200   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3300   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3400   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3500   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3600   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3700   >> /tmp/ramdisk/SG3.TXT

 printf "%s\n" 2825   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2925   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3025   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3125   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3225   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3325   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3425   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3525   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3625   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3725   >> /tmp/ramdisk/SG3.TXT
 
 printf "%s\n" 2850   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2950   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3050   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3150   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3250   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3350   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3450   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3550   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3650   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3750   >> /tmp/ramdisk/SG3.TXT
 
 printf "%s\n" 2875   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 2975   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3075   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3175   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3275   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3375   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3475   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3575   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3675   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3775   >> /tmp/ramdisk/SG3.TXT



 printf "%s\n" 3800   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3900   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 4000   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 4100   >> /tmp/ramdisk/SG3.TXT
 
 printf "%s\n" 3825   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3925   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 4025   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 4125   >> /tmp/ramdisk/SG3.TXT
 
 printf "%s\n" 3850   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3950   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 4050   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 4150   >> /tmp/ramdisk/SG3.TXT
 
 printf "%s\n" 3875   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 3975   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 4075   >> /tmp/ramdisk/SG3.TXT
 printf "%s\n" 4175   >> /tmp/ramdisk/SG3.TXT
 
