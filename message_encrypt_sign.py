import base64
import hashlib
from Crypto import Random
from Crypto.PublicKey import RSA


def rsakeys():  
    length=2048 
    privatekey = RSA.generate(length, Random.new().read)  
    publickey = privatekey.publickey()
    return privatekey, publickey


def encrypt(rsa_publickey, plain_text):
    cipher_text = rsa_publickey.encrypt(plain_text,32)[0]
    b64cipher = base64.b64encode(cipher_text)
    return b64cipher


def decrypt(rsa_privatekey, b64cipher):
    decoded_ciphertext = base64.b64decode(b64cipher)
    plaintext = rsa_privatekey.decrypt(decoded_ciphertext)
    return plaintext


def hashFunction(message):
    hashed = hashlib.sha256(message).hexdigest().encode("utf-8")
    return hashed


def sign(privatekey,data):
    hashed_data = hashFunction(data)
    return base64.b64encode(str((privatekey.sign(hashed_data,''))[0]).encode())


def verify(publickey, data, sign):
    hashed_data = hashFunction(data)
    return publickey.verify(hashed_data,(int(base64.b64decode(sign)),))



privatekey, publickey = rsakeys()
print(f"\nPublic: {publickey.exportKey('PEM')}")
print(f"\nPrivate: {privatekey.exportKey('PEM')}")


message = "Ola mundo"
message = message.encode("utf-8")


cipher = encrypt(publickey, message)
print(f"\nEncrypted message: {cipher}")


sign_cipher = sign(privatekey, cipher)
print(f"\nDigital sign: {sign_cipher}")


verify_message = verify(publickey, cipher, sign_cipher)
print(f"\nverify message: {verify_message}")


decrypted_message = decrypt(privatekey, cipher)
print(f"\nDecrypted message: {decrypted_message}")
