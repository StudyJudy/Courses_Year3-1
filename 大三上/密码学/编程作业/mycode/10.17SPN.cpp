#include <iostream>
#include<string>
#include<bitset>
using namespace std;

int s[16] = { 14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7 };//S��
int p[16] = { 1,5,9,13,2,6,10,14,3,7,11,15,4,8,12,16 };//P�û�

//ur-->S_Box-->vr
string S_Box(string u)
{
	string v;
	for (int i = 0; i < 16; i += 4) 
	{
		int index = stoi(u.substr(i, 4), 0, 2); // ���������ַ���ת��Ϊʮ��������
		//s_output ��һ��4λ�Ķ�����λ���������� index ��ֵ�Զ�������ʽ��ʾ��������Ҫʱ���ǰ���㣬��ȷ�� s_output ʼ����4λ��
		bitset<4> s_output(s[index]); // ��ʮ��������ת��Ϊһ��4λ�Ķ����Ʊ�ʾ����������洢�� s_output �С�
		v += s_output.to_string();//�� s_output �еĶ���������ת��Ϊ�ַ�����Ȼ��׷�ӵ��ַ��� v ��ĩβ
	}
	//cout << "v: " << v << endl;//���v��ʾ
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
	//cout << "w: " << w << endl;//���w��ʾ
	return w;
}

string Key_Scheduling(string K,int r)//��Կ�����㷨
{
	string k;
	for (int i = 4 * r - 4; i <= 4 * r +11; i++)//��k4r-3��ʼ������16��bit
	{
		k += K[i];
	}
	//cout << "k: " << k << endl;//���k��ʾ
	return k;
}
//wr-1 xor Kr-->ur
string Round_Key_Mixing(string w,string k)//����Կ���
{
	string u;
	bitset<16> str1(w);
	bitset<16> str2(k);
	bitset<16> u_bit = str1 ^ str2;
	u = u_bit.to_string();
	//cout << "u: " << u << endl;//���u��ʾ
	return u;
}
int main()
{
	int l = 4;
	int m = 4;
	int Nr = 4;
 	string x;//����x
	string K;//��ʼ��ԿK
	string y;//����y
	//cout << "x: ";
	cin >> x;//����x
	//cout << "K: ";
	cin >> K;//����K

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