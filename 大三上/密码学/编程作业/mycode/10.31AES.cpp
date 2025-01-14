﻿#include <iostream>
#include <string>
#include <sstream>
#include <bitset>
#include <iomanip>
#include <vector>

using namespace std;

// 定义AES-128的常量
const int Nb = 4; // 列数
const int Nk = 4; // 密钥长度，32字节
const int Nr = 10; // 轮数
unsigned int roundKeys[44][4];
// AES S-Box
unsigned char S_Box[16][16] =
{
  // 0     1     2     3     4     5     6     7     8     9     A     B     C     D     E     F  
    0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76,
    0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0, 0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0,
    0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15,
    0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75,
    0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0, 0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84,
    0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF,
    0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8,
    0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5, 0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2,
    0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73,
    0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB,
    0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C, 0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79,
    0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08,
    0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A,
    0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E, 0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E,
    0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF,
    0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16
};

// AES round constants
unsigned int Rcon[10] = 
{
    0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1B, 0x36
};

// SubBytes 
void SubBytes(unsigned int state[Nb][4])
{
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            int temp = state[i][j];
            state[i][j] = S_Box[temp / 16][temp % 16];
        }
    }

    cout << "SubBytes: " << endl;
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            cout << "0x" << setw(2) << setfill('0') << hex << state[i][j] << " ";
        }
        cout << endl;
    }
    cout << endl;

}

// ShiftRows操作
void ShiftRows(unsigned int state[Nb][4])
{
    int temp1 = state[1][0];
    state[1][0] = state[1][1];
    state[1][1] = state[1][2];
    state[1][2] = state[1][3];
    state[1][3] = temp1;

    int temp21 = state[2][0];
    int temp22 = state[2][1];
    state[2][0] = state[2][2];
    state[2][1] = state[2][3];
    state[2][2] = temp21;
    state[2][3] = temp22;

    int temp3 = state[3][3];
    state[3][3] = state[3][2];
    state[3][2] = state[3][1];
    state[3][1] = state[3][0];
    state[3][0] = temp3;

    cout << "ShiftRows: " << endl;
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            cout << "0x" << setw(2) << setfill('0') << hex << state[i][j] << " ";
        }
        cout << endl;
    }
    cout << endl;

}

// 乘法操作，GF(2^8)有限域上的乘法
unsigned int Multiply(unsigned int a, unsigned int b) 
{
    unsigned int thr = b & 0x08;  //b&1000
    unsigned int sec = b & 0x04;  //b&0100
    unsigned int fir = b & 0x02;  //b&0010
    unsigned int firstMod = b % 2;    //b&0001
    unsigned int result = 0;
    unsigned int mul_poly = 0x11b; //x^8+x^4+x^3+x+1

    if (thr)
    {
        unsigned int temp = a;
        for (int i = 1; i <= 3; ++i)
        {
            temp = temp << 1;    //总共移3位
            if (temp >= 256)
            {
                temp = temp ^ mul_poly;  
            }
        }
        temp = temp % 256;
        result = result ^ temp;
    }
    if (sec)
    {
        unsigned int temp = a;
        for (int i = 1; i <= 2; ++i)
        {
            temp = temp << 1;     //总共移2位
            if (temp >= 256)
            {
                temp = temp ^ mul_poly;
            }
        }
        temp = temp % 256;
        result = result ^ temp;
    }
    if (fir)
    {
        unsigned int temp = a;
        temp = temp << 1;         //总共移1位
        if (temp >= 256)
        {
            temp = temp ^ mul_poly;
        }
        temp = temp % 256;
        result = result ^ temp;
    }
    if (firstMod)
    {
        result = result ^ a;          //不用移位
    }
    return result;
}
/*
unsigned int Multiply(unsigned int x, unsigned int y)
{
    unsigned int ans = (x << 1) % 256;

    // 如果第七位是1
    if (x & 0x80)
    {
        ans ^= 0x1b;
    }

    if (y > 2)
    {
        ans ^= x;
    }
    return ans;
}*/

//MixColumns操作
void MixColumns(unsigned int state[Nb][4])
{
    for (int i = 0; i < Nb; i++) 
    {
        unsigned int u0 = state[0][i];
        unsigned int u1 = state[1][i];
        unsigned int u2 = state[2][i];
        unsigned int u3 = state[3][i];

        state[0][i] = Multiply(u0, 0x02) ^ Multiply(u1, 0x03) ^ u2 ^ u3;
        state[1][i] = u0 ^ Multiply(u1, 0x02) ^ Multiply(u2, 0x03) ^ u3;
        state[2][i] = u0 ^ u1 ^ Multiply(u2, 0x02) ^ Multiply(u3, 0x03);
        state[3][i] = Multiply(u0, 0x03) ^ u1 ^ u2 ^ Multiply(u3, 0x02);
    }

    cout << "MixColumns: " << endl;
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            cout << "0x" << setw(2) << setfill('0') << hex << state[i][j] << " ";
        }
        cout << endl;
    }
    cout << endl;

}

void RotWord(unsigned int* temp)
{
    unsigned int temp1 = temp[0];
    temp[0] = temp[1];
    temp[1] = temp[2];
    temp[2] = temp[3];
    temp[3] = temp1;
}

void SubWord(unsigned int* temp)
{
    for (int i = 0; i < 4; i++)
    {
        unsigned int temp2 = temp[i];
        temp[i] = S_Box[temp2 / 16][temp2 % 16];
    }
}

// KeyExpansion函数
void KeyExpansion(unsigned int* key , unsigned int roundKeys[44][4])
{
    for (int i = 0; i < 4; i++)
    {
        roundKeys[i][0] = key[4 * i];
        roundKeys[i][1] = key[4 * i + 1];
        roundKeys[i][2] = key[4 * i + 2];
        roundKeys[i][3] = key[4 * i + 3];
    }

    for (int i = 0; i < 4; i++)
    {
        cout << "roundKey[" << i << "]: " << endl;
        for (int j = 0; j < 4; j++)
        {
            cout << "0x" << setw(2) << setfill('0') << hex << roundKeys[i][j] << " ";
        }
        cout << endl;
    }
    cout << endl;

    for (int i = 4; i < 44; i++)
    {
        unsigned int temp[4];
        for (int j = 0; j < 4; j++)
        {
            temp[j] = roundKeys[i - 1][j];
        }

        cout << "temp[" << i << "]: " << endl;
        for (int j = 0; j < 4; j++)
        {
            cout << "0x" << setw(2) << setfill('0') << hex << temp[j] << " ";
        }
        cout << endl;

        if (i % 4 == 0)
        {
            RotWord(temp);

            cout << "RotWord: " << endl;
            for (int j = 0; j < 4; j++)
            {
                cout << "0x" << setw(2) << setfill('0') << hex << temp[j] << " ";
            }
            cout << endl;

            SubWord(temp);

            cout << "SubWord: " << endl;
            for (int j = 0; j < 4; j++)
            {
                cout << "0x" << setw(2) << setfill('0') << hex << temp[j] << " ";
            }
            cout << endl;

            temp[0] = temp[0] ^ Rcon[i / 4 - 1];

            cout << "Xor: " << endl;
            for (int j = 0; j < 4; j++)
            {
                cout << "0x" << setw(2) << setfill('0') << hex << temp[j] << " ";
            }
            cout << endl;
            cout << endl;

        }

        //roundKeys[i-4]⊕temp;
        // W[i-4]⊕W[i-1],i%4!=0
        // W[i-4]⊕SubWord(RotWord(W[i-1]))⊕Rcon[(n/4)-1],i%4!=0

        for (int k = 0; k < 4; k++)
        {
            roundKeys[i][k] = roundKeys[i - 4][k] ^ temp[k];//
        }

        cout << "roundKey[" << i << "]: " << endl;
        for (int j = 0; j < 4; j++)
        {
            cout << "0x" << setw(2) << setfill('0') << hex << roundKeys[i][j] << " ";
        }
        cout << endl;

    }
    
}

// AddRoundKey 
void AddRoundKey(unsigned int state[Nb][4], unsigned int* key)
{
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            state[i][j] = state[i][j] ^ key[4 * j + i];
        }
    }

    cout << "AddRoundKey: " << endl;
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            cout << "0x" << setw(2) << setfill('0') << hex << state[i][j] << " ";
        }
        cout << endl;
    }
    cout << endl;

}

// AES Encryption for one block
void AESEncrypt(unsigned int state[Nb][4],unsigned int *key)
{
    KeyExpansion(key, roundKeys);

    unsigned int temp[16];
    for (int i = 0; i < 16; i++)
    {
        temp[i] = roundKeys[i / 4][i % 4];
    }
    AddRoundKey(state, temp);

    for (int round = 1; round <= Nr; round++)
    {
        cout << "Round= " << round << endl;
        for (int i = 0; i < 16; i++)
        {
            temp[i] = roundKeys[i / 4][i % 4];
        }

        SubBytes(state);
        ShiftRows(state);
        if (round != 10)
        {
            MixColumns(state);
        }

        int k = 0;
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                temp[k] = roundKeys[4 * round + i][j];
                k++;
            }
        }

        cout << "RoundKey: " << endl;
        for (int j = 0; j < 16; j++)
        {
            cout << "0x" << setw(2) << setfill('0') << hex << temp[j] << " ";
        }
        cout << endl;
        cout << endl;

        AddRoundKey(state, temp);
    }

    for (int j = 0; j < 4; j++) 
    {
        for (int i = 0; i < 4; i++) 
        {
            cout << "0x" << setw(2) << setfill('0') << hex << state[i][j] << " ";
        }
    }
    cout << endl;

    stringstream ss;
    ss << uppercase;  // 强制使用大写字母
    for (int j = 0; j < 4; j++)
    {
        for (int i = 0; i < 4; i++)
        {
            ss << setw(2) << setfill('0') << hex << state[i][j];
        }
    }
    string hexString = ss.str();
    cout << hexString << endl;
}

int main() 
{
    // Input key and plaintext as hexadecimal strings
    //string keyString = "0f1571c947d9e8590cb7add6af7f6798";
    //string plaintextString = "0123456789abcdeffedcba9876543210";

    //string keyString = "000102030405060708090a0b0c0d0e0f";
    //string plaintextString = "00112233445566778899aabbccddeeff";

    string keyString = "3ceb2284943341f99379c94bca67b558";
    string plaintextString = "a615d865aa1248fb9451cacf51e599e4";

    //string keyString;
    //string plaintextString;

    //cin >> keyString;
    //cin >> plaintextString;

    // Convert hexadecimal strings to byte arrays
    unsigned int key[16];
    unsigned int plaintext[4][4];

    //plaintextString->plaintext[4][4]
    int num1 = 0;
    for (int i = 0; i < plaintextString.length(); i += 2) 
    {      
        string hexByte = plaintextString.substr(i, 2);
        unsigned int decimalValue = stoul(hexByte, nullptr, 16);
        //cout << "0x" << setw(2) << setfill('0') << hex << decimalValue << ", ";
        plaintext[num1 % 4][num1 / 4] = decimalValue;
        num1++;
    }

    int num2 = 0;
    //keyString->key[16];
    for (int i = 0; i < keyString.length(); i += 2)
    {
        string hexByte = keyString.substr(i, 2);
        unsigned int decimalValue = stoul(hexByte, nullptr, 16);
        //cout << "0x" << setw(2) << setfill('0') << hex << decimalValue << ", ";
        key[num2] = decimalValue;
        num2++;
    }


    cout << "Initial plaintext: " << endl;
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++) 
        {
            cout << "0x" << setw(2) << setfill('0') << hex << plaintext[i][j] << " ";
            //cout << setw(2) << setfill('0') << plaintext[i][j] << " ";
        }
        cout << endl;
    }
    cout << endl;

    cout << "Initial key: " << endl;
    for (int i = 0; i < 16; i++)
    {     
        cout << "0x" << setw(2) << setfill('0') << hex << key[i] << " ";
    }
    cout << endl;
    cout << endl;

    // Perform AES encryption
    AESEncrypt(plaintext,key);
   // cout << "0x" << hex << setw(2) << setfill('0') << Multiply(0x0A, 0x05);

    return 0;
}
