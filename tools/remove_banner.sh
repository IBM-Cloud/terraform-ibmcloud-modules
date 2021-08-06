#!/bin/bash
update_banner () {   
    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            ## Excluding template directory to any kind of banner change
            if [[ $pathname != *base/template ]]; then
                update_banner "$pathname"
            fi
        else
            if grep -q Copyright $pathname; then
                if [[ $pathname == *.sh ]]; then
                    sed -i '2,8d' $pathname
                else
                    sed -i '1,7d' $pathname
                fi
            fi
            printf '%s\n' "$pathname" 
        fi
    done
}


if [ $# -ne 1 ]; then
  echo 'Error! Provide 2 valid arguments'
  echo 'arg1 - Pass an relative path to the base directory of the repo where you need to add copyright banners'
  echo 'eg1 ./update_source_code_copyright_banner.sh test/system/autoscale . This will update only autoscale dir'
  exit 0
fi

###Change below directory path if running from different location. Expecting working_dir should be the root dir
work_dir="$(dirname $(pwd))"
update_banner "$work_dir/$1"


