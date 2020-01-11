#!/bin/bash -x
echo "==WELCOME TO GAMBLER SIMULATOR=="

#Constants
declare LOOSING_AMOUNT=0
declare STAKE_AMOUNT=100
declare STAKE_DAYS=20
declare STAKE_BET=1

#Dictionary
declare -A gamblerDictionary

#Variables
lowerLimit=50
higherLimit=150
totalAmount=0

#Function for betting
function betting()
{
	for (( i=1;i<=$STAKE_DAYS;i++ ))
	do
		stakeAmount=$STAKE_AMOUNT
		while [ $stakeAmount -gt $LOOSING_AMOUNT ]
		do
			if [ $((RANDOM%2)) -eq 1 ]
			then
				stakeAmount=$(($stakeAmount + $STAKE_BET))
			else
				stakeAmount=$(($stakeAmount - $STAKE_BET ))
			fi

			#If Won Credit 50
			if [ $stakeAmount -gt $higherLimit ]
      	then
				gamblerDictionary[$i]=$(($STAKE_AMOUNT+50))
				totalAmount=$(($totalAmount+50))
				break
			#If Loose Debit 50
			elif [ $stakeAmount -lt $lowerLimit ]
			then
         	gamblerDictionary[$i]=$(($STAKE_AMOUNT - 50))
				totalAmount=$(($totalAmount-50))
      		break
      	fi
		done
	done
	echo $totalAmount
}

#Function to calculate Upper and Lower limit
function calLowerAndUpperLimit()
{
	lowerLimit=$(($(($lowerLimit*$STAKE_AMOUNT))/100))
	higherLimit=$(($(($higherLimit*$STAKE_AMOUNT))/100))
}

#Calling functions
calLowerAndUpperLimit
betting $STAKE_DAYS 
echo ${gamblerDictionary[@]}



