Name: []

## Question 1

In the following code-snippet from `Num2Bits`, it looks like `sum_of_bits`
might be a sum of products of signals, making the subsequent constraint not
rank-1. Explain why `sum_of_bits` is actually a _linear combination_ of
signals.

```
        sum_of_bits += (2 ** i) * bits[i];
```

## Answer 1

虽然看起来像是信号的乘积之和，但请注意 `2**i` 实际上不是信号，而只是一个常数值（由 `i` 定义，取决于 `n`）。因此，`sum_of_bits` 实际上只是输入信号 `bits[i]` 的线性组合。

## Question 2

Explain, in your own words, the meaning of the `<==` operator.

## Answer 2

`<==` 运算符实际上是 `<--` 和 `===` 运算符的结合体，通过它我们既为信号赋值，又暗示该赋值满足所定义的约束。它基本上是一种简化，允许我们在分配线性组合的值时避免使用两个运算符。

## Question 3

Suppose you're reading a `circom` program and you see the following:

```
    signal input a;
    signal input b;
    signal input c;
    (a & 1) * b === c;
```

Explain why this is invalid.

## Answer 3

因为约束条件不能简化为形式 `a*b + c = 0`（秩-1），这是由于 `&` 运算符导致的。
