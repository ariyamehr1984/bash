#!/bin/bash
input=$1
regex1="^(\bSun \b|\bMon \b|\bTue \b|\bWed \b|\bThu \b|\bFri \b|\bSat \b)([0-9]{1,2} )(\bJune \b|\bMay \b)([0-9]{4} )([0-9]{2}:[0-9]{2}:[0-9]{2} )(\bAM \b|\bPM \b)"
regex2="^(\bPING \b)([0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3})"
regex3="^([0-9]{1,3})( \bpackets transmitted\b)(\b,.\b)([0-9]{1,3})( \breceived\b)(, |, .*errors, )([0-9]{1,3}.*%)( \bpacket loss\b)"
regex4="^(\brtt min\/avg\/max\/mdev = \b)([0-9]{1,4}.[0-9]{1,3})(\/)([0-9]{1,4}.[0-9]{1,3})(\/)([0-9]{1,4}.[0-9]{1,3})"
echo -n "#,DayOfWeek,D,M,Y,Time AM/PM,IP,Trasnsmited,Received,Loss,rttmin,rttavg,rttmax"> $input.csv
i=1
while read line; do
if [[ $line =~ $regex1 ]]; then
	echo >> $input.csv
	M1Grp1=",${BASH_REMATCH[1]}"
	M1Grp2=",${BASH_REMATCH[2]}"
	M1Grp3=",${BASH_REMATCH[3]}"
	M1Grp4=",${BASH_REMATCH[4]}"
	M1Grp5=",${BASH_REMATCH[5]}"
	M1Grp6="${BASH_REMATCH[6]}"
	out1="${M1Grp1}""${M1Grp2}""${M1Grp3}""${M1Grp4}""${M1Grp5}""${M1Grp6}"
#    echo -n $out1
	echo -n $i$out1 >> $input.csv
  ((i=i+1))
elif [[ $line =~ $regex2 ]]; then
	M2Grp1=",${BASH_REMATCH[1]}"
	M2Grp2=",${BASH_REMATCH[2]}" # IP
	M2Grp3=",${BASH_REMATCH[3]}"
	M2Grp4=",${BASH_REMATCH[4]}"
	M2Grp5=",${BASH_REMATCH[5]}"
	M2Grp6=",${BASH_REMATCH[6]}"
	out2="${M2Grp2}"
#    echo -n $out2
	echo -n $out2 >> $input.csv
elif [[ $line =~ $regex3 ]]; then
	M3Grp1=",${BASH_REMATCH[1]}" # #transmited
	M3Grp2=",${BASH_REMATCH[2]}" # packets transmitted
	M3Grp3=",${BASH_REMATCH[3]}" # ,
	M3Grp4=",${BASH_REMATCH[4]}" # #received
	M3Grp5=",${BASH_REMATCH[5]}" # received
	M3Grp6=",${BASH_REMATCH[6]}" # errors
	M3Grp7=",${BASH_REMATCH[7]}" # percentage of loss
	M3Grp8=",${BASH_REMATCH[8]}" # packet loss
	out3="${M3Grp1}""${M3Grp4}""${M3Grp7}"
#    echo -n $out3
	echo -n $out3 >> $input.csv
elif [[ $line =~ $regex4 ]]; then
	M4Grp1=",${BASH_REMATCH[1]}" #
	M4Grp2=",${BASH_REMATCH[2]}" # rttmin
	M4Grp3=",${BASH_REMATCH[3]}" #
	M4Grp4=",${BASH_REMATCH[4]}" # rttavg
	M4Grp5=",${BASH_REMATCH[5]}" #
	M4Grp6=",${BASH_REMATCH[6]}" # rttmax
	out4="${M4Grp2}""${M4Grp4}""${M4Grp6}"
#    echo -n $out4
	echo -n $out4 >> $input.csv
fi
done < $input
echo >> $input.csv


