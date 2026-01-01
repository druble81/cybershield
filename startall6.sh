cd /home/pi/Desktop/testmodules
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
echo  **********----------WAKE-- RUNNING----------**********


FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi

two=150
one=430


hz1=7
hz2=11
hz3=15
hz4=19

hz1=10

gethz=$(python3 /home/pi/Desktop/selecthz.py)

while :
do

BB=$(($RANDOM % ($two-$one+1) + $one))

offset=$((RANDOM % (990000 - 100000 + 1) + 100000))

BB1=$(($BB))
BB2=$(($BB))
BB3=$(($BB))




    # Increment hz1 by 10 each loop
    hz1=$((hz1 + 1))

    # Stop or reset when reaching 660
    if [ $hz1 -gt $gethz ]; then
        hz1=0   # reset to 0, or you could break the loop instead
	exit
    fi


hz2=$hz1
hz3=$hz1
hz4=$hz1



#echo $BB1.$offset
#echo $BB1.$(($offset+$hz1))



BB44=$(($RANDOM%3+1))


  ./adf4351 $BB.$offset 25000000 $C &
  ./adf43512 $BB.$(($offset+hz1)) 25000000 $C &
  ./adf43513 $BB1.$(($offset+hz2)) 25000000 $C &
  ./adf43514 $BB1.$offset 25000000 $C &
  ./adf43515 $BB2.$offset 25000000 $C &
  ./adf43516 $BB2.$(($offset+hz3)) 25000000 $C &
  ./adf43517 $BB3.$(($offset+hz4)) 25000000 $C &
  ./adf43518 $BB3.$offset 25000000 $C &

sleep 0.2
echo $hz1
#sleep $(($RANDOM%5+1))

done
