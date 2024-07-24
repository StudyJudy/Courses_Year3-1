#include <iostream>
using namespace std;

// ���� a �� Zp �е���Ԫ
int modInverse(int a, int p) 
{
    int m0 = p, t, q;
    int x0 = 0, x1 = 1;

    if (p == 1) 
    {
        return 0;
    }

    // Ӧ����չŷ������㷨
    while (a > 1)
    {
        q = a / p;
        t = p;

        // ���� p �� a��ͬʱ���� x0 �� x1
        p = a % p;
        a = t;
        t = x0;

        x0 = x1 - q * x0;
        x1 = t;
    }

    // ȷ�� x1 ������
    if (x1 < 0)
    {
        x1 += m0;
    }

    return x1;
}

int main() 
{
    int a, p;

    // ���� a �� p
    //cout << "Enter values for a and p (a p): ";
    cin >> a >> p;

    // ������Ԫ��������
    int result = modInverse(a, p);
    //cout << "The inverse of " << a << " in Zp is: " << result << endl;
    cout << result;

    return 0;
}
