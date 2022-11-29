#include<iostream>
using namespace std;

int main()
{
    string plain, cipher;

    cout<<"***Encryption and Decryption using substitution cipher***"<<endl;
    cout<<"Enter the plain text : "<<endl;
    getline(cin, plain);

    int encryptionKey;

    while(true){
        cout<<"Enter Key for Encryption : "<<endl;
        cin>>encryptionKey;
        if((encryptionKey < 1) || (encryptionKey > 25)){
            cout<<"Please enter a vlaid encryptionKey between 1 and 25 : "<<endl;
        }
        else{
            break;
        }
    }

    int size = plain.length();
    //Encryption.
    for(int i=0; i<size; i++){
        if(isalpha(plain[i])){
            cipher += ((toupper(plain[i])-'A')+(encryptionKey%26))%26+'A';
        }
        else{
            if(plain[i] == ' '){
                cipher += plain[i];
            }
        }
    }

    cout<<"Encrypted data is : "<<cipher<<endl;

    //Decryption.
    int decryptionKey;

    while(true){
        cout<<"Enter the key for decryption : "<<endl;
        cin>>decryptionKey;
        if((decryptionKey < 1) || (decryptionKey > 25)){
            cout<<"Please enter a vlaid decryptionKey between 1 and 25 : "<<endl;
        }
        else{
            break;
        }
    }


    string decryptData;
    for(int i=0; i<size; i++){
        if(isalpha(cipher[i])){
            decryptData += ((cipher[i]-'A')+(26-encryptionKey))%26+'A';
        }
        else{
            if(cipher[i] == ' '){
                decryptData += cipher[i];
            }
        }
    }

    cout<<"Decrypted data is : "<<decryptData<<endl;

    return 0;
}