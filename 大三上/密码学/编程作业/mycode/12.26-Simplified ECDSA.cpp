#include <iostream>
#include <cstdlib>
#include <cmath>
#include <random>
#include <bitset>

using namespace std;

long long gcd(long long m, long long n)//���Լ��
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

//��С������
long long lcm(long long m, long long n)
{
    return m * n / gcd(m, n);
}

// ���� a �� Zp �е���Ԫ
long long modInverse(long a, long p)
{
    // ��ʼ������ m0��t��q���ֱ��ʾģ������ʱ��������
    long m0 = p, t, q;

    // ��ʼ������ x0 �� x1�����ڴ洢��չŷ������㷨���м���
    long x0 = 0, x1 = 1;

    // ��� p Ϊ 1����ʾ�����棬���� 0
    if (p == 1)
    {
        return 0;
    }

    // Ӧ����չŷ������㷨
    while (a > 1)
    {
        q = a / p;// ������
        t = p; // ���� p ��ֵ

        // ���� p �� a��ͬʱ���� x0 �� x1
        p = a % p;
        a = t;//�� t����ԭʼ p ��ֵ����ֵ�� a
        t = x0; // ���� x0 ��ֵ

        x0 = x1 - q * x0;// ���� x0
        x1 = t;// ���� x1
    }

    // ȷ�� x1 ������
    if (x1 < 0)
    {
        x1 += m0;
    }

    return x1;// ���ؼ���õ�����Ԫ
}

// ���� (a * b) % n �ĳ˷�����
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

// ƽ���˿����㷨������ (a^m) mod n
long long square_mult(long long a, long long m, long long n)
{
    long long s = a;
    long long t = m;

    long long result = 1;
    a = a % n;

    while (m > 0)
    {
        // ���ָ�������������Ե�ǰ�� a
        if (m % 2 == 1)
        {
            // result = (result * a) % n;
            result = multi(result, a, n);
        }
        // ��ָ�����룬����ƽ��
        m >>= 1;
        // a = (a * a) % n;
        a = multi(a, a, n);
    }
    // cout << "(a = " << s << " ^ b = " << t << ") % " << "n = " << n << " = " << result << endl;
    return result;
}

//ƽ�����㷨(�Ű������̲İ�)
long long square_and_multiply(long long base, long long exp, long long modulus)
{
    long long s = base;
    long long t = exp;

    long long result = 1;
    base = base % modulus;
    bitset<1024> binaryExponent(exp);

    for (int i = 0; i < binaryExponent.size(); i++)
    {
        // ���ָ���ĵ�ǰλ��1�����Ե�ǰ�� base
        if (binaryExponent[i] == 1)
        {
            result = (result * base) % modulus;
        }
        // ����ƽ��
        base = (base * base) % modulus;
    }

    // cout << "(a = " << s << " ^ b = " << t << ") % " << "n = " << modulus << " = " << result << endl;
    return result;
}

// Miller-Rabin�㷨�ж���������
bool Miller_Rabin(long long n)
{
    // ��nС�ڵ���1ʱ������false
    if (n <= 1)
    {
        return false;
    }
    //2��3������
    if (n <= 3)
    {
        return n == 2 || n == 3;
    }
    // ���n��ż������������
    if (n % 2 == 0)
    {
        return false;
    }

    // Ѱ�� s �� t���� n-1�ֽ��2^s * t������t��������
    long long t = n - 1;
    long long s = 0;

    while (t % 2 == 0)
    {
        t /= 2;
        s++;
    }

    // ���� k �β���,k = n - 3
    // ���ѡ��һ��������[2,n-2]�е�����b������ r0 = b^t mod n
    // ��� b^t mod n = 1 �� n - 1����n����������
    // �������һ��r��0 <= r < s��ʹ��r0^2 mod n=-1��n����������
    // ���������������������������nһ���Ǻ���

    for (int i = 0; i < 100; i++)
    {
        // ���ѡ����� b����Χ�� [2, n-2]
        long long b = 2 + rand() % (n - 4);
        // long long b = 2 + i;

        // ���� a^t % n
        long long r0 = square_mult(b, t, n);
        // long long r0 = square_and_multiply(b, t, n);

        long long r1;

        // ���r0���Ϊ 1��n-1 �� 0����ͨ�����飬��ѡb������һ�β���
        if (r0 == 1 || r0 == n - 1)
        {
            continue;
        }

        // ���r0 !=1��r0 !=n-1�������r1= r0^2 mod n
        // ���� s-1 ��ƽ������
        else
        {
            for (int r = 0; r < s; r++)
            {
                r1 = multi(r0, r0, n);

                // ��� r1 = 1���� n һ���Ǻ���
                if (r1 == 1)
                {
                    return false;
                }

                // ��� r1 = n-1����ͨ�����飬��ѡ b ������һ�β���
                if (r1 == n - 1)
                {
                    break;
                }

                // ���� r0 Ϊ r1��׼����һ�ֵ�ƽ��ȡģ����
                r0 = r1;
            }

            // ���ѭ������ʱ��r1 ��Ȼ������ n-1����δ�ҵ� n ������������֤�ݣ��� n ��������
            if (r1 != n - 1)
            {
                return false;
            }
        }
    }
    // �����ж�û�з��� n ����������֤�ݣ��� n ����������
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

// ������Բ����������ĺ�
void EllipticAddPoints(long long a, long long b, long long p, long long& x_add, long long& y_add, long long x1, long long y1, long long x2, long long y2)
{
    long long k, x, y;
    long long x0, y0;

    // ���(x1,y1)����Ԫ������Ϊ(x2,y2)
    if (x1 == -1 && y1 == -1)
    {
        x_add = x2;
        y_add = y2;
        return;
    }

    // ���(x2,y2)����Ԫ������Ϊ(x1,y1)
    else if (x2 == -1 && y2 == -1)
    {
        x_add = x1;
        y_add = y1;
        return;
    }

    // ��������Ǵ�ֱ��x��ĵ㣬���Ϊ��Ԫ
    else if (x1 == x2 && (y1 != y2))
    {
        x_add = -1;
        y_add = -1;
        return;
    }

    //x1=x2��y1=y1,��Ӧ���ӣ�k=((3x1^2+a)/(2y1))(mod p)
    if (x1 == x2 && y1 == y2)
    {
        k = ((3 * x1 * x1 + a) % p) * (Inverse(2 * y1, p) % p) % p;
    }

    //��ͬ���Ӧ���
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

    //����Ǹ������������
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

// ������Բ�����ϵĵ��k��
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
// ƽ���˿����㷨������ (2^x) mod q
long long Simplified_Hash(long long x, long long q)
{
    long long res;
    res = square_mult(2, x, q);
    return res;
}

int main()
{
    // ��Բ����Ϊ������Z11�ϵ�y ^ 2 = x ^ 3 + x + 6
    // ����Բ���߼ӷ�Ⱥ����q=13�������ϣ����Hash(x)=2^x mod q,������Ϣx��Zq-1
    long long p = 11;
    long long a = 1;
    long long b = 6;
    long long q = 13;

    // A(x0,y0)
    long long x0;
    long long y0;
    cin >> x0 >> y0;

    long long m; // private key m��Zq
    long long x; // message x��Zq-1
    long long k; // random number k��Zq*
    cin >> m >> x >> k;

    // �����µ���Բ��������ǩ���㷨����ѡ�����������k��Zq*�����ڸ�������Ϣx������sig��x,k��=��r,s��

    // ����kA=��u,v��
    long long u;
    long long v;
    
    EllipticMulPoints(p, a, b, k, x0, y0, u, v);

    // r = u mod q
    long long r;
    r = u % q;

    if (r == 0)
    {
        cout << "Wrong��Please select k again." << endl;
    }

    // s=k^-1��Hash(x)+mr��mod q
    long long s;
    long long k_inv;
    k_inv = Inverse(k, q);
    long long x_hash = Simplified_Hash(x, q);

    s = (k_inv * (x_hash + m * r)) % q;

    if (s == 0)
    {
        cout << "Wrong��Please select k again." << endl;
    }

    cout << r << " " << s << endl;

    return 0;
}