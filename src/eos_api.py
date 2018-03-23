#!/usr/bin/env python
# -*- encoding=utf-8 -*-

import requests
import json

class ChainAPI(object) :

    def __init__(self, base_url = 'http://127.0.0.1:8888/'):
        self.base_url = base_url

    def get_info(self):
        r = requests.post(self.base_url + 'v1/chain/get_info')
        return r.json()

    def get_block(self, id_or_num):
        payload = { 'block_num_or_id' : id_or_num }
        r = requests.post(self.base_url + 'v1/chain/get_block', data = payload)
        return r.json()

    def get_account(self, name):
        payload = { 'name' : name }
        r = requests.post(self.base_url + 'v1/chain/get_account', data = payload)
        return r.json()

if __name__ == '__main__' :
    
    chainApi = ChainAPI()
    print(chainApi.get_info())
    print(chainApi.get_block(1))
    print(chainApi.get_account('inita'))
