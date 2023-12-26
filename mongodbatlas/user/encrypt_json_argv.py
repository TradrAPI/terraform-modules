from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
from sys import argv
import sys
import json

scriptname, uri, key = argv

def encryptUri(uri, key, iv_length):
    if (len(key) != 32):
        raise Exception("Sorry, encryption key must be 32 characters long.")
    uri_bytes=uri.encode('utf-8')
    key_bytes=key.encode('utf-8')
    cipher = AES.new(key_bytes, AES.MODE_CBC)
    ct_bytes = cipher.encrypt(pad(uri_bytes, AES.block_size))
    iv = cipher.iv.hex()
    ct = ct_bytes.hex()
    result = f"{iv}:{ct}"
    return result

def main():
    uri_encrypted = encryptUri(uri, key, 16)
    output = json.dumps({'uri': str(uri_encrypted) })
    # sys.stdout.write("thisisastring")
    sys.stdout.write(output)

if __name__ == "__main__":
    main()