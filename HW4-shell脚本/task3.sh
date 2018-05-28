#!/bin/bash
# 统计访问来源主机TOP 100和分别对应出现的总次数
top_host()
{
	awk '{a[$1]+=1;} END {for(i in a){print a[i],i;}}'  ./web_log.tsv | sort -t " " -k 1 -n -r | head -n 100
    	#echo "$tophost"
}
# 统计访问来源主机TOP 100 IP和分别对应出现的总次数
top_ip()
{
	awk -F '\t' '{a[$1]++} END {for(i in a) {print a[i],i}}' ./web_log.tsv | egrep "[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}"| sort -nr -k1 |head -n 100
	#echo $topip
	#awk -F '\t' '{print $2}' ./web_log.tsv| egrep '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}' | sort | uniq -c | sort -nr | head -n 100
    	#echo "$topip"
}
# 统计最频繁被访问的URL TOP 100
top_url()
{
	awk -F '\t' '{a[$5]++} END {for(i in a) {print a[i],i;}}' ./web_log.tsv | sort -nr -k1 |head -n 100
	#echo "$topUrl"
	#topurl=`awk -F '\t' '{
        #    a[$5]+=1;
        #}
        #END {
        #    for(i in a){
        #        b[a[i]]=i;
        #    }
        #    for(i in b){
        #        print i,b[i];
        #    }
        #}'  ./web_log.tsv | sort -nr | head -n 100`
     #echo "$topurl"
}
# 统计不同响应状态码的出现次数和对应百分比
code_status()
{
	sed -e '1d' ./web_log.tsv | awk -F '\t' '{a[$6]++;b++} END {for(i in a) {print i,a[i],a[i]/b*100 "%"}}' | column -t
}
# 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
code_xx()
{
	sed -n '2, $ p' ./web_log.tsv | awk -F '\t' '{if($6~/^4+[0-9]*[0-9]$/) {a[$5]++}} END{for (i in a) {print i,a[i]}}' | sort -nr -k2 | head -n 10

}
# 给定URL输出TOP 100访问来源主机
url()
{
	awk -F '\t' '{if($5=="'$1'") {a[$1]++}} END {for(c in a) {print a[c],c;}}' ./web_log.tsv |sort -nr -k1 |head -n 10
}
help()
{
  echo "usage:[-th][-ti][-tu][-cs][-cx][-u][-h]"
  echo "-th          统计访问来源主机TOP 100和分别对应出现的总次数"
  echo "-ti          统计访问来源主机TOP 100 IP和分别对应出现的总次数"
  echo "-tu          统计最频繁被访问的URL TOP 100"
  echo "-cs          统计不同响应状态码的出现次数和对应百分比"
  echo "-cx          分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数"
  echo "-u [url]     给定URL输出TOP 100访问来源主机"
  echo "-h           查看帮助信息"
}
while [ "$1" != "" ]; do
	case $1 in
		-th ) top_host
		exit
		;;
		-ti ) top_ip
		exit
		;;
		-tu ) top_url
		exit
		;;
		-cs ) code_status
		exit
		;;
		-cx ) code_xx
		exit
		;;
		-u ) url "$2"
		exit
		;;
		-h  ) help
		exit
		;;
		esac
done
#top_host
#top_ip
#top_url
#code_status
#code_xx
#url