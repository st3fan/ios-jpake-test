#!/usr/bin/python

# We are the Desktop

import sys, time, urllib2, hmac, base64
try:
    import json as simplejson
except ImportError:
    import simplejson
from jpake import JPAKE, params_80, params_112, params_128
from M2Crypto.EVP import Cipher
from hashlib import sha256, sha1

def get(url, etag = None):
    headers = {}
    if etag:
        headers['If-None-Match'] = etag
    request = urllib2.Request(url, None, headers)
    response = urllib2.urlopen(request)
    data = response.read()
    return simplejson.loads(data)

def put(url, data):
    opener = urllib2.build_opener(urllib2.HTTPHandler)
    json = simplejson.dumps(data)
    request = urllib2.Request(url, data=json)
    request.add_header('Content-Type', 'application/json')
    request.get_method = lambda: 'PUT'
    response = urllib2.urlopen(request)
    return response.info().getheader('Etag')

def delete(url):
    opener = urllib2.build_opener(urllib2.HTTPHandler)
    request = urllib2.Request(url)
    request.get_method = lambda: 'DELETE'
    response = urllib2.urlopen(request)

def encrypt(data, key, iv):
    cipher = Cipher(alg='aes_256_cbc', key=key, iv=iv, op=1)
    res = cipher.update(data)
    res += cipher.final()
    return res

def decrypt(data, key, iv):
    cipher = Cipher(alg='aes_256_cbc', key=key, iv=iv, op=0)
    res = cipher.update(data)
    res += cipher.final()
    return res    

s = sys.argv[1]
(password,channel) = s[:4],s[4:]

url = "http://localhost:5000/%s" % channel

print "X Password = %s" % password
print "X URL = %s" % url

j = JPAKE(password, signerid="sender", params=params_80)

# Get Server.Message1

print "X Getting Server.Message1"
server_one = get(url)
print "X Got Server.Message1: %s" % str(server_one)

# Put Client.Message1

print "X Putting Client.Message1"
client_one = { 'type': 'sender1', 'payload': j.one() }
client_one_etag = put(url, client_one)
print "X Put Client.Message1 (etag=%s) %s" % (client_one_etag, client_one)

# Get Server.Message2

print "X Getting Server.Message2"
while True:
    try:
        server_two = get(url, client_one_etag)
        break
    except urllib2.HTTPError, e:
        if e.code == 304:
            print "X Did not get right response yet. Trying again."
            pass
        else:
            raise
    time.sleep(1)
print "X Got Server.Message2: %s" % server_two

# Put Client.Message2

print "X Putting Client.Message2"
client_two = { 'type': 'sender2', 'payload': j.two(server_one['payload']) }
client_two_etag = put(url, client_two)
print "X Put Client.Message2 (etag=%s) %s" % (client_two_etag, client_two)

# Get Server.Message3

print "X Getting Server.Message3"
while True:
    try:
        server_three = get(url, client_two_etag)
        break
    except urllib2.HTTPError, e:
        if e.code == 304:
            print "X Did not get right response yet. Trying again."
            pass
        else:
            raise
    time.sleep(1)
print "X Got Server.Message3: %s" % server_three

# COMPARE KEYS

print "X Generating key"
key = j.three(server_two['payload'])
print "X Generated key: %s" % key

print "X Comparing keys"
print "X   Desktop H(K) = %s" % sha256(sha256(key).digest()).hexdigest()
print "X   Mobile  H(K) = %s" % server_three['payload']

if server_three['payload'] != sha256(sha256(key).digest()).hexdigest():
    print "X KEY FAIL"
    delete(url)
    sys.exit(1)

# Put Client.Message3

iv = '0123456780abcdef'
ct = encrypt(simplejson.dumps({ 'message': sys.argv[2] }), key, iv)
payload = { 'ciphertext': base64.b64encode(ct), 'IV': base64.b64encode(iv) }

print "X Putting Client.Message3"
client_three = { 'type': 'sender3', 'payload': payload }
client_three_etag = put(url, client_three)
print "X Put Client.Message3 (etag=%s) %s" % (client_three_etag, client_three)
