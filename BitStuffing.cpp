#include<iostream>
using namespace std;

int main()
{
    string s = "01111110";
    string originalMessage;
    int count = 0;

    cout<<"Enter the data bit stream"<<endl;
    getline(cin, originalMessage);
    int size = originalMessage.length(); 
    string temp;

    for(int i=0; i<size; i++){
        if(originalMessage[i] == '1'){
            count++;
        }
        else{
            count = 0;
        }
        temp += originalMessage[i];
        if(count == 5){
            temp += '0';
            count = 0;
        }
    }

    string encryptedData = s + temp + s;
    cout<<"Encrypted data is : "<<encryptedData<<endl;

    string decryption;
    int encryptSize = encryptedData.length()-8;
    count = 0;

    for(int i=8; i<encryptSize; i++){
        if(encryptedData[i] == '1'){
            count++;
        }
        else{
            count = 0;
        }
        decryption += encryptedData[i];
        if(count == 5 && encryptedData[i+1] == '0'){
            i++;
            count = 0;
        }
    }
    
    cout<<"Decrypted data is : "<<decryption<<endl;

    return 0;
}