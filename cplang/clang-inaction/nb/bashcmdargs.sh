#!/bin/sh


if [ "$#" -eq "0" ]; then
  echo "Error! Usage: ${0} opt1=value opt2=value"
  exit 1
fi

while [[ "$#" > "0" ]]
do
  case $1 in
    (*=*) eval $1;;
  esac
shift
done

#echo $opt1
#echo $opt2
