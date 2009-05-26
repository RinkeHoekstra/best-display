BEGIN{ FS=";";
       nofil="y";
     }

NF==0 {nofil="y";
       next;
      }

nofil=="n" { for(i=1;i<=NF;i++){
               gsub(/^ +/,"", $i);
               print $i >> outfil;
             };
           }


nofil=="y" {title=$0;
            gsub(/\(.*\)/, "");
            gsub(/ +$/, "");
            gsub(/ /, "_");
            gsub(/:/, "\\:");
            outfil=$0;
            print title > outfil;
            nofil="n";
           }

