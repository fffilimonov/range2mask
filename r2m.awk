#!/usr/bin/gawk -f

function makemask(lbase,lstart,lstop) {
    lbase=lbase+0;
    lstart=lstart+0;
    lstop=lstop+0;
    if (lstart<lstop) {
        printf (base"[");
        printf lstart"-"lstop;
        print "]";
    }
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
    lrange=length(startstr);

    for (i=0;i<=lrange;i++) {
        last1=substr(startstr,length(startstr)-i,1);
        last2=substr(stopstr,length(stopstr)-i,1);
        if (last1!=last2) {
            j=i+1;
        }
    }

    print "******************************";
    print startstr,stopstr"\n";

    if (startstr==stopstr) {
        print startstr;
    }
    else if (startstr<stopstr) {

        for (i=0;i<j;i++) {
            start[i]=substr(startstr,length(startstr)-i,1);
            stop[i]=substr(stopstr,length(stopstr)-i,1);
        }

        for (i=1;i<=j;i++) {

            base=substr(startstr,1,length(startstr)-i);

            if (i!=j) {
                gstop=9;
                if (i==1) {
                    gstart=start[i-1];
                }
                else {
                    gstart=start[i-1]+1;
                }
            }

            else if (j==1) {
                gstop=stop[i-1];
                gstart=start[i-1];
            }

            else if (i==j) {
                gstart=start[i-1]+1;
                gstop=stop[i-1]-1;
            }

            makemask(base,gstart,gstop);
        }

        for (i=1;i<=j;i++) {
            base=substr(stopstr,1,length(stopstr)-i);
            if (i!=j) {
                gstart=0;
                if (i==1) {
                    gstop=stop[i-1];
                }
                else {
                    gstop=stop[i-1]-1;
                }
            }
            else if (i==j) {
                gstart=stop[i-1]+1;
                gstop=stop[i-1]-1;
            }
            makemask(base,gstart,gstop);
        }


    }

    print "\n******************************";

}

