#!/bin/sh

tar -xvf fluent-test-benchmark.tar.gz
cd fluent-test-benchmark
chmod +x fluent-test-benchmark.sh

echo $? > ~/install-exit-status


cat > fluent-test-benchmark <<EOT
#!/bin/sh

helpFunction()
{
   echo ""
   echo "Usage: $0 -m mesh_version"
   echo -e "\t-m Please choose from - 3d_0.0100.msh or 3d_0.0200.msh "
   echo -e "\t Env var: FLUENT_OPT_ARGS - Please add any extra Fluent options here - these are added after the core request parameter."
   exit 1 # Exit script after printing help.
}

while getopts "m:" opt
do
   case "$opt" in
      m ) mesh_version="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent.
   esac
done

# Print helpFunction in case parameters are empty.
if [ -z "$mesh_version" ]
then
   echo "Choosing a mesh is required.";
   helpFunction
fi

cd fluent-test-benchmark

./fluent-test-benchmark.sh -m $mesh_version


EOT

