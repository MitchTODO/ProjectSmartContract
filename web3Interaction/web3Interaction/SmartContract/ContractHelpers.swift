//
//  ContractHelpers.swift
//  web3Interaction
//
//  Created by Mitchell Tucker on 5/14/21.
//

import Foundation
import BigInt
import PromiseKit
/**
 
 Writes to any contract method.
 
 - Note: Should be used when sending Ether or exchanging a asset; Requires wallet password
 
 - parameter method: Contract method to write to.
 - parameter amount: Amount of Ether to send.
 - parameter parameter: Parameters associated with contract method
 
 - returns Promise wrapped Bool
 
 */
func writeContractMethod(method:ContractMethods,amount:BigUInt,parameters:[AnyObject]) -> Promise<Bool> {
    return Promise { seal in
        DispatchQueue.global().async {
            
            let tx = contract!.buildWriteMethod(method: method.rawValue, value: amount, parameters: parameters)
            do {
                let _ = try tx!.send(password: password)
                seal.resolve(.fulfilled(true))
            }catch {
                seal.reject(error)
            }
        }
    }
}

/**
 
 Calls to any contract method.
    
 - Note: Requires wallet password Async
 
 - parameter method: Contract method to write to.
 - parameter parameter: Parameters associated with contract method
 - parameter password:  Password occocated with the wallet (optional string)
 
 - returns Promise wrapped Bool
 
 */
func callContractMethod(method:ContractMethods,parameters:[AnyObject],password:String?) -> Promise<Bool> {
    return Promise { seal in
        DispatchQueue.global().async {
            
            let tx = contract!.buildCallMethod(method: method.rawValue, parameters: parameters,wallet: wallet!)
            do {
                // Depending on the type of call a password might be needed
                if password != nil {
                    let call = try tx!.send(password: password!)
                }else{
                    let call = try tx!.call()
                    print(call["0"])
                }
    
                seal.resolve(.fulfilled(true))
            }catch {
                print(error)
                seal.reject(error)
            }
        }
    }
    
    
}


