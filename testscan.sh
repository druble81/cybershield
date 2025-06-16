  
A1_FILE="/tmp/ramdisk/A1.txt"
A2_FILE="/tmp/ramdisk/A2.txt"
sudo pkill -f loadrd
sudo rm /tmp/ramdisk/SG3.TXT
  
  A=35
  
  
    while [[ $A -lt 4151 ]]
    do
	
	cat /dev/null > /tmp/ramdisk/SG3.TXT
	C=$(($A + $1))
    echo "$A" > "$A1_FILE"
    echo "$C" > "$A2_FILE"
    
    B=$A
    
        while [[ $B -lt $(($A + $1)) ]]
    do

    # Assign the result to a variable
    
    printf "%s\n" $B   >> /tmp/ramdisk/SG3.TXT
        B=$(($B+1))
    done
    echo "$A - $(($A + $1))"
    
       
    A=$(($A + $1))
    
    
    
    
    
pkill adf4351    
sleep 0.3

/tmp/ramdisk/adf4351 1000 25000000 $C $B&
/tmp/ramdisk/adf43512 1000 25000000 $C $B&
/tmp/ramdisk/adf43513 1000 25000000 $C $A&
/tmp/ramdisk/adf43514 1000 25000000 $C $B&
/tmp/ramdisk/adf43515 1000 25000000 $C $B&
/tmp/ramdisk/adf43516 1000 25000000 $C $B&
/tmp/ramdisk/adf43517 1000 25000000 $C $B&
/tmp/ramdisk/adf43518 1000 25000000 $C $B&
/tmp/ramdisk/adf43519 1000 25000000 $C $B&
read -n 1 -s -r -p "Press any key to continue..."
    
    done
