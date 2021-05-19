//
//  ViewController.swift
//  web3Interaction
//
//  Created by Mitchell Tucker on 5/14/21.
//

import UIKit
import web3swift
import PromiseKit


var contract:ProjectContract?

var web3:web3?
var network:Network = .ganache
var wallet:Wallet?
var password = "" // leave empty string for ganache


class ViewController: UIViewController {
    // Mock data used within contract
     let projectTitle = "HouseSiding"
     let projectLocation = "299 Race Ave. Dacula, GA 30019"
     let projectStart = "May 14, 2021"
     let projectEnd = "June 15, 2021"
     let teamType = "Collaboration"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create wallet using either a private key or mnemonic
        wallet = getWallet(password: password, privateKey: "5c742b7bed0e8e5d8a70a0c4da61eea49f816904167bae09833e25035b46da55", walletName:"GanacheWallet")
        // Create contract with wallet as the sender
        contract = ProjectContract(wallet: wallet!)
        // Call contract method
        createNewProject()

    }
    
    func createNewProject() {
        let parameters = [projectTitle,projectLocation,projectStart,projectEnd,teamType] as [AnyObject]
        firstly {
            // Call contract method
            callContractMethod(method: .projectContract, parameters: parameters,password: "")
        }.done { response in
            // print out response
            print("createNewProject response \(response)")
            // Call out get projectTitle
            self.getProjectTitle()
        }
    }
    
    func getProjectTitle() {
        let parameters = [] as [AnyObject]
        firstly {
            // Call contract method
            callContractMethod(method: .getProjectTitle, parameters: parameters,password: nil)
        }.done { response in
            // print out response
            print("getProjectTitle response \(response)")
        }
    }
}

