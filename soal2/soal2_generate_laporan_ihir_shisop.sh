#!/bin/bash
awk -F "\t" 'BEGIN {max=0} 
{
    cost = ($21/($18 - $21)*100);
    if(cost >= max){max = cost;ROWID = $1;ORDID=$2}
}
END {
    print "Transaksi terakhir dengan profit percentage terbesar yaitu",ORDID,"dengan persentase",max,"%\n"
}' Laporan-TokoShiSop.tsv > hasil.txt

awk -F "\t" 'BEGIN {
    print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:"
    } 
$3 ~ /[0-9][0-9]-[0-9][0-9]-17/ {
    if($10 == "Albuquerque")
    a[$7]++
}
END { 
    for (b in a) 
    { 
        print b
    }
}' Laporan-TokoShiSop.tsv >> hasil.txt

awk -F "\t" '{
    if(NR!=1)a[$8]++
    }
END {
    min = a["Consumer"];
    tag = "Customer"
    for(b in a)
        if(a[b] < min) {
            min = a[b];
            tag = b;
        }
    print "\nTipe segmen customer yang penjualannya paling sedikit adalah",tag,"dengan",min,"transaksi.\n"
}' Laporan-TokoShiSop.tsv >> hasil.txt

awk -F "\t" '{
    if(NR!=1)a[$13]+=$21
    }
END {
    min = a["South"];
    tag = "South"
    for(b in a)
        if(a[b] < min){
            min = a[b];
            tag = b;
    }
    printf "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %f",tag,min
}' Laporan-TokoShiSop.tsv >> hasil.txt