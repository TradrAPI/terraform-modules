from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
from sys import argv

scriptname, uri, key, iv = argv

def encryptUri(uri, key, iv):
    if (len(key) != 32):
        raise Exception("Sorry, encryption key must be 32 characters long.")
    uri_bytes=uri.encode('utf-8')
    key_bytes=key.encode('utf-8')
    iv_bytes=iv.encode('utf-8')
    cipher = AES.new(key_bytes, AES.MODE_CBC, iv=iv_bytes)
    ct_bytes = cipher.encrypt(pad(uri_bytes, AES.block_size))
    iv = cipher.iv.hex()
    ct = ct_bytes.hex()
    result = f"{iv}:{ct}"
    return result

def main():
    print(encryptUri(uri, key, iv))

if __name__ == "__main__":
    main()