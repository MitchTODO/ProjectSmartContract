//
//  ContractCompoents.swift
//  web3Interaction
//
//  Created by Mitchell Tucker on 5/14/21.
//

import Foundation

// Methods available within the contract
enum ContractMethods:String {

    case projectContract = "projectContent"
    case setContract = "setContract"
    case getProjectTitle = "getProjectTitle"
    case getPorjectLocation = "getProjectLocation"
    case getProjectStart = "getProjectStart"
    case getProjectEnd = "getProjectEnd"
    case getTeamType = "getTeamType"
}

let contractAddress = "0x5252647831C9a95c44Fdf95382612A336234c0aD"

let contractABI =
    """
    [ {"constant": true,
          "inputs": [],
          "name": "projectEnd",
          "outputs": [
            {
              "internalType": "string",
              "name": "",
              "type": "string"
            }
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "projectLocation",
          "outputs": [
            {
              "internalType": "string",
              "name": "",
              "type": "string"
            }
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "projectStart",
          "outputs": [
            {
              "internalType": "string",
              "name": "",
              "type": "string"
            }
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "projectTitle",
          "outputs": [
            {
              "internalType": "string",
              "name": "",
              "type": "string"
            }
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "teamType",
          "outputs": [
            {
              "internalType": "string",
              "name": "",
              "type": "string"
            }
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "internalType": "string",
              "name": "initialProjectTitle",
              "type": "string"
            },
            {
              "internalType": "string",
              "name": "initialProjectLocation",
              "type": "string"
            },
            {
              "internalType": "string",
              "name": "initialProjectStart",
              "type": "string"
            },
            {
              "internalType": "string",
              "name": "initialProjectEnd",
              "type": "string"
            },
            {
              "internalType": "string",
              "name": "initialTeamType",
              "type": "string"
            }
          ],
          "name": "projectContent",
          "outputs": [],
          "payable": false,
          "stateMutability": "nonpayable",
          "type": "function"
        },
        {
          "constant": false,
          "inputs": [
            {
              "internalType": "string",
              "name": "newProjectTitle",
              "type": "string"
            },
            {
              "internalType": "string",
              "name": "newProjectLocation",
              "type": "string"
            },
            {
              "internalType": "string",
              "name": "newProjectStart",
              "type": "string"
            },
            {
              "internalType": "string",
              "name": "newProjectEnd",
              "type": "string"
            },
            {
              "internalType": "string",
              "name": "newTeamType",
              "type": "string"
            }
          ],
          "name": "setContract",
          "outputs": [],
          "payable": false,
          "stateMutability": "nonpayable",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "getProjectTitle",
          "outputs": [
            {
              "internalType": "string",
              "name": "",
              "type": "string"
            }
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "getProjectLocation",
          "outputs": [
            {
              "internalType": "string",
              "name": "",
              "type": "string"
            }
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "getProjectStart",
          "outputs": [
            {
              "internalType": "string",
              "name": "",
              "type": "string"
            }
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "getProjectEnd",
          "outputs": [
            {
              "internalType": "string",
              "name": "",
              "type": "string"
            }
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        },
        {
          "constant": true,
          "inputs": [],
          "name": "getTeamType",
          "outputs": [
            {
              "internalType": "string",
              "name": "",
              "type": "string"
            }
          ],
          "payable": false,
          "stateMutability": "view",
          "type": "function"
        }
      ]
"""
