//
//  ProjectContract.swift
//  web3Interaction
//
//  Created by Mitchell Tucker on 5/14/21.
//

import Foundation
import web3swift
import BigInt
import CoreLocation

public class ProjectContract{

    // MARK: - Private
    // NOTE: contract abi describes the methods (inputs,outputs) available in the contract
    private let abiVersion = 2
    // Web3 contract
    private var rawContract:web3.web3contract?
    // KeystoreManager
    public var keystoreManager:KeystoreManager?
    

    // MARK: - Public
    var endpoint:URL?
    var ethContractAddress:EthereumAddress?
    var socketURI:String?
    
    // MARK: Init
    init(wallet:Wallet){
        // ropsten should look very similar to rinkeby
        if network == .rinkeby{
            endpoint = URL(string:"https://rinkeby.infura.io/v3/<KEY>")!
            ethContractAddress = EthereumAddress("<CONTRACT ADDRESS>", ignoreChecksum: true)!
            socketURI = "wss://rinkeby.infura.io/ws/v3/<KEY>"
        }else{
            endpoint = URL(string:"http://127.0.0.1:7545")!
            ethContractAddress = EthereumAddress(contractAddress, ignoreChecksum: true)!
            socketURI = "http://127.0.0.1:7545"
        }
        do {
            // Set global web3 instance
            web3 = try Web3.new(endpoint!)
            rawContract = web3!.contract(contractABI, at: ethContractAddress, abiVersion: abiVersion)!
            
            keystoreManager = getKeyStoreManager(wallet: wallet)
            web3!.addKeystoreManager(keystoreManager)
        }catch{
            print ("Falied to Init contract do to \(error)")
        }
    }
    
    // MARK: getKeyStoreManager
    /**
            Create key store manager for wallets
     */
    private func getKeyStoreManager(wallet:Wallet) -> KeystoreManager {
        let data = wallet.data
        let keystoreManager: KeystoreManager
        if wallet.isHD {
            let keystore = BIP32Keystore(data)!
            keystoreManager = KeystoreManager([keystore])
        }else{
            let keystore = EthereumKeystoreV3(data)!
            keystoreManager = KeystoreManager([keystore])
        }
        return keystoreManager
    }
    
    /**
        Builds and returns a write transaction associated with provided parameters.
     
        Call method only works on contract method without the transfer of Ether

     - parameter method:     The contract method to call
     - parameter parameters: List of parameters associated with contract method
     - parameter wallet:     Wallet addres to call from (msg.sender)
     */
    // TODO: Throw error if WriteTransction is nil
    func buildCallMethod(method:String , parameters:[AnyObject], wallet:Wallet) -> WriteTransaction? {
        var transaction:WriteTransaction?

        do {
            // No extra data for method call
            let extraData: Data = Data()
            // Options for method call
            var options = TransactionOptions.defaultOptions
            options.from = EthereumAddress(wallet.address)! // current wallet address
            // Leave automatic for gas
            options.gasPrice = .automatic
            options.gasLimit = .automatic
            // Using (.method) will call a method
            // NOTE: Calling will not work if you're trying to send Ether
            let tx = rawContract!.method(method,
                                     parameters: parameters,
                                     extraData: extraData,
                                     transactionOptions: options)
            
            
            transaction = tx
        }catch{
            print("Error Calling \(method) \(error)")
        }
        return transaction
    }
    

    /**
        Builds and returns a write transaction associated with provided inputs
     
        Write method should be used with the transfer of Ether

     - parameter method:     The contract method to call
     - parameter parameters: List of parameters associated with contract method
     - parameter wallet:     Wallet addres to call from (msg.sender)
     */
    
    // TODO: Throw error if WriteTransction is nil
    func buildWriteMethod(method:String,value:BigUInt,parameters:[AnyObject]) -> WriteTransaction? {
        
        //let keystoreManager = getKeyStoreManager(wallet: wallet!)
        var transction:WriteTransaction?
        do {
            // No extra data for contract method
            let extraData: Data = Data()

            var options = TransactionOptions.defaultOptions
            // Value of Ether to send
            options.value = value
            options.from = EthereumAddress(wallet!.address)
            
            options.gasPrice = .automatic
            options.gasLimit = .automatic
            // Using (.write) will write to a contract method
            let tx = rawContract!.write(
                method,
                parameters: parameters,
                extraData: extraData,
                transactionOptions: options)
            
            transction = tx
        }catch{
            print("Error WritingMethod \(error)")
        }
        return transction
    }
    
}

