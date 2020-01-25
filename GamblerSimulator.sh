#!/bin/bash -x
echo "==WELCOME TO GAMBLER SIMULATOR=="

#Constants
declare LOOSING_AMOUNT=0
declare STAKE_AMOUNT=100
declare STAKE_DAYS=30
declare STAKE_BET=1

#Dictionary
declare -A gamblerDictionary

#Variables
lowerLimit=50
higherLimit=150
totalAmount=0
win=0
loose=0
luckiest=0
unLuckiest=10000
counter=0

#Function for betting
function betting()
{
	for (( i=1;i<=$STAKE_DAYS;i++ ))
	do
		stakeAmount=$(($totalAmount+$STAKE_AMOUNT))
		while [ $stakeAmount -gt $LOOSING_AMOUNT ]
		do
			if [ $stakeAmount -gt 0 ]
			then
				if [ $((RANDOM%2)) -eq 1 ]
				then
					stakeAmount=$(($stakeAmount + $STAKE_BET))
				else
					stakeAmount=$(($stakeAmount - $STAKE_BET ))
				fi
			fi

			#If Won Credit 50
			if [ $stakeAmount -gt $higherLimit ]
      	then
				((win++))
				gamblerDictionary[$i]=50
				break
			#If Loose Debit 50
			elif [ $stakeAmount -lt $lowerLimit ]
			then
				((loose++))
         	gamblerDictionary[$i]=-50
      		break
      	fi
		done
	done
}

function convertingDictionarytoArray()
{
		for key in ${!gamblerDictionary[@]}
		do
			GamblerArray[((counter++))]=${gamblerDictionary[$key]}
	   done
		#  echo    "Computation Array is::" ${GamblerArray[@]}
}

function findingTheMaximumWonBet()
{
		for luckVal in ${GamblerArray[@]}
      do
         if [ $luckVal -gt $luckiest ]
         then
             luckiest=$luckVal
         fi
         if [ $luckVal -lt $unLuckiest ]
         then
             unLuckiest=$luckVal
         fi
		done
}

function findingLuckiestDay()
{
	for key in ${!gamblerDictionary[@]}
	do
		if [ ${gamblerDictionary[$key]} -eq  $luckiest ]
      then
          echo "Lucky Day-------->"$key
          break
      fi
	done
}

function findingUnluckiestDay()
{
	for key in ${!gamblerDictionary[@]}
	do
		if [ ${gamblerDictionary[$key]} -eq  $unLuckiest ]
      then
			echo "UnLucky Day-------->"$key
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

#Function to calculate Percentage of win or Loose in a month
function WonOrLooseInMonth()
{
	winningPer=$(($win*100/$STAKE_DAYS));
	loosingPer=$(($loose*100/$STAKE_DAYS));
	#echo ${gamblerDictionary[@]}
}

#Calling functions
calLowerAndUpperLimit
betting $STAKE_DAYS
WonOrLooseInMonth
convertingDictionarytoArray
findingTheMaximumWonBet
findingLuckiestDay
findingUnluckiestDay
echo ${!gamblerDictionary[@]}
echo ${gamblerDictionary[@]}




