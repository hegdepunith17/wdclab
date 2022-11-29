#include<iostream>
#define N (g.length())
using namespace std;

string t, cs, g = "10110";
int c,e,a;

void xoring(){
    for(c=1; c<N; c++){
        cs[c] = (cs[c] == g[c])? '0':'1';
    }
}

void crc(){
    for(e=0; e<N; e++){
        cs += t[e];
    }
    do{
        if(cs[0] == '1'){
            xoring();
        }
        for(c=0; c<N-1; c++){
            cs[c] = cs[c+1];
        }
        cs[c] = t[e++];
    }while(e <= a+N-1);
}

int main()
{
    cout<<"Enter the Polynomial : "<<endl;
    getline(cin, t);
    cout<<"Generating Polynomial is : "<<g<<endl;

    a = t.length();

    for(e=a; e<a+N-1; e++){
        t += '0';
    }

    cout<<"Modified 't' is : "<<t<<endl;
    crc();
    cout<<"CheckSum is : "<<cs<<endl;

    //RX.
    for(e=a; e<=a+N-1; e++){
        t[e] = cs[e-a];
    }
    cout<<"Final CodeWord is : "<<t<<endl;
    int check, gg;

    cout<<"Test Error detection 0(YES) or 1(NO) ?"<<endl;
    cin>>check;

    if(check == 0){
        cout<<"Enter the position you want to insert the error : "<<endl;
        cin>>gg;
        t[gg] = (t[gg] == '1')? '0':'1';
        cout<<"Erroneous data is : "<<t<<endl;
        cout<<"Error detected"<<endl;
    }
    else{
        cout<<"Error detected"<<endl;
    }

    return 0;
}