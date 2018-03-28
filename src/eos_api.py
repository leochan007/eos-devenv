#!/usr/bin/env python
# -*- encoding=utf-8 -*-

import requests
import json

class BaseAPI(object):

    def __init__(self, base_url = 'http://127.0.0.1:8888/'):
        self.base_url = base_url
        self.headers = {"Content-Type": "application/json"}

class ChainAPI(BaseAPI):

    def __init__(self, base_url = 'http://127.0.0.1:8888/'):
        super(ChainAPI, self).__init__(base_url)

    def get_info(self):
        r = requests.post(self.base_url + 'v1/chain/get_info')
        return r.json()

    def get_block(self, id_or_num):
        payload = {'block_num_or_id':id_or_num}
        r = requests.post(self.base_url + 'v1/chain/get_block', data = json.dumps(payload), headers = self.headers)
        return r.json()

    def get_account(self, name):
        payload = { 'name': name }
        r = requests.post(self.base_url + 'v1/chain/get_account', data = json.dumps(payload), headers = self.headers)
        return r.json()

    def get_code(self, account_name):
        payload = { 'account_name': account_name }
        r = requests.post(self.base_url + 'v1/chain/get_code', data = json.dumps(payload), headers = self.headers)
        return r.json()

    def get_table_rows(self, scope, code, table, isJson = True):
        payload = { 'scope': scope,  'code': code,  'table': table,  'json': isJson }
        r = requests.post(self.base_url + 'v1/chain/get_table_rows', data = json.dumps(payload), headers = self.headers)
        return r.json()

    def abi_json_to_bin(self, code, action, args = {}):
        payload = { 'code': code,  'action': action,  'args': args }
        r = requests.post(self.base_url + 'v1/chain/abi_json_to_bin', data = json.dumps(payload), headers = self.headers)
        return r.json()

class WalletAPI(BaseAPI):

    def __init__(self, base_url = 'http://127.0.0.1:8888/'):
        super(WalletAPI, self).__init__(base_url)

    def wallet_create(self):
        r = requests.post(self.base_url + 'v1/wallet/create', data = "default", headers = self.headers)
        return r.json()

if __name__ == '__main__' :
    
    print('-----ChainAPI-----')
    chainApi = ChainAPI()
    print(chainApi.get_info())
    print(chainApi.get_block(1))
    print(chainApi.get_account('inita'))
    print(chainApi.get_code('currency'))
    print(chainApi.get_table_rows('inita', 'currency', 'account', True))
    print(chainApi.abi_json_to_bin('currency', 'transfer', {"from":"initb", "to":"initc", "quantity":1000}))

    print('-----WalletAPI-----')
    walletApi = WalletAPI()
    print(walletApi.wallet_create())
