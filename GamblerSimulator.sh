#!/bin/bash -x
echo "==WELCOME TO GAMBLER SIMULATOR=="

#Declaring Constants
declare STAKE_AMOUNT=100;
declare BET_AMOUNT=1;
declare STAKE_DAYS=30;

#Function for betting
function betting()
{
	if [ $((RANDOM%2)) -eq 1 ]
	then
		win=$(($STAKE_AMOUNT + 1))
		echo $win
	else
		loose=$(($STAKE_AMOUNT - 1))
		echo $loose
	fi
}
#Calling betting() function
betting
