#include <iostream>
#include <string>
#include <bitset>
#include <vector>
#include <cmath>
using namespace std;

int s[16] = { 14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7 }; // S盒
int p[16] = { 1, 5, 9, 13, 2, 6, 10, 14, 3, 7, 11, 15, 4, 8, 12, 16 }; // P置换
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
        int index = stoi(u.substr(i, 4), 0, 2);// 将4位二进制子串转换为十进制整数
        bitset<4> s_output(s[index]); // 将S盒输出的整数值转换为4位二进制
        v += s_output.to_string(); // 将S盒输出追加到v中
    }
    return v;
}

//vr-->P_Box-->wr
string P_Box(string v)
{
    string w = "0000000000000000";
    for (int i = 0; i < 16; i++) 
    {
        char m = v[i];// 获取P置换的输入
        int pos = p[i];// 获取P置换的输出位置
        w[pos - 1] = m;// 进行P置换
    }
    return w;
}

// 密钥编排算法
string Key_Scheduling(string K, int r) 
{
    string k;
    for (int i = 4 * r - 4; i <= 4 * r + 11; i++) 
    {
        k += K[i];// 选择特定位置的密钥比特
    }
    return k;
}

// 轮密钥混合
string Round_Key_Mixing(string w, string k)
{
    string u;
    bitset<16> str1(w);
    bitset<16> str2(k);
    bitset<16> u_bit = str1 ^ str2;// 将w和k按位异或
    u = u_bit.to_string();
    return u;
}

// SPN加密函数
string SPN(string plaintext, string K)
{
    int Nr = 4;// SPN的轮数
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

    return y;//加密结果
}

//pai_s逆
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
    int index = stoi(u.substr(0, 4), 0, 2);// 将4位二进制子串转换为十进制整数
    bitset<4> s_output(inverseSBox[index]); // 将S盒输出的整数值转换为4位二进制
    v += s_output.to_string(); // 将S盒输出追加到v中       
    return v;
}

// 线性密码分析算法
pair<int, pair<int, int>> linearCryptanalysis(vector<pair<string, string>> data, int num_candidate_keys)
{
    pair<int, int> best_candidate_keys = make_pair(0, 0);
    for (pair<string, string> sample : data)
    {
        // 遍历训练数据集中的每一对明文-密文
        string x = sample.first;
        string y = sample.second;

        // 遍历每个可能的子密钥(L1, L2)
        for (int L1 = 0; L1 < num_candidate_keys; L1++)
        {
            for (int L2 = 0; L2 < num_candidate_keys; L2++)
            {
                // 计算u64、u84、u144和u164
                bitset<4> binaryNumber1(L1);//十进制数字L1转为二进制数字
                bitset<4> y2; // 用于存储位集合的变量
                for (int i = 0; i <= 3; i++)
                {
                    y2[i] = (y[i + 4] == '1');
                }
                bitset<4> v24_ = binaryNumber1 ^ y2;
                string v24 = v24_.to_string();

                bitset<4> binaryNumber2(L2);//十进制数字L2转为二进制数字
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
            // 更新最佳候选子密钥
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
    vector<pair<string, string>> data; // 明文-密文训练数据集，需要根据实际情况填充
    for (int i = 0; i < num_samples; i++)//生成8000对明文-密文对
    {
        string plaintext = bitset<16>(rand() & 0xFFFF).to_string();// 随机生成16位明文
        string ciphertext = SPN(plaintext, K);// 使用SPN加密函数加密明文
        data.push_back(make_pair(plaintext, ciphertext));// 存储明文和密文对
    }
    return data;
}

int main()
{
    int num_samples = 8000; // 用于统计的样本数量
    vector<pair<string, string>> data; // 明文-密文训练数据集，需要根据实际情况填充
    data = createdata(num_samples);
    int num_candidate_keys = 16; 

    pair<int, pair<int, int>> best_keys = linearCryptanalysis(data, num_candidate_keys);
    cout << "Best Candidate Keys: L1 = " << best_keys.second.first << ", L2 = " << best_keys.second.second << " with count " << best_keys.first << endl;

    return 0;
}
