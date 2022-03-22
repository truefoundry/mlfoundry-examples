#!/bin/bash

examples_folder="sklearn pytorch tensorflow"
requirements_file="examples_requirements.txt"

while getopts "i" arg
do
    case $arg in
        i)
          pip install -r $requirements_file
        ;;
    esac
done

execute_files(){
    for file in `ls $1`
    do
        # if its a ipynb file convert it to py file execute it and then delete it
        if [[ -f "$1/$file" ]]  && [ "${file##*.}" = "ipynb" ]; then
            jupyter nbconvert --to script "$1/$file"
            file="${file%%.*}.py"
            echo "Executing $1/$file:";
            time python "$1/$file"
            rm "$1/$file"
            
        elif [[ -f "$1/$file" ]]  && [ "${file##*.}" = "py" ]; then
            echo "Executing $1/$file:";
            time python "$1/$file"
        fi
    done
}

for folder in $examples_folder
do
    execute_files $folder
done
