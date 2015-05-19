#!/usr/bin/gawk -f

function makemask(lbase,lstart,lstop) {
#force convert to number from string
    lbase=lbase+0;
    lstart=lstart+0;
    lstop=lstop+0;
#range
    if (lstart<lstop) {
        printf (base"[");
        printf lstart"-"lstop;
        print "]";
    }
#single number
    else if (lstart==lstop) {
        printf (base"[");
        printf lstop;
        print "]";
    }
}


BEGIN {
    FS=",";
}

{

    startstr=$1;
    stopstr=$2;
    j=0;
#get lehgth of strings (expecting length($1)==length($2))
    lrange=length(startstr);

#searching for difference
    for (i=0;i<=lrange;i++) {
        last1=substr(startstr,length(startstr)-i,1);
        last2=substr(stopstr,length(stopstr)-i,1);
        if (last1!=last2) {
            j=i+1;
        }
    }

#j contains number of differences
    print "******************************";
    print startstr,stopstr"\n";

#no differences
    if (startstr==stopstr) {
        print startstr;
    }
#work only with normal range
    else if (startstr<stopstr) {
#get all differences to arrays (0 element is from the right)
        for (i=0;i<j;i++) {
            start[i]=substr(startstr,length(startstr)-i,1);
            stop[i]=substr(stopstr,length(stopstr)-i,1);
        }
#print from start
        for (i=1;i<=j;i++) {

            base=substr(startstr,1,length(startstr)-i);
#not last
            if (i!=j) {
                gstop=9;
#first from the right and j!=1
                if (i==1) {
                    gstart=start[i-1];
                }
#not first
                else {
                    gstart=start[i-1]+1;
                }
            }
#if only j==1
            else if (j==1) {
                gstop=stop[i-1];
                gstart=start[i-1];
            }
#if last diff
            else if (i==j) {
                gstart=start[i-1]+1;
                gstop=stop[i-1]-1;
            }

            makemask(base,gstart,gstop);
        }
#print from stop
        for (i=1;i<=j;i++) {
            base=substr(stopstr,1,length(stopstr)-i);
#not last
            if (i!=j) {
                gstart=0;
#first from the right and j!=1
                if (i==1) {
                    gstop=stop[i-1];
                }
#not first
                else {
                    gstop=stop[i-1]-1;
                }
            }
#if last diff
            else if (i==j) {
                gstart=stop[i-1]+1;
                gstop=stop[i-1]-1;
            }
            makemask(base,gstart,gstop);
        }


    }

    print "\n******************************";

}

