#!/usr/bin/env node

'use strict';

var uri = process.argv[2];
var key     = process.argv[3];
var Crypto = require("crypto")

const IV_LENGTH = 16;
    
function encrypturi(message, salt) {
    if (salt.length !== 32) {
        throw new Error(`Encryption Key length MUST be 32 characters!`);
    }
    let iv = Crypto.randomBytes(IV_LENGTH);
    let cipher = Crypto.createCipheriv("aes-256-cbc", Buffer.from(salt),iv);
    let encrypted = cipher.update(message);
    encrypted = Buffer.concat([encrypted, cipher.final()]);
    const result = iv.toString("hex") + ":" + encrypted.toString("hex");
    return result;
}

console.log( encrypturi(uri,key));