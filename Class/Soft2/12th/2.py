#!/usr/bin/env python
# -*- coding: utf-8 -*-

import xmlrpc.client
server = xmlrpc.client.ServerProxy('http://yubin.senmon.net/service/xmlrpc/')
result = server.yubin.fetchAddressByPostcode("1138656")[0]
for key in result:
    print(key + ": " + str(result[key]))
