#! /bin/bash
##### Tell the OS which program to run the script with, in this case bash (Unix shell)

##### Welcome to bash scripting! bash is the name of the scripting language this script is written in, and is the basic command line language used by the unix terminal.
##### Anything after a '#' is a comment, except for the #! operator which tells the OS which program to run the file with, which is why it had to be the first line.
##### Detailed explanations of the bash code will by prepended by 5 #'s whereas regular code comments explaining the function of the script will only have one #.


# Script to generate/update Flight Vehicle task-breakdown flowcharts from their DOT code.
# Run this script after modifications are made to the DOT code to update the png images.

# Choose the format to generate the graphs in, eg png image, ps (post script), pdf etc
format=png
##### Create the variable 'format'.
##### We can access the value of 'format' by using the '$' operator, ie $format returns png in this case.

# Update PNG images from the DOT code for each flowchart in the current directory
for eachDOTfile in $(ls *.dot); do
	dot ./$eachDOTfile -T$format -o ./${eachDOTfile%%.*}.$format
	echo \"${eachDOTfile%%.*}.$format\" created from \"$eachDOTfile\" 
done

##### ls returns the name of each file in the directory matching the pattern *.dot
##### 	ie anything that ends with .dot such as FV_flow_chassis.dot
##### $(ls *.dot) gets replaced with the evaluation of the expression 'ls *.dot', ie the list of filenames returned by 'ls *.dot'
##### ${eachDOTfile%%.*} gets replaced by the current filename being handled by the for loop with it's extension removed ie FV_flow_chassis
##### and echo simply prints its arguments to the command line that executed this script (after expanding expressions like $eachDOTfile).

##### The basic syntax of a 'for' loop is:
##### for 'loop-variable' in 'string-of-space-seperated-words'; do
##### 	'command-to-execute with these arguments'
##### done

##### The basic syntax for using the dot program is like this: 'dot ./input-filename.dot -Tpng -o ./output-filename.png' where the -T tells dot which format to render and -o tells dot which file to output to.
