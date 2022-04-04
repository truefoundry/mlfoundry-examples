#!/bin/bash

execute_files(){
    for file in `find . -print `
    do
        # if its a ipynb file convert it to py file execute it and then delete it
        if [[ -f "$file" ]]  && [ "${file##*.}" = "ipynb" ]; then
            jupyter nbconvert --to script "$file"
            file=`echo $file | sed -e 's/ipynb/py/g'`
            echo "Executing $file:";
            time python "$file"
            rm "$file"
            
        elif [[ -f "$file" ]]  && [ "${file##*.}" = "py" ]; then
            echo "Executing $file:";
            time python "$file"
        fi
    done
}

execute_files
