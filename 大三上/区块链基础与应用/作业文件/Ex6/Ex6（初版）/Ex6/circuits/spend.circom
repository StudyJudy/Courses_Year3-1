include "./mimc.circom";

/*
 * IfThenElse sets `out` to `true_value` if `condition` is 1 and `out` to
 * `false_value` if `condition` is 0.
 *
 * It enforces that `condition` is 0 or 1.
 *
 */
template IfThenElse() {
    signal input condition;
    signal input true_value;
    signal input false_value;
    signal output out;

    // TODO
    // Hint: You will need a helper signal...
    //约束条件：条件必须是0或1
    condition * (1 - condition) === 0;

    //中间信号值，约束形式为 ab + c = 0
    signal diff <-- true_value - false_value;

    //约束输出信号
    //
    // 条件为1
    //  out = 1 * (true_value - false_value) + false_value = true_value
    //
    // 条件为0
    //  out = 0 * (true_value - false_value) + false_value = false_value
    out <== condition * diff + false_value;
}

/*
 * SelectiveSwitch takes two data inputs (`in0`, `in1`) and produces two ouputs.
 * If the "select" (`s`) input is 1, then it inverts the order of the inputs
 * in the ouput. If `s` is 0, then it preserves the order.
 *
 * It enforces that `s` is 0 or 1.
 */
template SelectiveSwitch() {
    signal input in0;
    signal input in1;
    signal input s;
    signal output out0;
    signal output out1;

    // TODO
    // 约束条件：确保选择信号s为0或1
    s * (1 - s) === 0;

    // 使用两个 If 语句确定输出值。

    // 如果(s==1)则为in1，否则为in0
    component firstOutput = IfThenElse();
    firstOutput.condition <== s;
    firstOutput.true_value <== in1;
    firstOutput.false_value <== in0;

    // 如果（s==1）则为in0，否则为in1
    component secondOutput = IfThenElse();
    secondOutput.condition <== s;
    secondOutput.true_value <== in0;
    secondOutput.false_value <== in1;

    // 输出信号必须等于if语句的结果
    out0 <== firstOutput.out;
    out1 <== secondOutput.out;
}

/*
 * Verifies the presence of H(`nullifier`, `nonce`) in the tree of depth
 * `depth`, summarized by `digest`.
 * This presence is witnessed by a Merle proof provided as
 * the additional inputs `sibling` and `direction`, 
 * which have the following meaning:
 *   sibling[i]: the sibling of the node on the path to this coin
 *               at the i'th level from the bottom.
 *   direction[i]: "0" or "1" indicating whether that sibling is on the left.
 *       The "sibling" hashes correspond directly to the siblings in the
 *       SparseMerkleTree path.
 *       The "direction" keys the boolean directions from the SparseMerkleTree
 *       path, casted to string-represented integers ("0" or "1").
 */
template Spend(depth) {
    signal input digest;
    signal input nullifier;
    signal private input nonce;
    signal private input sibling[depth];
    signal private input direction[depth];

    // TODO
    //这个数组存储我们在每个层级计算的证明哈希，+1用于存储根节点。
    component computed_hash[depth + 1];

    //第0层只是H（'nullifier','digest'）
    computed_hash[0] = Mimc2();
    computed_hash[0].in0 <== nullifier; 
    computed_hash[0].in1 <== nonce;

    //存储路径上的开关
    component switches[depth];

    //设置沿着证明路径的约束。
    for (var i = 0; i < depth; ++i) {
        switches[i] = SelectiveSwitch();
        //如果directions[i]为true，将计算H(sibling[i], computed_hash[i])。
        //如果为false，不交换，计算H(computed_hash[i], sibling[i])。
        switches[i].in0 <== computed_hash[i].out;
        switches[i].in1 <== sibling[i];
        switches[i].s <== direction[i];

        //计算下一层级的哈希。
        computed_hash[i + 1] = Mimc2();
        computed_hash[i + 1].in0 <== switches[i].out0;
        computed_hash[i + 1].in1 <== switches[i].out1;
    }

    //验证摘要是否匹配最终哈希。
    computed_hash[depth].out === digest;
}
