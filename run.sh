#!/bin/bash
home=$(pwd)
experiment_log=./experiment.csv
echo "login,alloc_type,experiment,time" > $experiment_log
for repo in $(cat repos.list)
do
dir=$(basename $repo)
name=$dir
echo $name
echo -e "\tDonwloading..."
svn co $repo
header=$dir/prj.lab/m3i/*.h
cat $header
echo -e "\nPlease, enter alloc_type"
# read
type
type="T*"
echo ""
echo -e "\tCreating CMakeLists.txt"
echo "cmake_minimum_required(VERSION 3.20)" > CMakeLists.txt
echo "project(prj_name)" >> CMakeLists.txt
echo "add_subdirectory($name/)" >> CMakeLists.txt
echo "include_directories($name/prj.lab/)" >> CMakeLists.txt
echo "add_compile_definitions(NAME=\"$name\" TYPE=\"$type\" N=15)" >> CMakeLists.txt
echo "add_compile_options(-O0)" >> CMakeLists.txt
echo "add_executable(time_test test.cpp)" >> CMakeLists.txt
echo "target_link_libraries(time_test m3i)" >> CMakeLists.txt
echo -e "\tRun cmake"
mkdir build
cd build
cmake ..
echo -e "\tRun make"
make
echo -e "\tBack home"
cd $home
echo -e "\tDo experiment"
./build/time_test >> $experiment_log
echo -e "\tClean"
rm -rf build CMakeLists.txt $dir
# exit 123
echo ""
done
