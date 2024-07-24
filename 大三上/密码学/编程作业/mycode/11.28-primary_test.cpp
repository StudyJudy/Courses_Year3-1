#include <iostream>
#include <cstdlib>
#include <cmath>
#include <random>
#include <bitset>
using namespace std;

// ���� (a * b) % n �ĳ˷�����
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

// ƽ���˿����㷨������ (a^m) mod n
unsigned long long square_mult(unsigned long long a, unsigned long long m, unsigned long long n)
{
    unsigned long long s = a;
    unsigned long long t = m;

    unsigned long long result = 1;
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
unsigned long long square_and_multiply(unsigned long long base, unsigned long long exp, unsigned long long modulus) 
{
    unsigned long long s = base;
    unsigned long long t = exp;
    
    unsigned long long result = 1;
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
bool Miller_Rabin(unsigned long long n)
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
    unsigned long long t = n - 1;
    unsigned long long s = 0;

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
        unsigned long long b = 2 + rand() % (n - 4);
        // long long b = 2 + i;

        // ʹ�� std::mt19937_64 ��Ϊ�����������
        // mt19937_64 rng(random_device{}());

        // ����ȡֵ��Χ
        // unsigned long long n = static_cast<unsigned long long>(1) << 63;

        // ���� [2, n-3] ��Χ�ڵ������
        // uniform_int_distribution<unsigned long long> distribution(2, n - 3);
        // unsigned long long b = distribution(rng);

        // ���� a^t % n
        unsigned long long r0 = square_mult(b, t, n);
        // unsigned long long r0 = square_and_multiply(b, t, n);
        
        unsigned long long r1;

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

// ���� Jacobi ����
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

        // ���� t �� n ��ֵ
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

// Solovay-Strassen���Բ���
bool Solovay_Strassen(unsigned long long n) 
{
    if (n == 2 || n == 3)
        return true;// ��� n Ϊ 2 �� 3��ֱ���ж�Ϊ����
    if (n <= 1 || n % 2 == 0)
        return false;// ��� n Ϊ 1 �� ż����ֱ���ж�Ϊ����

    for (int i = 0; i < 1000; ++i) 
    {
        unsigned long long a = 2 + rand() % (n - 2);  // ���� [2, n-1] ֮��������
        
        int x = Jacobi_sym(a, n);// ���� Jacobi ����

        unsigned long long exp = (n - 1) / 2;
        unsigned long long res = square_mult(a, exp, n);// ���� a^((n-1)/2) mod n

        if (x == 0 || res != x)
            return false;// ��� Jacobi ����Ϊ 0 �� a^((n-1)/2) mod n ������ Jacobi ���ţ��ж�Ϊ����
    }
    // ����������Զ�ͨ�����ж�Ϊ����Ϊ����
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
