#include <iostream>
using namespace std;

// 计算 a 在 Zp 中的逆元
int modInverse(int a, int p) 
{
    int m0 = p, t, q;
    int x0 = 0, x1 = 1;

    if (p == 1) 
    {
        return 0;
    }

    // 应用扩展欧几里得算法
    while (a > 1)
    {
        q = a / p;
        t = p;

        // 更新 p 和 a，同时更新 x0 和 x1
        p = a % p;
        a = t;
        t = x0;

        x0 = x1 - q * x0;
        x1 = t;
    }

    // 确保 x1 是正数
    if (x1 < 0)
    {
        x1 += m0;
    }

    return x1;
}

int main() 
{
    int a, p;

    // 输入 a 和 p
    //cout << "Enter values for a and p (a p): ";
    cin >> a >> p;

    // 计算逆元并输出结果
    int result = modInverse(a, p);
    //cout << "The inverse of " << a << " in Zp is: " << result << endl;
    cout << result;

    return 0;
}
