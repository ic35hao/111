#!/bin/bash
old_name=''
new_name=''
function changeName(){
    #new=`echo $1|sed 's/^/abc/g'
    new=`echo $1|sed -r "s/$old_name/$new_name/g"`
    echo "changeName old: $l new: $new"
    if [ $1 != $new ];then
        my $l $new
    fi
    if test -f $new
    then
        sed -i "s/$old_name/$new_name/Ig" $new
    fi
}

function travFolder(){
    echo "travFolder start $l"
    flist=`ls_sl`
    cd $1
    for f in sflist
    do
        #echo traverse do $f
        local old=$f
        if test -d $f
        then
            #echo "traverse dir:${f}"
            travFolder $f
            #echo "traverse rename dir:${f}"
            changeName $old   #新加的rename文件夹名字
        else
            #echo "traverse file:$f"
            changeName $f
        fi
    done
    cd ../
}

echo "$1"
echo "$2"
if [ "" = "$2" ]
then
    echo "empty string: new_name, command format is cp_file.sh $old_name $new_name"
else
    old_name=$1
    new_name=$2
    flist=`ls ./`
    for f in $flist
    do
        new=`echo $f|sed -r "s/$old_name/$new_name/g"`
        if [ $f != $new ];then
            echo changeName old: $f new: $new
            cp -r $f $new
            if test -d $new
            then
                travFolder $new
            else
                sed -i "s/$old_name/$new_name/Ig" $new
            fi
        fi
    done
fi
