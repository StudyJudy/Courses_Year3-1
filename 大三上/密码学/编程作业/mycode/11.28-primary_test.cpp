#include <iostream>
#include <cstdlib>
#include <cmath>
#include <random>
#include <bitset>
using namespace std;

// 计算 (a * b) % n 的乘法函数
unsigned long long multi(unsigned long long a, unsigned long long b, unsigned long long n)
{
    unsigned long long s = a;
    unsigned long long t = b;

    unsigned long long result = 0;
    a %= n;

    while (b > 0) 
    {
        if (b % 2 == 1)
        {
            result = (result + a) % n;
        }
        a = (a * 2) % n;
        b /= 2;
    }

    // cout << "(a = " << s << " * b = " << t << ") % " << "n = " << n << " = " << result << endl;
    return result;
}

// 平方乘快速算法，计算 (a^m) mod n
unsigned long long square_mult(unsigned long long a, unsigned long long m, unsigned long long n)
{
    unsigned long long s = a;
    unsigned long long t = m;

    unsigned long long result = 1;
    a = a % n;

    while (m > 0) 
    {
        // 如果指数是奇数，乘以当前的 a
        if (m % 2 == 1) 
        {
           // result = (result * a) % n;
            result = multi(result, a, n);
        }
        // 将指数减半，底数平方
        m >>= 1;
        // a = (a * a) % n;
        a = multi(a, a, n);
    }
    // cout << "(a = " << s << " ^ b = " << t << ") % " << "n = " << n << " = " << result << endl;
    return result;
}

//平方乘算法(信安数基教材版)
unsigned long long square_and_multiply(unsigned long long base, unsigned long long exp, unsigned long long modulus) 
{
    unsigned long long s = base;
    unsigned long long t = exp;
    
    unsigned long long result = 1;
    base = base % modulus;
    bitset<1024> binaryExponent(exp); 

    for (int i = 0; i < binaryExponent.size(); i++) 
    {
        // 如果指数的当前位是1，乘以当前的 base
        if (binaryExponent[i] == 1) 
        {
            result = (result * base) % modulus;
        }
        // 底数平方
        base = (base * base) % modulus;
    }

    // cout << "(a = " << s << " ^ b = " << t << ") % " << "n = " << modulus << " = " << result << endl;
    return result;
}

// Miller-Rabin算法判定素数性质
bool Miller_Rabin(unsigned long long n)
{
    // 当n小于等于1时，返回false
    if (n <= 1) 
    {
        return false;
    }
    //2和3是素数
    if (n <= 3)
    {
        return n == 2 || n == 3;
    }
    // 如果n是偶数，则不是素数
    if (n % 2 == 0)
    {
        return false;
    }

    // 寻找 s 和 t，将 n-1分解成2^s * t，其中t是奇整数
    unsigned long long t = n - 1;
    unsigned long long s = 0;

    while (t % 2 == 0) 
    {
        t /= 2;
        s++;
    }

    // 进行 k 次测试,k = n - 3
    // 随机选择一个在区间[2,n-2]中的整数b，计算 r0 = b^t mod n
    // 如果 b^t mod n = 1 或 n - 1，则n可能是素数
    // 如果存在一个r，0 <= r < s，使得r0^2 mod n=-1，n可能是素数
    // 如果上述两个条件都不成立，则n一定是合数

    for (int i = 0; i < 100; i++) 
    {   
        // 随机选择基数 b，范围在 [2, n-2]
        unsigned long long b = 2 + rand() % (n - 4);
        // long long b = 2 + i;

        // 使用 std::mt19937_64 作为随机数生成器
        // mt19937_64 rng(random_device{}());

        // 设置取值范围
        // unsigned long long n = static_cast<unsigned long long>(1) << 63;

        // 生成 [2, n-3] 范围内的随机数
        // uniform_int_distribution<unsigned long long> distribution(2, n - 3);
        // unsigned long long b = distribution(rng);

        // 计算 a^t % n
        unsigned long long r0 = square_mult(b, t, n);
        // unsigned long long r0 = square_and_multiply(b, t, n);
        
        unsigned long long r1;

        // 如果r0结果为 1或n-1 或 0，则通过检验，重选b继续下一次测试
        if (r0 == 1 || r0 == n - 1)
        {
            continue;
        }

        // 如果r0 !=1或r0 !=n-1，则计算r1= r0^2 mod n
        // 进行 s-1 次平方运算
        else
        {
            for (int r = 0; r < s; r++)
            {
                r1 = multi(r0, r0, n);

                // 如果 r1 = 1，则 n 一定是合数
                if (r1 == 1)
                {
                    return false;
                }

                // 如果 r1 = n-1，则通过检验，重选 b 继续下一次测试
                if (r1 == n - 1) 
                {
                    break;
                }

                // 更新 r0 为 r1，准备下一轮的平方取模运算
                r0 = r1;
            }

            // 如果循环结束时，r1 仍然不等于 n-1，仍未找到 n 可能是素数的证据，则 n 不是素数
            if (r1 != n - 1)
            {
                return false;
            }
        }
    }
    // 测试中都没有发现 n 不是素数的证据，则 n 可能是素数
    return true;
}

// 计算 Jacobi 符号
unsigned long long Jacobi_sym(unsigned long long a, unsigned long long n)
{
    if (n <= 0 || n % 2 == 0)
    {
        return 0;
    }

    if (n == 1)
    {
        return 1;
    }

    int result = 1;
    unsigned long long t = a % n;

    if (t < 0)
    {
        t += n;
    }
    while (t != 0) 
    {
        while (t % 2 == 0) 
        {
            t /= 2;
            unsigned long long s = n % 8;

            if (s == 3 || s == 5)
                result = -result;
        }

        // 交换 t 和 n 的值
        unsigned long long temp = t;
        t = n;
        n = temp;

        if (t % 4 == 3 && n % 4 == 3)
            result = -result;

        t = t % n;

        if (t < 0)
        {
            t += n;
        }
    }

    if (n == 1)
        return result;

    return 0;
}

// Solovay-Strassen素性测试
bool Solovay_Strassen(unsigned long long n) 
{
    if (n == 2 || n == 3)
        return true;// 如果 n 为 2 或 3，直接判定为素数
    if (n <= 1 || n % 2 == 0)
        return false;// 如果 n 为 1 或 偶数，直接判定为合数

    for (int i = 0; i < 1000; ++i) 
    {
        unsigned long long a = 2 + rand() % (n - 2);  // 生成 [2, n-1] 之间的随机数
        
        int x = Jacobi_sym(a, n);// 计算 Jacobi 符号

        unsigned long long exp = (n - 1) / 2;
        unsigned long long res = square_mult(a, exp, n);// 计算 a^((n-1)/2) mod n

        if (x == 0 || res != x)
            return false;// 如果 Jacobi 符号为 0 或 a^((n-1)/2) mod n 不等于 Jacobi 符号，判定为合数
    }
    // 如果经过测试都通过，判定为可能为素数
    return true;
}

int main() 
{
    unsigned long long n;
    bool Res;
    cin >> n;

    if (n <= 0)
    {
        cout << "No" << endl;
    }
    else
    {
        Res = Miller_Rabin(n);
        // Res = Solovay_Strassen(n);

        if (Res)
        {
            cout << "Yes" << endl;
        }
        else
        {
            cout << "No" << endl;
        }
    }
    /*
    cout << " multi(9726, 3533, 11413): " << endl;
    multi(9726, 3533, 11413);
    cout << endl;

    cout << "square_mult(9726, 3533, 11413): " << endl;
    square_mult(9726, 3533, 11413);
    cout << endl;

    cout << "square_and_multiply(9726, 3533, 11413): " << endl;
    square_and_multiply(9726, 3533, 11413);
    cout << endl;
    */
    return 0;
}
