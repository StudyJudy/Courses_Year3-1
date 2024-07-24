# -*- coding: utf-8 -*-
from sys import exit
from bitcoin.core.script import *

from utils import *
from config import my_private_key, my_public_key, my_address, faucet_address
from ex1 import send_from_P2PKH_transaction


######################################################################
# TODO: Complete the scriptPubKey implementation for Exercise 3
#OP_2DUP ��ʾ����������
#OP_ADD ��ʾ���
#xxx��ѧ��ǰ3λ
#OP_EQUALVERIFY��ʾ�Ƚ��Ƿ����
#OP_SUB��ʾ���
#xxxxΪѧ�ź���λxxx
#OP_EQUAL������ΪTRUE
ex3a_txout_scriptPubKey = [OP_2DUP, OP_ADD, 211, OP_EQUALVERIFY, OP_SUB, 2061, OP_EQUAL]
######################################################################

if __name__ == '__main__':
    ######################################################################
    # TODO: set these parameters correctly
    amount_to_send = 0.00006666 #�����з��͵ļ��ܻ��ҽ��
    txid_to_spend = (
        'ff49b1a8cfcdd9c198a8e7017d9417eafa1b2c2391f441c924782059c49d4eb3')
    utxo_index = 4
    ######################################################################

    response = send_from_P2PKH_transaction(
        amount_to_send, txid_to_spend, utxo_index,
        ex3a_txout_scriptPubKey)
    print(response.status_code, response.reason)
    print(response.text)
