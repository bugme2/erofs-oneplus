function mksuper(){
Imgdir=$1
outputimg=$2
supersize=16940199936
groupsize=16936005632
super_group=qti_dynamic_partitions
superpa="--metadata-size 65536 --super-name super --virtual-ab -block-size=4096 "
for imag in $(ls $Imgdir/*.img);do
image=$(echo "$imag" | rev | cut -d"/" -f1 | rev  | sed 's/_a.img//g' | sed 's/_b.img//g'| sed 's/.img//g')
img_size=$(wc -c <$Imgdir/$image.img)
superpa+="--partition "$image"_a:readonly:$img_size:${super_group}_a --image "$image"_a=$Imgdir/$image.img "
done

superpa+="--device super:$supersize "
superpa+="--metadata-slots 3 "
superpa+="--group ${super_group}_a:$groupsize "
superpa+="--group cow:0 "
superpa+="-F --output $outputimg"
bin/lpmake $superpa
}

[ ! -d super ] && mkdir super
for img in my_bigball.img my_carrier.img my_company.img my_engineering.img my_heytap.img my_manifest.img my_preload.img my_product.img my_region.img my_stock.img odm.img product.img system.img system_dlkm.img system_ext.img vendor.img vendor_dlkm.img
do
mv -f payload/$img super
done

mksuper super super.img
bin/zstd --rm super.img -o out/super.zst
