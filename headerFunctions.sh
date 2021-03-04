#!/bin/bash

# This function takes in a text string and uses ANSI escape codes to change the
#  the color of the text. To do this the function takes in 2 or 3 inputs.
#
# Input $1 is the text to modify the color of
# Input $2 is the foreground color and all of the following are valid choices:
#  black          green            blue               cyan
#  darkGrey       lightGreen       lightBlue          lightCyan
#  red            brown            magenta            lightGrey
#  lightRed       yellow           lightMagenta       white
# Input $3 is the background color and the following are valid choices:
#  black          red              green              yellow
#  blue           magenta          cyan               lightGrey
#
# This function echos back the modified text following processing, to directly
#  print the text following processing, it is recommended to do one of the
#  following depending on need:
#   printf "$(colorText $1 $2 $3)\n"
#   echo $(colorText $1 $2 $3)
function colorText() {

  # Debugging Flag
  # Set to true in order to get color related errors
  # This by default is set to false and when the funciton detects an invalid
  #  input, the text is set to defualt colors to minimize impact. The foreground
  #  color is set to light grey and the background color is set to be nothing.
  #  It should be noted that the foreground and background colors are validated
  #  individually.
  # When set to true, if an invalid color is determined, an error message is
  #  printed to the console giving what the wrong input was.
  local debug=false

  # Foreground validation --> Checks if chosen color is valid
  # If an invalid choice is given, an error is printed to the shell
  if [[ $2 == "black" ]]; then
    local foreground="0;30"
  elif [[ $2 == "darkGrey" ]]; then
    local foreground="1;30"
  elif [[ $2 == "red" ]]; then
    local foreground="0;31"
  elif [[ $2 == "lightRed" ]]; then
    local foreground="1;31"
  elif [[ $2 == "green" ]]; then
    local foreground="0;32"
  elif [[ "$2" == "lightGreen" ]]; then
    local foreground="1;32"
  elif [[ $2 == "brown" ]]; then
    local foreground="0;33"
  elif [[ $2 == "yellow" ]]; then
    local foreground="1;33"
  elif [[ $2 == "blue" ]]; then
    local foreground="0;34"
  elif [[ $2 == "lightBlue" ]]; then
    local foreground="1;34"
  elif [[ $2 == "magenta" ]]; then
    local foreground="0;35"
  elif [[ $2 == "lightMagenta" ]]; then
    local foreground="1;35"
  elif [[ $2 == "cyan" ]]; then
    local foreground="0;36"
  elif [[ $2 == "lightCyan" ]]; then
    local foreground="1;36"
  elif [[ $2 == "lightGrey" ]]; then
    local foreground="0;37"
  elif [[ $2 == "white" ]]; then
    local foreground="1;37"
  elif [[ $debug = true ]]; then
    local error=$(colorText "[Error]" "lightRed")
    printf "$error Invalid foreground color selected ["
    printf "$(colorText "$2" "red")]"
  else
    local foreground="0;37"
  fi
  # Background color validation --> Checks if chosen color is valid
  # If an invalid choice is given, an error is printed to the shell
  if [[ $3 == "black" ]]; then
    local background=";40"
  elif [[ $3 == "red" ]]; then
    local background=";41"
  elif [[ $3 == "green" ]]; then
    local background=";42"
  elif [[ $3 == "yellow" ]]; then
    local background=";43"
  elif [[ $3 == "blue" ]]; then
    local background=";44"
  elif [[ $3 == "magenta" ]]; then
    local background=";45"
  elif [[ $3 == "cyan" ]]; then
    local background=";46"
  elif [[ $3 == "lightGrey" ]]; then
    local background=";47"
  elif [[ $3 == "" ]]; then
    local background=""
  elif [[ $debug = true ]]; then
    local error=$(colorText "[ERROR]" "lightRed")
    printf "$error Invalid background color selected ["
    printf "$(colorText "$3" "red")]\n"
  else
    local background=""
  fi

  local killColors="\033[0m"

  local text="\033[${foreground}${background}m${1}${killColors}"
  echo -en $text
}

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
    printf "$(colorText "[WARNING]" "yellow") Parameter "
    printf "$(colorText "\$1" "red") of function "
    printf "$(colorText "bar" "cyan")() can only be 1 character long\n"
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
