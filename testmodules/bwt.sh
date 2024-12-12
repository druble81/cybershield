#!/bin/bash

# Function to run Relaxation and Sleep program with pulsed Alpha
relaxation_and_sleep() {
  echo "Resetting all modules..."
  bash /home/pi/Desktop/alloffrd.sh  # Reset all modules before starting the program

  echo "Running Relaxation and Sleep program..."

  # Module 1 (Primary frequency 100 MHz for Relaxation and Sleep)
  ./adf43512 100.000000

  # Module 2 (Delta 2.5 Hz)
  ./adf43513 100.000002

  # Module 3 (Theta 6 Hz)
  ./adf43514 100.000006

  # Module 5 (Low Beta 13 Hz)
  ./adf43516 100.000013

  # Module 6 (Mid Beta 18 Hz)
  ./adf43517 100.000018

  # Module 7 (Gamma 40 Hz)
  ./adf43518 100.000040

  # Module 8 (High Gamma 80 Hz)
  ./adf43519 100.000080

  # Pulsing Alpha frequency (10 Hz) on Module 4
  echo "Pulsing Alpha frequency (10 Hz)... Press any key to stop."

  # Loop indefinitely until a key is pressed
  while true; do
    # Turn Alpha on (0.17 seconds)
    ./adf43515 100.000010
    sleep 0.17

    # Turn Alpha off (no arguments, 0.2 seconds)
    ./adf43515
    sleep 0.2

    # Check for key press in the background
    read -n 1 -s -t 0.01 keypress
    if [ "$keypress" ]; then
      echo "Key pressed, stopping Alpha pulse..."
      break
    fi
  done

  echo "Relaxation and Sleep program stopped."
}

# Function to run Focus and Learning program with pulsed Gamma (40 Hz)
focus_and_learning() {
  echo "Resetting all modules..."
  bash /home/pi/Desktop/alloffrd.sh  # Reset all modules before starting the program

  echo "Running Focus and Learning program..."

  # Module 1 (Primary frequency 100 MHz for Focus and Learning)
  ./adf43512 100.000000

  # Module 2 (Alpha 10 Hz)
  ./adf43513 100.000010

  # Module 3 (Low Beta 13 Hz)
  ./adf43514 100.000013

  # Module 4 (Mid Beta 18 Hz)
  ./adf43515 100.000018

  # Turn on constant frequencies first before pulsing Gamma
  # Pulsing Gamma frequency (40 Hz) on Module 5
  echo "Pulsing Gamma frequency (40 Hz)... Press any key to stop."
  
  # Loop for pulsing Gamma frequency
  while true; do
    # Turn Gamma on (0.5 seconds)
    ./adf43516 100.000040
    sleep 0.5

    # Turn Gamma off (no arguments, 0.5 seconds)
    ./adf43516
    sleep 0.5

    # Check for key press in the background
    read -n 1 -s -t 0.01 keypress
    if [ "$keypress" ]; then
      echo "Key pressed, stopping Gamma pulse..."
      break
    fi
  done

  echo "Focus and Learning program running."
}

# Function to run REM Sleep program with pulsed Gamma (40 Hz)
rem_sleep() {
  echo "Resetting all modules..."
  bash /home/pi/Desktop/alloffrd.sh  # Reset all modules before starting the program

  echo "Running REM Sleep program..."

  # Module 1 (Primary frequency 100 MHz for REM Sleep)
  ./adf43512 100.000000

  # Module 2 (Theta 6 Hz)
  ./adf43513 100.000006

  # Module 3 (Alpha 10 Hz)
  ./adf43514 100.000010

  # Turn on constant frequencies first before pulsing Gamma
  # Pulsing Gamma frequency (40 Hz) on Module 4
  echo "Pulsing Gamma frequency (40 Hz)... Press any key to stop."
  
  # Loop for pulsing Gamma frequency
  while true; do
    # Turn Gamma on (0.5 seconds)
    ./adf43515 100.000040
    sleep 0.5

    # Turn Gamma off (no arguments, 0.5 seconds)
    ./adf43515
    sleep 0.5

    # Check for key press in the background
    read -n 1 -s -t 0.01 keypress
    if [ "$keypress" ]; then
      echo "Key pressed, stopping Gamma pulse..."
      break
    fi
  done

  echo "REM Sleep program running."
}

# Function to run High Activity (Sports) program with pulsed Beta
high_activity() {
  echo "Resetting all modules..."
  bash /home/pi/Desktop/alloffrd.sh  # Reset all modules before starting the program

  echo "Running High Activity (Sports) program..."

  # Module 1 (Primary frequency 100 MHz for High Activity)
  ./adf43512 100.000000

  # Turn on constant frequencies first before pulsing Beta
  # Pulsing Beta frequency (15 Hz) on Module 2
  echo "Pulsing Beta frequency (15 Hz)... Press any key to stop."
  
 

  # Module 3 (Gamma 40 Hz)
  ./adf43514 100.000040

  # Module 4 (High Gamma 80 Hz)
  ./adf43515 100.000080

  echo "High Activity (Sports) program running."

 # Loop for pulsing Beta frequency
  while true; do
    # Turn Beta on (0.25 seconds)
    ./adf43513 100.000015
    sleep 0.25

    # Turn Beta off (no arguments, 0.25 seconds)
    ./adf43513
    sleep 0.25

    # Check for key press in the background
    read -n 1 -s -t 0.01 keypress
    if [ "$keypress" ]; then
      echo "Key pressed, stopping Beta pulse..."
      break
    fi
  done
}

# Function to run DLPFC Stimulation program
dlpfc_stimulation() {
  echo "Resetting all modules..."
  bash /home/pi/Desktop/alloffrd.sh  # Reset all modules before starting the program

  echo "Running DLPFC Stimulation program..."

  # Module 1 (Primary frequency 100 MHz for DLPFC)
  ./adf43512 100.000000

  # Continuous Alpha frequency (10 Hz) on Module 4 for relaxation and reducing stress
  ./adf43515 100.000010
  echo "Alpha frequency (10 Hz) running continuously for DLPFC..."

  # Turn on constant frequencies first before pulsing Beta
  # Pulsing Beta frequency (15 Hz) on Module 2 for attention and working memory
  echo "Pulsing DLPFC Beta frequency (15 Hz)... Press any key to stop."
  
  while true; do
    # Turn Beta on (0.25 seconds)
    ./adf43513 100.000015
    sleep 0.25

    # Turn Beta off (no arguments, 0.25 seconds)
    ./adf43513
    sleep 0.25

    # Check for key press to stop pulsing
    read -n 1 -s -t 0.01 keypress
    if [ "$keypress" ]; then
      echo "Key pressed, stopping Beta pulse..."
      break
    fi
  done

  # Pulsing Gamma frequency (40 Hz) on Module 3 for cognitive flexibility and memory
  echo "Pulsing DLPFC Gamma frequency (40 Hz)... Press any key to stop."
  
  while true; do
    # Turn Gamma on (0.5 seconds)
    ./adf43514 100.000040
    sleep 0.5

    # Turn Gamma off (no arguments, 0.5 seconds)
    ./adf43514
    sleep 0.5

    # Check for key press to stop pulsing
    read -n 1 -s -t 0.01 keypress
    if [ "$keypress" ]; then
      echo "Key pressed, stopping Gamma pulse..."
      break
    fi
  done


}

# Function to run PFC Stimulation program
pfc_stimulation() {
  echo "Starting PFC Stimulation program..."

  # Module 5 (Primary frequency 110 MHz for PFC)
  ./adf43516 110.000000

  # Turn on constant frequencies first before pulsing Theta
 

  # Continuous Beta frequency (15 Hz) on Module 7 for decision making and attention
  ./adf43518 110.000015
  echo "Beta frequency (15 Hz) running continuously for PFC..."
  
  # Continuous Gamma frequency (40 Hz) on Module 8 for executive functions and focus
  ./adf43519 110.000040
  echo "Gamma frequency (40 Hz) running continuously for PFC..."
  
  echo "PFC Stimulation program running."

 # Pulsing Theta frequency (6 Hz) on Module 6 for creativity and emotional regulation
  echo "Pulsing PFC Theta frequency (6 Hz)... Press any key to stop."
  
  while true; do
    # Turn Theta on (0.5 seconds)
    ./adf43517 110.000006
    sleep 0.5

    # Turn Theta off (no arguments, 0.5 seconds)
    ./adf43517
    sleep 0.5

    # Check for key press to stop pulsing
    read -n 1 -s -t 0.01 keypress
    if [ "$keypress" ]; then
      echo "Key pressed, stopping Theta pulse..."
      break
    fi
  done
}

# Function to run Pain Blocking program
pain_blocking() {
  echo "Resetting all modules..."
  bash /home/pi/Desktop/alloffrd.sh  # Reset all modules before starting the program

  echo "Running Pain Blocking program..."

  # Module 1 (Primary frequency 100 MHz for Pain Block)
  ./adf43512 100.000000

  # Continuous Alpha frequency (10 Hz) on Module 3 for relaxation and stress reduction
  ./adf43514 100.000010
  echo "Alpha frequency (10 Hz) running continuously for pain relief..."

  # Continuous High-Frequency (15 kHz) on Module 4 for nerve pain blocking
  ./adf43515 100.015000
  echo "High-Frequency (15 kHz) running continuously to block pain signals..."

  # Turn on constant frequencies first before pulsing Gamma
  # Pulsing Gamma frequency (40 Hz) on Module 2 for pain modulation
  echo "Pulsing Gamma frequency (40 Hz)... Press any key to stop."

  while true; do
    # Turn Gamma on (0.5 seconds)
    ./adf43513 100.000040
    sleep 0.5

    # Turn Gamma off (no arguments, 0.5 seconds)
    ./adf43513
    sleep 0.5

    # Check for key press to stop pulsing
    read -n 1 -s -t 0.01 keypress
    if [ "$keypress" ]; then
      echo "Key pressed, stopping Gamma pulse..."
      break
    fi
  done
}

# Function to show menu and get user choice
show_menu() {
  echo "Choose a program to run:"
  echo "1) Relaxation and Sleep"
  echo "2) Focus and Learning"
  echo "3) REM Sleep"
  echo "4) High Activity (Sports)"
  echo "5) DLPFC Stimulation"
  echo "6) PFC Stimulation"
  echo "7) Pain Blocking"
  echo "8) Exit"
}

# Main loop
while true; do
  show_menu
  read -p "Enter your choice (1-8): " choice
  case $choice in
    1)
      relaxation_and_sleep
      ;;
    2)
      focus_and_learning
      ;;
    3)
      rem_sleep
      ;;
    4)
      high_activity
      ;;
    5)
      dlpfc_stimulation
      ;;
    6)
      pfc_stimulation
      ;;
    7)
      pain_blocking
      ;;
    8)
      echo "Exiting..."
      bash /home/pi/Desktop/alloffrd.sh  # Reset all modules before exiting
      exit 0
      ;;
    *)
      echo "Invalid choice. Please enter a number between 1 and 8."
      ;;
  esac
done
