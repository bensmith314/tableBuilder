#!/bin/bash

# Function bar takes in 1 required input and up to 2 option inputs
#  The purpose of this function is to print out a character across the width
#  of the current terminal window
# Input $1 (String) is the character to be printed. Needs to be only 1 character
#  long. There is internal validation for this.
# Input $2 (boolean) determines whether to add a trailing new line character
#  or not after the bar of characters has been printed. Defaults to TRUE
# Input $3 (int) is an optional input if a custom width is needed that isn't
#  the width of the current terminal window
function bar() {
  termWidth=$(tput cols)
  strlen=${#1}

  if [[ $strlen -gt 1 ]]; then
    printf "[WARNING] Parameter \$1 of function bar()"
    printf "can only be 1 character long\n"
    return
  fi

  if [[ $3 -gt 0 ]]; then
    width=$3
  else
    width=$termWidth
  fi

  for (( i = 0; i < $width; i++ )); do
    printf $1
  done

  if [[ $2 = true ]]; then
    echo
  fi
}
