#!/usr/bin/bash
export PATH=bin:${PATH}

for i in $(find tmp -maxdepth 1 -type d ! -name "config" -printf "%f\n" | grep -v '^tmp$')
do    
    echo -e "\n\033[33m生成${i}.img\033[0m"
    mkfs.erofs -zlz4hc --mount-point /${i} --fs-config-file tmp/config/${i}_fs_config --file-contexts tmp/config/${i}_file_contexts out/${i}.img tmp/${i}

    #echo -e "\033[33m 生成${i}.simg \033[0m"
    #img2simg out/${i}.img out/${i}.simg
    #rm -rf out/${i}.img

    #echo -e "\033[33m 生成${i}.new.dat \033[0m"
    #img2sdat.py  out/${i}.simg -o out -v 4 -p ${i}
    #rm out/${i}.simg

    #echo -e "\033[33m 生成${i}.new.dat.br \033[0m"
    #brotli -0 out/${i}.new.dat -o out/${i}.new.dat.br
    #rm -rf out/${i}.new.dat
done
