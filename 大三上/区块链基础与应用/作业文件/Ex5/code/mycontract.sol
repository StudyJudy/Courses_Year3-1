// Please paste your contract's solidity code here
// Note that writing a contract here WILL NOT deploy it and allow you to access it from your client
// You should write and develop your contract in Remix and then, before submitting, copy and paste it here

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;
contract BlockchainSplitwise {
    struct Debt {
        uint32 amount;
    }
    
    // 跟踪债务。从债务人映射到映射从债权人到债务。
    // 例如，debts[Alice][Bob] = 10 意味着爱丽丝欠鲍勃10块钱。
    mapping(address=>mapping(address=>Debt)) internal all_debts;
    
    // 查找债务人欠债权人的债务总额.
    function lookup(address debtor, address creditor) public view returns (uint32 ret) {
        ret = all_debts[debtor][creditor].amount;
    }
    
    // 添加了msg.sender欠债主更多美元的事实
    // 路径可以是从债权人到msg.sender的现有路径，这意味着通过添加此IOU将创建一个循环min_on_cycle”是建议的周期最低金额，该金额将从路径上的所有债务中删除（包括正在添加的借条）
    //
    // 该函数验证以下内容：
    //    1. 若给出了路径，它确实存在，并将债权人和债务人联系起来。
    //    2. min_on_cycle必须是循环上的最小值。
    function add_IOU(address creditor, uint32 amount,  address[] memory path, uint32 min_on_cycle) public {
        address debtor = msg.sender;
        
        require(debtor != creditor, "Creditor cannot be creditor.");
        
        Debt storage iou = all_debts[debtor][creditor];  // assigns a reference
        
        // 检查是否溢出。
        if (min_on_cycle == 0) {
            // No cycles, just add the IOU and return.
            iou.amount = add(iou.amount, amount);
            return;
        }
        // 验证min_on_cycle始终是直接欠下的金额（因为这是循环欠款的末端）
        require(min_on_cycle <= (iou.amount + amount));
        // 验证从债权人到债务人的给定路径是否存在。如果是，它会修复路径。
        require(verify_and_fix_path(creditor, debtor, path, min_on_cycle));
        // 添加新的欠条，因为它不会产生循环。
        iou.amount = add(iou.amount, (amount - min_on_cycle));
    }
    
    // 验证路径是否有效并修复它。路径可以是部分固定的，所以调用者负责撤消部分固定的路径。最简单的方法是使用require（），因为这将回滚事务。
    function verify_and_fix_path(address start, address end, address[] memory path, uint32 min_on_cycle) private returns (bool ret) {
        if (start != path[0] || end != path[path.length - 1]) {
            return false;
        }
        // 我们愿意检查的Maximu路径大小为10，不包括开始和结束。
        if (path.length > 12) {
            return false;
        }
        for (uint i = 1; i < path.length; i++) {
            // 如果债务不存在或小于min_on_cycle，这是无效的。
            Debt storage iou = all_debts[path[i-1]][path[i]];
            if (iou.amount == 0 || iou.amount < min_on_cycle) {
                return false;
            }
            // 否则，它是有效的，所以我们继续修复它。
            else {
                iou.amount -= min_on_cycle;
            }
        }
        return true;
    }
    
    // 带溢出检查的添加.
    function add(uint32 a, uint32 b) internal pure returns (uint32) {
      uint32 c = a + b;
      require(c >= a);
      return c;
    }
}