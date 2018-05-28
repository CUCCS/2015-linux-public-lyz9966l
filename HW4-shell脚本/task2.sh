#!/bin/bash
# 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
age_range()
{
	line_age=$(awk -F "\t" '{ print $6 }' worldcupplayerinfo.tsv)
	count=0
	lower_20=0
	between_20_30=0
	higher_30=0
	for i in $line_age
	do
		# not the first line
  		if [ "$i" != "Age" ];then
     			count=`expr $count + 1`
     			if [ $i -lt 20 ];then
        			lower_20=`expr $lower_20 + 1`
     			elif [ $i -gt 30 ];then
        			higher_30=`expr $higher_30 + 1`
     			elif [ $i -ge 20 ] && [ $i -le 30 ];then
        			between_20_30=`expr $between_20_30 + 1`
     			fi
   		fi
	done
	#between_20_30=`expr $count - $lower_20 - $higher_30`
	percent_20=`awk 'BEGIN{printf "%.3f\n",('${lower_20}'/'$count')*100}'`
	percent_20_30=`awk 'BEGIN{printf "%.3f\n",('${between_20_30}'/'$count')*100}'`
	percent_30=`awk 'BEGIN{printf "%.3f\n",('${higher_30}'/'$count')*100}'`

	echo There are $lower_20 players which are under 20.The percentage is $percent_20'%'.
	echo There are $between_20_30 players age are between 20 and 30.The percentage is $percent_20_30'%'.
	echo There are $higher_30 players age higher than 30.The percentage is $percent_30'%'.
	echo The total number of players is $count.
}
#年龄最大最小的球员
extreme_age()
{
	age=$(awk -F "\t" '{ print $6 }' worldcupplayerinfo.tsv)
	count=0
	young_age=100
	old_age=0

	for i in $age
	do 
		if [ "$i" != "Age" ];then
			count=$[$count+1]
			if [ $i -lt $young_age ];then 
				young_age=$i
			fi
			if [ $i -gt $old_age ];then
				old_age=$i
			fi 
		fi
	done
	young_name=$(awk -F '\t' '{if($6=='$young_age') {print $9}}' worldcupplayerinfo.tsv)	
	for j in $young_name
	do
		echo "One of the youngest player is $j, he's $young_age years old."
	done
	old_name=$(awk -F '\t' '{if($6=='$old_age') {print $9}}' worldcupplayerinfo.tsv)
	for k in $old_name
	do 
		echo "One of the oldest player is $k, he's $old_age years old."
	done

}
# 名字最长最短的球员
length_of_name()
{
	# 取出每一个名字
	name=$(awk -F "\t" '{ print length($9) }' worldcupplayerinfo.tsv)
	longest=0
	shortest=100
	# 循环取出最长名字的长度和最短名字的长度
	for i in $name
	do
		#x=length($i)
		#x=$(echo “$i”|awk '{print length($0)}')
		#x=$(echo "$i" |awk -F "" '{print NF}')
		if [ $longest -lt $i ];then
			longest=$i
			#longest_name=$i
		fi
		if [ $shortest -gt $i ];then
			shortest=$i
			#shortest_name=$i
		fi
	done
	#echo $longest
	longest_name=$(awk -F '\t' '{if (length($9)=='$longest'){print $9}}' worldcupplayerinfo.tsv)
	#for j in $longest_name
	#do
	echo "$longest_name has the longest name and the length is $longest"
	#done
	shortest_name=$(awk -F '\t' '{if (length($9)=='$shortest'){print $9}}' worldcupplayerinfo.tsv)
	#echo $shortest_name
	#echo "$longest_name has the longest name and the length is $longest"
	echo "$shortest_name has the shortest name and the length is $shortest"
}
# 统计场上不同位置的球员数量、百分比
players_position()
{
	position=$(awk -F '\t' '{print $5}' worldcupplayerinfo.tsv)
	Goalie=0
	Defender=0
	Midfielder=0
	Forward=0
	count=0
	for i in $position
	do
		if [ "$i" != "Position" ];then
			count=`expr $count + 1`
			if [ "$i" == "Goalie" ];then
				Goalie=`expr $Goalie + 1`
			fi
			if [ "$i" == "Defender" ];then
				Defender=`expr $Defender + 1`
			fi
			if [ "$i" == "Midfielder" ];then
				Midfielder=`expr $Midfielder + 1`
			fi
			if [ "$i" == "Forward" ];then
				Forward=`expr $Forward + 1`
			fi
		fi
	done
	percent_G=`awk 'BEGIN{printf "%.3f\n",('${Goalie}'/'$count')*100}'`
	percent_D=`awk 'BEGIN{printf "%.3f\n",('${Defender}'/'$count')*100}'`
	percent_M=`awk 'BEGIN{printf "%.3f\n",('${Midfielder}'/'$count')*100}'`
	percent_F=`awk 'BEGIN{printf "%.3f\n",('${Forward}'/'$count')*100}'`
	echo There are $Goalie goalies.The percentage is $percent_G'%'.
	echo There are $Defender defenders.The percentage is $percent_D'%'.
	echo There are $Midfielder midfilders.The percentage is $percent_M'%'.
	echo There are $Forward forwards.The percentage is $percent_F'%'.
}
#age_range
extreme_age
#length_of_name
#players_position