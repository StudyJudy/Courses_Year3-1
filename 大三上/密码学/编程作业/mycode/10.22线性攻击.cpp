#include <iostream>
#include <string>
#include <bitset>
#include <vector>
#include <cmath>
using namespace std;

int s[16] = { 14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7 }; // S��
int p[16] = { 1, 5, 9, 13, 2, 6, 10, 14, 3, 7, 11, 15, 4, 8, 12, 16 }; // P�û�
string K = "00111010100101001101011000111111";
int inverseSBox[16] = { 14, 3, 4, 8, 1, 12, 10, 15, 7, 13, 9, 6, 11, 2, 0, 5 };
int Count[16][16] = { 0 };
int best_count = -1;

//ur-->S_Box-->vr
string S_Box(string u) 
{
    string v;
    for (int i = 0; i < 16; i += 4)
    {
        int index = stoi(u.substr(i, 4), 0, 2);// ��4λ�������Ӵ�ת��Ϊʮ��������
        bitset<4> s_output(s[index]); // ��S�����������ֵת��Ϊ4λ������
        v += s_output.to_string(); // ��S�����׷�ӵ�v��
    }
    return v;
}

//vr-->P_Box-->wr
string P_Box(string v)
{
    string w = "0000000000000000";
    for (int i = 0; i < 16; i++) 
    {
        char m = v[i];// ��ȡP�û�������
        int pos = p[i];// ��ȡP�û������λ��
        w[pos - 1] = m;// ����P�û�
    }
    return w;
}

// ��Կ�����㷨
string Key_Scheduling(string K, int r) 
{
    string k;
    for (int i = 4 * r - 4; i <= 4 * r + 11; i++) 
    {
        k += K[i];// ѡ���ض�λ�õ���Կ����
    }
    return k;
}

// ����Կ���
string Round_Key_Mixing(string w, string k)
{
    string u;
    bitset<16> str1(w);
    bitset<16> str2(k);
    bitset<16> u_bit = str1 ^ str2;// ��w��k��λ���
    u = u_bit.to_string();
    return u;
}

// SPN���ܺ���
string SPN(string plaintext, string K)
{
    int Nr = 4;// SPN������
    string w = plaintext;
    string k;
    string u;
    string v;
    string y;

    for (int r = 1; r <= Nr; r++) 
    {
        k = Key_Scheduling(K, r);
        u = Round_Key_Mixing(w, k);
        v = S_Box(u);
        w = P_Box(v);
    }
    
    k = Key_Scheduling(K, Nr);
    u = Round_Key_Mixing(w, k);
    v = S_Box(u);

    k = Key_Scheduling(K, Nr + 1);
    y = Round_Key_Mixing(v, k);

    return y;//���ܽ��
}

//pai_s��
void calculateInverseSBox()
{
    for (int i = 0; i < 16; i++)
    {
        inverseSBox[s[i]] = i;
    }
}

string S_Box_(string u)
{
    string v;
    int index = stoi(u.substr(0, 4), 0, 2);// ��4λ�������Ӵ�ת��Ϊʮ��������
    bitset<4> s_output(inverseSBox[index]); // ��S�����������ֵת��Ϊ4λ������
    v += s_output.to_string(); // ��S�����׷�ӵ�v��       
    return v;
}

// ������������㷨
pair<int, pair<int, int>> linearCryptanalysis(vector<pair<string, string>> data, int num_candidate_keys)
{
    pair<int, int> best_candidate_keys = make_pair(0, 0);
    for (pair<string, string> sample : data)
    {
        // ����ѵ�����ݼ��е�ÿһ������-����
        string x = sample.first;
        string y = sample.second;

        // ����ÿ�����ܵ�����Կ(L1, L2)
        for (int L1 = 0; L1 < num_candidate_keys; L1++)
        {
            for (int L2 = 0; L2 < num_candidate_keys; L2++)
            {
                // ����u64��u84��u144��u164
                bitset<4> binaryNumber1(L1);//ʮ��������L1תΪ����������
                bitset<4> y2; // ���ڴ洢λ���ϵı���
                for (int i = 0; i <= 3; i++)
                {
                    y2[i] = (y[i + 4] == '1');
                }
                bitset<4> v24_ = binaryNumber1 ^ y2;
                string v24 = v24_.to_string();

                bitset<4> binaryNumber2(L2);//ʮ��������L2תΪ����������
                bitset<4> y4;
                for (int i = 0; i <= 3; i++)
                {
                    y4[i] = (y[i + 12] == '1');
                }
                bitset<4> v44_ = binaryNumber2 ^ y4;
                string v44 = v44_.to_string();

                string u24 = S_Box_(v24);
                string u44 = S_Box_(v44);

                int z = ((x[4] == '1') + (x[6] == '1') + (x[7] == '1') + (u24[1] == '1') + (u24[3] == '1') + (u44[1] == '1') + (u44[3] == '1')) % 2;

                if (z == 0)
                {
                    Count[L1][L2]++;
                }
            }
           
        }
    }
    for (int L1 = 0; L1 < num_candidate_keys; L1++)
    {
        for (int L2 = 0; L2 < num_candidate_keys; L2++)
        {
            Count[L1][L2] = abs(Count[L1][L2] - static_cast<int>(data.size() / 2));
            // ������Ѻ�ѡ����Կ
            if (Count[L1][L2] > best_count)
            {
                best_count = Count[L1][L2];
                best_candidate_keys = make_pair(L1, L2);
            }
        }
    }
    pair<int, pair<int, int>> best_keys = make_pair(best_count, best_candidate_keys);
    return best_keys;
}
    
vector<pair<string, string>> createdata(int num_samples)
{
    vector<pair<string, string>> data; // ����-����ѵ�����ݼ�����Ҫ����ʵ��������
    for (int i = 0; i < num_samples; i++)//����8000������-���Ķ�
    {
        string plaintext = bitset<16>(rand() & 0xFFFF).to_string();// �������16λ����
        string ciphertext = SPN(plaintext, K);// ʹ��SPN���ܺ�����������
        data.push_back(make_pair(plaintext, ciphertext));// �洢���ĺ����Ķ�
    }
    return data;
}

int main()
{
    int num_samples = 8000; // ����ͳ�Ƶ���������
    vector<pair<string, string>> data; // ����-����ѵ�����ݼ�����Ҫ����ʵ��������
    data = createdata(num_samples);
    int num_candidate_keys = 16; 

    pair<int, pair<int, int>> best_keys = linearCryptanalysis(data, num_candidate_keys);
    cout << "Best Candidate Keys: L1 = " << best_keys.second.first << ", L2 = " << best_keys.second.second << " with count " << best_keys.first << endl;

    return 0;
}
