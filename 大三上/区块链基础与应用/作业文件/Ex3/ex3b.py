# -*- coding: utf-8 -*-
from sys import exit
from bitcoin.core.script import *

from utils import *
from config import my_private_key, my_public_key, my_address, faucet_address
from ex1 import P2PKH_scriptPubKey
from ex3a import ex3a_txout_scriptPubKey


######################################################################
# TODO: set these parameters correctly
amount_to_send = 0.00000088
txid_to_spend = '7f96268063fe2b4bad9bfbaa3d6276a17d8c4cb890af92e2b4b645deacb20a83'
utxo_index = 0
######################################################################

txin_scriptPubKey = ex3a_txout_scriptPubKey
######################################################################
# TODO: implement the scriptSig for redeeming the transaction created
# in  Exercise 3a.
# 用于满足条件的解（x，y）的值，以便花费在Exercise 3a中创建的交易输出
txin_scriptSig = [1136, -925]

######################################################################
#定义交易输出的锁定脚本（scriptPubKey）
txout_scriptPubKey = P2PKH_scriptPubKey(faucet_address)

response = send_from_custom_transaction(
    amount_to_send, txid_to_spend, utxo_index,
    txin_scriptPubKey, txin_scriptSig, txout_scriptPubKey)
print(response.status_code, response.reason)
print(response.text)
