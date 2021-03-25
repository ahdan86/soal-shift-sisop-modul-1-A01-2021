#!/bin/bash

# no 1.a
grep -oP "(INFO.*)|(ERROR.*)" syslog.log;
printf "\n";

# no 1.b
grep -oP "ERROR\s([A-Z])([a-z]+)(\s[a-zA-Z']+){1,6}" syslog.log;
printf "AMOUNT OF ERROR: ";
grep -c "ERROR" syslog.log;
printf "\n";

# no 1.c
name=$(grep -rohP "(\([a-zA-Z.]+\))" syslog.log | sort | uniq | grep -oP "(?<=\().*(?=\))")
printf "List of users :\n"
echo $name;
# printf "\n";

for i in $name
do
    printf "Name of the user : %s\n" $i;
    printf "Amount of error : ";
    grep -cP "ERROR.*($i)" syslog.log;
    printf "Amount of info : ";
    grep -cP "INFO.*($i)" syslog.log;
    printf "%s,%d,%d\n" $i $(grep -cP "INFO.*($i)" syslog.log) $(grep -cP "ERROR.*($i)" syslog.log);
done

# no 1.d
error_sen=$(grep -oP "ERROR.*" syslog.log);
printf "Error, Count\n" > error_message.csv;
echo "$error_sen" | grep -oP "([A-Z])([a-z]+)(\s[a-zA-Z']+){1,6}" | sort | uniq | 
        while read -r line 
        do
            number=$(grep -c "$line" syslog.log);
            line+=",";
            line+="$number";
            printf "$line\n";
        done | sort -rt',' -nk2 >> error_message.csv;

# no 1.e
name=$(grep -rohP "(\([a-zA-Z.]+\))" syslog.log | sort | uniq | grep -oP "(?<=\().*(?=\))");
printf "Username,INFO,ERROR\n" > user_statistic.csv;

for i in $name
do
    # printf "Name of the user : %s\n" $i;
    # printf "Amount of error : ";
    # grep -cP "ERROR.*($i)" syslog.log;
    # printf "Amount of info : ";
    # grep -cP "INFO.*($i)" syslog.log;
    printf "%s,%d,%d\n" $i $(grep -cP "INFO.*($i)" syslog.log) $(grep -cP "ERROR.*($i)" syslog.log);
done |sort >> user_statistic.csv;