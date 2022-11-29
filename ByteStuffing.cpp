#include<iostream>
using namespace std;

int main()
{
    string s;
    cout<<"Enter the message : "<<endl;
    getline(cin, s);
    int size = s.length();
    string start = "DLESTX";
    string end = "DLEETX";

    string startTemp;
    string endTemp;

    int i = 0;
    //For checking starting bytes.
    while(i < 3){
        startTemp += s[i];
        endTemp += s[size-4+i];
        i++;
    }
    string encryptionData;
    if(startTemp == "DLE" && endTemp == "DLE"){
        encryptionData = start+startTemp+s+endTemp+end;
    }
    else if(startTemp == "DLE" && endTemp != "DLE"){
        encryptionData = start+startTemp+s+end;
        endTemp = "";
    }
    else if(startTemp != "DLE" && endTemp == "DLE"){
        encryptionData = start+s+endTemp+end;
        startTemp = "";
    }
    else{
        encryptionData = start+s+end;
        startTemp = endTemp = "";
    }

    cout<<"Encryption data is : "<<encryptionData<<endl;

    //Decryption.
    string decryptionData;
    int startRemove = start.length()+startTemp.length();
    int endRemove = end.length()+endTemp.length();
    int encryptionSize = encryptionData.length();

    for(int i=startRemove; i<encryptionSize-endRemove; i++){
        decryptionData += encryptionData[i];
    }

    cout<<"Decrypted data is : "<<decryptionData<<endl;

    return 0;
}