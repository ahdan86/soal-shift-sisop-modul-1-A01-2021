# grep -oP "ERROR\s([A-Z])([a-z]+)(\s[a-zA-Z']+){1,6}" syslog.log;
# printf "\nAMOUNT OF ERROR: ";
# grep -c "ERROR" syslog.log;

error_sen=$(grep -oP "ERROR.*" syslog.log);
echo "$error_sen" | grep -oP "([A-Z])([a-z]+)(\s[a-zA-Z']+){1,6}" | sort | uniq | 
        while read -r line 
        do
            number=$(grep -c "$line" syslog.log);
            line+=",";
            line+="$number";
            printf "$line\n";
        done | sort -rt',' -nk2 ;