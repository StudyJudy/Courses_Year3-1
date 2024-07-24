#include <iostream>
#include <cstdlib>
#include <cmath>
#include <random>
#include <bitset>

using namespace std;

long long gcd(long long m, long long n)//最大公约数
{
    if (m < n)
    {
        long long temp;
        temp = m;
        m = n;
        n = temp;
    }
    while (n != 0)
    {
        long long r = m % n;
        m = n;
        n = r;
    }
    return m;
}

//最小公倍数
long long lcm(long long m, long long n)
{
    return m * n / gcd(m, n);
}

// 计算 a 在 Zp 中的逆元
long long modInverse(long a, long p)
{
    // 初始化变量 m0、t、q，分别表示模数、临时变量、商
    long m0 = p, t, q;

    // 初始化变量 x0 和 x1，用于存储扩展欧几里得算法的中间结果
    long x0 = 0, x1 = 1;

    // 如果 p 为 1，表示不可逆，返回 0
    if (p == 1)
    {
        return 0;
    }

    // 应用扩展欧几里得算法
    while (a > 1)
    {
        q = a / p;// 计算商
        t = p; // 保存 p 的值

        // 更新 p 和 a，同时更新 x0 和 x1
        p = a % p;
        a = t;//将 t（即原始 p 的值）赋值给 a
        t = x0; // 保存 x0 的值

        x0 = x1 - q * x0;// 更新 x0
        x1 = t;// 更新 x1
    }

    // 确保 x1 是正数
    if (x1 < 0)
    {
        x1 += m0;
    }

    return x1;// 返回计算得到的逆元
}

// 计算 (a * b) % n 的乘法函数
long long multi(long long a, long long b, long long n)
{
    long long s = a;
    long long t = b;

    long long result = 0;
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
long long square_mult(long long a, long long m, long long n)
{
    long long s = a;
    long long t = m;

    long long result = 1;
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
long long square_and_multiply(long long base, long long exp, long long modulus)
{
    long long s = base;
    long long t = exp;

    long long result = 1;
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
bool Miller_Rabin(long long n)
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
    long long t = n - 1;
    long long s = 0;

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
        long long b = 2 + rand() % (n - 4);
        // long long b = 2 + i;

        // 计算 a^t % n
        long long r0 = square_mult(b, t, n);
        // long long r0 = square_and_multiply(b, t, n);

        long long r1;

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

long long Inverse(long long r, long long p)
{
    long long m = p;
    long long n;
    long long q;
    long long t = 0;
    long long s = 1;

    if (p == 1)
        return 0;

    while (r > 1)
    {
        q = r / p;
        n = p;

        p = r % p;
        r = n;

        n = t;
        t = s - q * t;
        s = n;
    }

    if (s < 0)
        s += m;

    return s;
}

// 计算椭圆曲线上两点的和
void EllipticAddPoints(long long a, long long b, long long p, long long& x_add, long long& y_add, long long x1, long long y1, long long x2, long long y2)
{
    long long k, x, y;
    long long x0, y0;

    // 如果(x1,y1)是零元，则结果为(x2,y2)
    if (x1 == -1 && y1 == -1)
    {
        x_add = x2;
        y_add = y2;
        return;
    }

    // 如果(x2,y2)是零元，则结果为(x1,y1)
    else if (x2 == -1 && y2 == -1)
    {
        x_add = x1;
        y_add = y1;
        return;
    }

    // 如果两点是垂直于x轴的点，结果为零元
    else if (x1 == x2 && (y1 != y2))
    {
        x_add = -1;
        y_add = -1;
        return;
    }

    //x1=x2，y1=y1,对应倍加，k=((3x1^2+a)/(2y1))(mod p)
    if (x1 == x2 && y1 == y2)
    {
        k = ((3 * x1 * x1 + a) % p) * (Inverse(2 * y1, p) % p) % p;
    }

    //不同点对应点加
    else
    {
        y0 = y2 - y1;
        x0 = x2 - x1;

        while (x0 < 0)
        {
            x0 += p;
        }

        while (y0 < 0)
        {
            y0 += p;
        }

        if (x0 == 0 && y0 != 0)
        {
            x_add = -1;
            y_add = -1;
            return;
        }

        else
        {
            k = ((y0 % p) * (Inverse(x0, p) % p)) % p;
        }

    }

    if (k < 0)
    {
        k += p;
    }

    x_add = (k * k - x1 - x2) % p;
    y_add = (k * (x1 - x_add) - y1) % p;

    //如果是负数，变成正数
    while (x_add < 0)
    {
        x_add += p;
    }

    while (y_add < 0)
    {
        y_add += p;
    }

    return;
}

// 计算椭圆曲线上的点的k倍
void EllipticMulPoints(long long p, long long a, long long b, long long k, long long x1, long long y1, long long& x_mul_result, long long& y_mul_result)
{
    long long x5 = x1;
    long long y5 = y1;

    x_mul_result = -1;
    y_mul_result = -1;

    long long tempX = -1;
    long long tempY = -1;

    if (k <= 0)
    {
        x_mul_result = -1;
        y_mul_result = -1;
        return;
    }

    for (long long i = 0; i < k - 1; i++)
    {
        EllipticAddPoints(a, b, p, tempX, tempY, x5, y5, x1, y1);
        // EllipticAddPoints(a, b, p, x_result, y_result, x_result, y_result, x1, y1);

        x5 = tempX;
        y5 = tempY;
    }

    x_mul_result = x5;
    y_mul_result = y5;
 
    return;
}

// Hash(x)=2^x mod q   
// 平方乘快速算法，计算 (2^x) mod q
long long Simplified_Hash(long long x, long long q)
{
    long long res;
    res = square_mult(2, x, q);
    return res;
}

int main()
{
    // 椭圆曲线为定义在Z11上的y ^ 2 = x ^ 3 + x + 6
    // 该椭圆曲线加法群阶数q=13，定义哈希函数Hash(x)=2^x mod q,其中消息x∈Zq-1
    long long p = 11;
    long long a = 1;
    long long b = 6;
    long long q = 13;

    // A(x0,y0)
    long long x0;
    long long y0;
    cin >> x0 >> y0;

    long long m; // private key m∈Zq
    long long x; // message x∈Zq-1
    long long k; // random number k∈Zq*
    cin >> m >> x >> k;

    // 有如下的椭圆曲线数字签名算法：设选定秘密随机数k∈Zq*，对于给定的消息x，定义sig（x,k）=（r,s）

    // 其中kA=（u,v）
    long long u;
    long long v;
    
    EllipticMulPoints(p, a, b, k, x0, y0, u, v);

    // r = u mod q
    long long r;
    r = u % q;

    if (r == 0)
    {
        cout << "Wrong！Please select k again." << endl;
    }

    // s=k^-1（Hash(x)+mr）mod q
    long long s;
    long long k_inv;
    k_inv = Inverse(k, q);
    long long x_hash = Simplified_Hash(x, q);

    s = (k_inv * (x_hash + m * r)) % q;

    if (s == 0)
    {
        cout << "Wrong！Please select k again." << endl;
    }

    cout << r << " " << s << endl;

    return 0;
}