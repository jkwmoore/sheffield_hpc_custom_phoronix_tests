#!/bin/bash

#Prevent a file reread of the last benchmark.
touch benchmarktimes.txt
rm benchmarktimes.txt

helpFunction()
{
   echo ""
   echo "Usage: $0 -M module_version -m mesh_version"
   echo -e "\t-M Please use a full module name which provides the ANSYS Fluent executable"
   echo -e "\t-m Please choose from - 3d_0.0100.msh or 3d_0.0200.msh "
   echo -e "\t-o Please add any extra Fluent options here - these are added after the core request parameter. "
   exit 1 # Exit script after printing help.
}

while getopts "m:M:o:" opt
do
   case "$opt" in
      M ) module_version="$OPTARG" ;;
      m ) mesh_version="$OPTARG" ;;
      o ) fluent_optional_args="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent.
   esac
done

# Print helpFunction in case parameters are empty.
if [ -z "$module_version" ] || [ -z "$mesh_version" ]
then
   echo "Some or all of the required parameters are empty";
   helpFunction
fi

# Print error in case scheduler core request parameters are empty.
if [ -z "$NSLOTS" ] && [ -z "$SLURM_NTASKS" ]
then
   echo "Both a SLURM or SGE Scheduler core request variable is missing - SLURM_NTASKS and NSLOTS ";
   core_request=$(nproc --all)
fi

# Print error in case both scheduler core request parameters are provided.
if [ -n "$NSLOTS" ] && [ -n "$SLURM_NTASKS" ]
then
   echo "Both a SLURM and SGE Scheduler core request variable is set - SLURM_NTASKS and NSLOTS - congratulations on achieving the impossible. Do not expect your request to necessarily complete successfully. SLURM_NTASKS is set last. ";
fi

if [ -n "$NSLOTS" ]
then
    core_request=$NSLOTS
fi

if [ -n "$SLURM_NTASKS" ]
then
    core_request=$SLURM_NTASKS
fi

# Begin script in case all parameters are correct
echo "Module Version:"
echo "$module_version"
echo "Mesh Version:"
echo "$mesh_version"

#Get the chosen mesh version - needs to correspond with an available mesh
mesh_version+=".jou"		            #This adds the .jou ending to select the correct journal file.

module load $module_version	#Load your chosen module

totaltimestart=$(date -u +"%s")

fluent 3ddp -i $mesh_version -g -t$core_request $fluent_optional_args &>/dev/null

totaltimeend=$(date -u +"%s")

#Subtract one from the other to give us the totaltime - a bit nasty in bash.
totaltime=`expr $totaltimeend - $totaltimestart`

echo "Total Time"
echo $totaltime

#Begin processing the benchmarktimes file.

filename='benchmarktimes.txt'
n=1
while read line; do
# reading each line
if [ $n -eq 1 ] #Start time - First Line...
then
    bt_start=$line
fi

if [ $n -eq 2 ] #Finish time - Second line...
then
    bt_end=$line
fi

n=$((n+1))
done < $filename

#Subtract one from the other to give us the Benchmark totaltime - aka the computational time not the load time - a bit nasty in bash.
bt_totaltime=`expr $bt_end - $bt_start`

echo "Benchmark Time"
echo $bt_totaltime

loadtime=`expr $totaltime - $bt_totaltime`
echo "Load time:"
echo $loadtime

