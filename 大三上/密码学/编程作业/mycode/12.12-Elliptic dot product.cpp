/*
请计算定义在有限域Zp上椭圆曲线y^2=x^3+ax+b的点乘kP。 
其中p为一个素数，p<2^31; a, b定义在Zp上; 0<=k<2^31, 设P=(x,y)为椭圆曲线上的整点(保证（x,y）为椭圆曲线上的整点), 其中x, y定义在Zp上。
同时定义椭圆曲线上的零元(无穷远点)为(-1,-1)。

示例1：
Input
1 6 11 （a b p）
2 7 2 (x y k)
Output 输出kP的横纵坐标（定义在Zp上）, 若是零元输出(-1,-1)
5 2

示例2：
Input
1 6 11 （a b p）
2 7 0 (x y k)
Output 输出kP的横纵坐标
-1 -1
*/

#include <iostream>
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

//扩展欧几里得算法求逆元
/*int Inverse(int a, int b)
{
    int s[1000000], t[1000000], q[1000000], r[1000000];
    s[0] = 1;
    t[0] = 0;
    s[1] = 0;
    t[1] = 1;
    r[0] = a;
    r[1] = b;
    q[0] = 0;
    q[1] = a / b;
    int i = 2;
    while (true)
    {
        r[i] = r[i - 2] % r[i - 1];
        //cout << "r" << i << "=" << r[i] << endl;
        if (r[i] == 0)
        {
            break;
        }
        q[i] = r[i - 1] / r[i];
        //cout << "q" << i << "=" << q[i] << endl;
        s[i] = s[i - 2] - s[i - 1] * q[i - 1];
        //cout << "s" << i << "=" << s[i] << endl;
        t[i] = t[i - 2] - t[i - 1] * q[i - 1];
        //cout << "t" << i << "=" << t[i] << endl;
        i++;
        //cout << endl;
    }
    return s[i - 1];
}*/

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
        /*
        //  k = ((y2 - y1) * Inverse(x2 - x1, p)) % p;

        //x1!=x2，对应点加，k=((y2-y1)/(x2-x1))(mod p)
        if (x2 - x1 > 0)
        {
            k = (((y2 - y1) % p) * (Inverse(x2 - x1, p) % p)) % p;
        }

        //x1!=x2，对应点加，k=((y2-y1)/(x2-x1))(mod p)
        //负数取绝对值，再取反
        else
        {
            k = (((y2 - y1) % p) * (0 - Inverse(x1 - x2, p) % p)) % p;
        }*/

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

int main() 
{
    long long a, b, p; // 椭圆曲线参数
    long long x, y, k; // 点坐标（x,y）和倍数k

    // 椭圆曲线参数Zp(a,b)
    cin >> a >> b >> p;

    // 点坐标和倍数
    cin >> x >> y >> k;

    // 计算点乘
    long long x_multi_result;
    long long y_multi_result;

    EllipticMulPoints(p, a, b, k, x, y, x_multi_result, y_multi_result);

    // 输出结果
    cout << x_multi_result << " " << y_multi_result << endl;

    return 0;
}