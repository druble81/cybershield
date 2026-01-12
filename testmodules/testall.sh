C=1
sudo bash /home/pi/Desktop/alloffrd.sh
sudo pkill -f "adf4351[0-9]*"

./adf4351 500.5 25000000 $C --pd
./adf4351 500.5 25000000 $C --pd
echo 1 on
sleep 1
./adf4351 off
echo 1 off
sleep 1
./adf43512 500.5 25000000 $C --pd
./adf43512 500.5 25000000 $C --pd
echo 2 on
sleep 1
./adf43512 off
echo 2 off
sleep 1
./adf43513 500.5 25000000 $C --pd
./adf43513 500.5 25000000 $C --pd
echo 3 on
sleep 1
./adf43513 off
echo 3 off
sleep 1
./adf43514 500.5 25000000 $C --pd
./adf43514 500.5 25000000 $C --pd
echo 4 on
sleep 1
./adf43514 off
echo 4 off
sleep 1
./adf43515 500.5 25000000 $C --pd
./adf43515 500.5 25000000 $C --pd
echo 5 on
sleep 1
./adf43515 off
echo 5 off
sleep 1
./adf43516 500.5 25000000 $C --pd
./adf43516 500.5 25000000 $C --pd
echo 6 on
sleep 1
./adf43516 off
echo 6 off
sleep 1
./adf43517 500.5 25000000 $C --pd
./adf43517 500.5 25000000 $C --pd
echo 7 on
sleep 1
./adf43517 off
echo 7 off
sleep 1
./adf43518 500.5 25000000 $C --pd
./adf43518 500.5 25000000 $C --pd
echo 8 on
sleep 1
./adf43518
echo 8 off
sleep 1
./adf43519 500.5 25000000 $C --pd
./adf43519 500.5 25000000 $C --pd
echo 9 on
sleep 1
./adf43519 off
echo 9 off
sleep 1
