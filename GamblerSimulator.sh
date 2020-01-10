#!/bin/bash -x
echo "==WELCOME TO GAMBLER SIMULATOR=="
declare LOOSING_AMOUNT=0
declare STAKE_AMOUNT=100

stakeAmount=$STAKE_AMOUNT

#Variables
lowerLimit=50
higherLimit=150

#Function for betting
function betting()
{
	while [ $stakeAmount -gt $LOOSING_AMOUNT ]
	do
		if [ $((RANDOM%2)) -eq 1 ]
		then
			stakeAmount=$(($stakeAmount + 1))
		else
			stakeAmount=$(($stakeAmount - 1 ))
		fi

		if [ $stakeAmount -ge $higherLimit ] || [ $stakeAmount -le $lowerLimit ]
		then
			break
		fi
	done
}

#Function to calculate Upper and Lower limit
function calLowerAndUpperLimit()
{
	lowerLimit=$(($(($lowerLimit*$STAKE_AMOUNT))/100))
	higherLimit=$(($(($higherLimit*$STAKE_AMOUNT))/100))
}

#Calling functions
calLowerAndUpperLimit
betting



