#!/usr/bin/bash
export PATH=bin:${PATH}

decompresszip(){
rm -rf out tmp payload
mkdir out tmp
if [ -e *.bin ]; then
payload-dumper-go -o payload payload.bin
else
echo -e "\033[31mpayload.bin不存在！\033[0m"
exit 0
fi
}

decompressimg(){
for i in $(find payload -name *.img)
do
if [ "$(gettype -i ${i})" == erofs ]
then
echo -e "\n\033[33m解压$(basename $i)\033[0m"
extract.erofs -i ${i} -x -o tmp
elif [ "$(gettype -i ${i})" == ext ]
then
echo -e "\n\033[33m解压$(basename $i)\033[0m"
imgextractor.py ${i} tmp/${!}
fi
done
}

decompresszip
decompressimg
