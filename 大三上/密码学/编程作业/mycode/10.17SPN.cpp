#include <iostream>
#include<string>
#include<bitset>
using namespace std;

int s[16] = { 14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7 };//S盒
int p[16] = { 1,5,9,13,2,6,10,14,3,7,11,15,4,8,12,16 };//P置换

//ur-->S_Box-->vr
string S_Box(string u)
{
	string v;
	for (int i = 0; i < 16; i += 4) 
	{
		int index = stoi(u.substr(i, 4), 0, 2); // 将二进制字符串转换为十进制整数
		//s_output 是一个4位的二进制位集，将整数 index 的值以二进制形式表示，并在需要时填充前导零，以确保 s_output 始终是4位的
		bitset<4> s_output(s[index]); // 将十进制整数转换为一个4位的二进制表示，并将结果存储在 s_output 中。
		v += s_output.to_string();//将 s_output 中的二进制数据转换为字符串，然后追加到字符串 v 的末尾
	}
	//cout << "v: " << v << endl;//输出v提示
	return v;
}

//vr-->P_Box-->wr
string P_Box(string v)
{
	string w = "0000000000000000";
	for (int i = 0; i < 16; i++)
	{
		char m = v[i];
		int pos = p[i];
		w[pos-1] = m;
	}
	//cout << "w: " << w << endl;//输出w提示
	return w;
}

string Key_Scheduling(string K,int r)//密钥编排算法
{
	string k;
	for (int i = 4 * r - 4; i <= 4 * r +11; i++)//从k4r-3开始的连续16个bit
	{
		k += K[i];
	}
	//cout << "k: " << k << endl;//输出k提示
	return k;
}
//wr-1 xor Kr-->ur
string Round_Key_Mixing(string w,string k)//轮密钥混合
{
	string u;
	bitset<16> str1(w);
	bitset<16> str2(k);
	bitset<16> u_bit = str1 ^ str2;
	u = u_bit.to_string();
	//cout << "u: " << u << endl;//输出u提示
	return u;
}
int main()
{
	int l = 4;
	int m = 4;
	int Nr = 4;
 	string x;//明文x
	string K;//初始密钥K
	string y;//密文y
	//cout << "x: ";
	cin >> x;//输入x
	//cout << "K: ";
	cin >> K;//输入K

	string u;
	string v;
	string w = x;
	string k;

	for (int r = 1; r < Nr; r++)
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
	//cout << "y: ";
	cout<< y;
	return 0;

}