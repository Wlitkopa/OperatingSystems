# include <stdio.h>
# include <stdlib.h>
# include <unistd.h>
# include <fcntl.h>
# include <time.h>
# include <string.h>



int main(int argc, char *argv[]){

    char *hash = "e00cf25ad42683b3df678c61f42c6bda";
    setenv("hash", hash, 1) ;

    int num = 5;
    char alphnr[62] = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
                   'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
                   '0','1','2','3','4','5','6','7','8','9'};

    printf("hash: %s\n", hash);



    int ret = system("h=$(echo -n dog | md5sum | awk '{print($1)}'); echo Hash psa: $h == $hash; if [ \"$h\" = \"$hash\" ]; then  echo 'Same'; exit 0; else echo 'Not the same'; exit 1; fi");


//                            int ret = system("exit -1");
    printf("Giga retur: %d\n", ret);
    char temp[7];



    for (int i = 0; i < 62; i++) {
//        printf("hash: %c\n", alphnr[i]);
        for (int j = 0; j < 62; j++) {
            for (int k = 0; k < 62; k++) {
                for (int l = 0; l < 62; l++) {
                    for (int m = 0; m < 62; m++) {
                        for (int n = 0; n < 62; n++) {
                            temp[0] = alphnr[i];
                            temp[1] = alphnr[j];
                            temp[2] = alphnr[k];
                            temp[3] = alphnr[l];
                            temp[4] = alphnr[m];
                            temp[5] = alphnr[n];
                            temp[6] = '\0';
//                            printf("temp: %s\n", temp);
                            setenv("ShellVar", temp, 1) ;
                            int retur = system("h=$(echo -n $ShellVar | md5sum | awk '{print($1)}'); if [ \"$h\" = \"$hash\" ]; then  echo \"Takie same: $ShellVar\n\"; exit 0; else exit 1; fi");
//                            int ret = system("exit -1");
//                            printf("Giga retur: %d\n", ret);
                            if (retur == 0) {
                                printf("Working\n");
                                return 0;
                            }

                            if (j == 1) {
                                printf("Still alive");
                            }
                        }
                    }
                }
            }
            printf("Checking: %s\n", temp);
        }
    }


}


