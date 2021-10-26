#!/bin/bash

#catalogs
DIR_in_PIN="/home/appadmin/1/"
DIR_in_ASK="/home/appadmin/2/"
DIR_out="/home/appadmin/3/"

DIR_inDir_out="/home/appadmin/a/"
DIR_inDir_out_arch="/home/appadmin/b/`date+%d-%m-%Y`/"
DIR_inDir_in="/home/appadmin/c/"
DIR_inDir_in_arch="/home/appadmin/d/`date+%d-%m-%Y`/"
#file extension
txt="*.txt"
zip="*.zip"
rar="*.rar"
#logs
DIR_log_today_out="/home/appadmin/log1/`date+%d-%m-%Y`/log_out.log"
DIR_log_today_in="/home/appadmin/log2/`date+%d-%m-%Y`/log_in.log"
DIR_logs_all="./logs_all_`date+%d-%m-%Y`.log"

#check .txt, .zip, .rar - create dir&logs
if [ ! -z "$(ls -A $DIR_in_PIN$txt)" ]; then
    mkdir -p /home/appadmin/finline/inDir_out.arch/$(date +%d-%m-%Y)/
    touch /home/appadmin/finline/inDir_out.arch/$(date +%d-%m-%Y)/log_out.log
    touch ./logs_all_$(date +%d-%m-%Y).log
elif [ ! -z "$(ls -A $DIR_in_ASK$zip)" ]; then
    mkdir -p /home/appadmin/finline/inDir_out.arch/$(date +%d-%m-%Y)/
    touch /home/appadmin/finline/inDir_out.arch/$(date +%d-%m-%Y)/log_out.log
    touch ./logs_all_$(date +%d-%m-%Y).log
elif [ ! -z "$(ls -A $DIR_in_ASK$rar)" ]; then
    mkdir -p /home/appadmin/finline/inDir_out.arch/$(date +%d-%m-%Y)/
    touch /home/appadmin/finline/inDir_out.arch/$(date +%d-%m-%Y)/log_out.log
    touch ./logs_all_$(date +%d-%m-%Y).log
fi
#
if [ ! -z "$(ls -A $DIR_inDir_in$txt)" ]; then
    mkdir -p /home/appadmin/finline/inDir_in.arch/$(date +%d-%m-%Y)/
    touch /home/appadmin/finline/inDir_in.arch/$(date +%d-%m-%Y)/log_in.log
    touch ./logs_all_$(date +%d-%m-%Y).log
fi

#logs
exec 1>> ./logs_all_$(date +%d-%m-%Y).log

#Body
#
for file in $DIR_in_PIN$txt
do
if [ -d "$DIR_in_PIN" ]; then
    echo "Обнаружена директория среди файлов!"
elif [ -f "$file" ]; then
    echo "Начато копирование $file от $(date +%d-%m-%Y)"
    cp $file $DIR_inDir_out_arch 2>>$DIR_logs_all
        if [ $? -eq 0 ]; then
        echo "Сообщение $file скопировано в архивную папку от $(date +%d-%m-%Y)"
        echo "Сообщение $file скопировано в архивную папку от $(date +%d-%m-%Y)" >>$DIR_log_today_out   
        else
        echo "Сообщение $file от $(date +%d-%m-%Y) не удалось скопировать в архивную папку!"
        fi
    echo "Начато перемещение $file от $(date +%d-%m-%Y)"
    mv $file $DIR_inDir_out 2>>$DIR_logs_all
        if [ $? -eq 0 ]; then
        echo "Сообщение $file перемещено в inDir_out"
        else
        echo "Сообщение $file не удалось переместить в inDir_out!"
        fi    
fi
done

# in zip/rar
for file in $DIR_in_ASK$zip $DIR_in_ASK$rar
do
if [ -d "$DIR_in_ASK" ]; then
    echo "Обнаружена директория среди файлов zip!"
elif [ -f "$file" ]; then
    echo "Начато копирование $file от $(date +%d-%m-%Y)"
    cp $file $DIR_inDir_out_arch 2>>$DIR_logs_all
        if [ $? -eq 0 ]; then
        echo "Сообщение $file скопировано в архивную папку от $(date +%d-%m-%Y)"
        echo "Сообщение $file скопировано в архивную папку от $(date +%d-%m-%Y)" >>$DIR_log_today_out   
        else
        echo "Сообщение $file от $(date +%d-%m-%Y) не удалось скопировать в архивную папку!"
        fi
    echo "Начато перемещение $file от $(date +%d-%m-%Y)"
    mv $file $DIR_inDir_out 2>>$DIR_logs_all
        if [ $? -eq 0 ]; then
        echo "Сообщение $file перемещено в inDir_out"
        else
        echo "Сообщение $file не удалось переместить в inDir_out!"
        fi
fi
done


for file in $DIR_inDir_in$txt
do
if [ -d "$DIR_inDir_in" ]; then
    echo "Обнаружена директория среди файлов!"
elif [ -f "$file" ]; then
    echo "Начато копирование $file от $(date +%d-%m-%Y)"
    cp $file $DIR_inDir_in_arch 2>>$DIR_logs_all
        if [ $? -eq 0 ]; then
        echo "Сообщение $file скопировано в архивную папку от $(date +%d-%m-%Y)"
        echo "Сообщение $file скопировано в архивную папку от $(date +%d-%m-%Y)" >>$DIR_log_today_in
        else
        echo "Сообщение $file от $(date +%d-%m-%Y) не удалось скопировать в архивную папку!"
        fi
    echo "Начато перемещение $file от $(date +%d-%m-%Y)"
    mv $file $DIR_out 2>>$DIR_logs_all
        if [ $? -eq 0 ]; then
        echo "Сообщение $file перемещено в ABS.inDir.CM.SWIFT.F"
        else
        echo "Сообщение $file не удалось переместить в ABS.inDir.CM.SWIFT.F!"
        fi
fi
done
exit 0