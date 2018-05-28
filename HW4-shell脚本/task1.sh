#!/bin/bash
# 对jpeg格式图片进行图片质量压缩
reduce_quality()
{
	# $1 is number $2 is directory
	echo $1
	echo $2
	imgs=($(find "$2" -regex '.*\.jpeg'))
	for arg in "${imgs[@]}";
	do
		echo $arg
		echo $2
		x=$arg
		file_name=${x%%.*}
		x=$arg
		file_tail=${x#*.}
		#echo $file_name
		convert $arg -quality $a $file_name'_compression''.'$file_tail
		echo $file_name'_compression''.'$file_tail
	done
}
# 对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
compress_px()
{
	# $1 is percentage $2 is directory
	echo "compressing..."
	imgs=($(find "$2" -regex '.*\.jpg\|.*\.svg\|.*\.png'))
	echo $1
	echo $2
	for arg in "${imgs[@]}";
	do
		#echo $arg
		x=$arg
                file_name=${x%%.*}
                x=$arg
                file_tail=${x#*.}
		convert $arg -resize $1 $file_name'_distortion.'$file_tail
	done
}
# 对图片批量添加自定义文本水印
watermark()
{
	# -w text directory
	images=($(find "$2" -regex  '.*\.jpg\|.*\.svg\|.*\.png\|.*\.jpeg'))
	#imgs=($(find "$2" -regex '.*\.jpg\|.*\.svg\|.*\.png'))
	for arg in "${images[@]}";
	do
		echo $arg
                x=$arg
                file_name=${x%%.*}
                x=$arg
                file_tail=${x#*.}
		echo $file_name
		echo $file_tail
		convert $arg -gravity southeast -fill black -pointsize 16 -draw "text 5,5 '$1'" $file_name'_watermark.'$file_tail 
	done
}
#批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
rename()
{
	echo "renaming..."
	# $1 is pre or tail;$2 is text;$3 directory
	images=($(find "$3" -regex  '.*\.jpg\|.*\.svg\|.*\.png\|.*\.jpeg'))
	if [ "$1" == "pre" ];
	then 
	for arg in "${images[@]}";
	do
		x=$arg
                direc=${x%/*}
		echo $direc
		file_name=${x%%.*}
                x=$arg
                file_tail=${x#*.}
		echo $file_name
		x=$file_name
		single_name=${x##*/}
		echo $single_name
		mv $arg $direc'/'$2$single_name'.'$file_tail
	done
	fi
	if [ "$1" == "tail" ];
        then
        for arg in "${images[@]}";
        do
                x=$arg
                file_name=${x%%.*}
                x=$arg
                file_tail=${x#*.}
                mv $arg $file_name$2'.'$file_tail
        done
        fi

}
# 将png/svg图片统一转换为jpg格式图片
convert()
{
	images=($(find "$1" -regex  '.*\.png\|.*svg'))
	for arg in "${images[@]}";
        do
		#echo $arg
		x=$arg
                file_name=${x%%.*}
                x=$arg
                file_tail=${x#*.}
		#echo $file_name
		#echo $file_tail
		convert $arg $file_name'_format.'$file_tail
	done

}
help()
{
  echo "usage:[-i][-q|-c|-w|-n|-r]"
  echo "-q [quality_number][directory]  对jpeg格式图片进行图片质量压缩"
  echo "-c [percent][directory]         对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率"
  echo "-w [watermark_text][directory]  批量添加自定义文本水印"
  echo "-r [pre|tail] [text][directory] 批量重命名"
  echo "-f [directory]                  将png/svg图片统一转换为jpg格式图片"
  echo "-h                              帮助文档"
}

if [[ "$#" -lt 1 ]]; then
echo "You need to input something"
else 
while [[ "$#" -ne 0 ]]; do
case "$1" in
	"-d" ) dir="$2"
	shift 2
	;;
	"-p")
	if [[ "$2" != '' ]]; then 
	reduce_quality "$2" "$dir"
	shift 2
	else 
	echo "You need to put in a quality parameter"
	fi
	;;
	"-c")
	if [[ "$2" != '' ]]; then 
	compress_px "$2" "$dir"
	shift 2
	else 
	echo "You need to put in a resize rate"
	fi
	;;
	"-w")
	if [[ "$2" != '' ]]; then 
	watermark "$2" "$dir"
	shift 2
	else 
	echo "You need to input a string to be embeded into pictures"
	fi
	;;

	"-r")
	if [[ "$2" != '' ]]; then 
	addPrefix "$2" "$3" "$dir"
	shift 2
	else 
	echo "You need to input a prefix"
	fi
	;;
	"-f") convert "$dir"
	shift
	;;
	"-h" ) help
	shift
	;;
	esac
done
 fi