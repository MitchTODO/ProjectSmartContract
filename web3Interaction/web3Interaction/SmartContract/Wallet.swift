//
//  Wallet.swift
//  web3Interaction
//
//  Created by Mitchell Tucker on 5/14/21.
//


import Foundation
import web3swift
import PromiseKit

struct Wallet {
    let address: String
    let data: Data
    let name:String
    let isHD:Bool
}


struct HDKey {
    let name:String?
    let address:String
}

func createWallet(password:String,walletName:String) -> Wallet {
    let keystore = try! EthereumKeystoreV3(password:password)!
    let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
    let address = keystore.addresses!.first!.address
    return Wallet(address: address, data: keyData, name: walletName, isHD: false)
}


func createWallet(password:String,mnemonicesPassword:String,walletName:String) -> Wallet {
    let bitsOfEntropy: Int = 128 // Entropy is a measure of password strength. Usually used 128 or 256 bits.
    let mnemonics = try! BIP39.generateMnemonics(bitsOfEntropy: bitsOfEntropy)!
    let keystore = try! BIP32Keystore(
        mnemonics: mnemonics,
        password: password,
        mnemonicsPassword: mnemonicesPassword,
        language: .english)!
    let name = walletName
    let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
    let address = keystore.addresses!.first!.address
    return Wallet(address: address, data: keyData, name: name, isHD: true)
}

func getWallet(password:String,privateKey:String,walletName:String) -> Wallet  {
    let formattedKey = privateKey.trimmingCharacters(in: .whitespacesAndNewlines)
    let dataKey = Data.fromHex(formattedKey)!
    let keyStore = try! EthereumKeystoreV3(privateKey:dataKey, password: password)!
    let keyData = try! JSONEncoder().encode(keyStore.keystoreParams)
    let address = keyStore.addresses!.first!.address
    let wallet = Wallet(address: address, data: keyData, name: walletName, isHD: false)
    return wallet
}

func getWallet(password:String,mnemonics:String,walletName:String) -> Wallet {
    let keystore = try! BIP32Keystore(
        mnemonics: mnemonics,
        password: password,
        mnemonicsPassword: password, // THIS NEEDS TO BE CHECKED
        language: .english)!
    
    let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
    let address = keystore.addresses!.first!.address
    let wallet = Wallet(address: address, data: keyData, name: walletName, isHD: true)
    
    return wallet
}


