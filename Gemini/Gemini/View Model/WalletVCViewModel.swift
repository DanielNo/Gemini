//
//  WalletVCViewModel.swift
//  Gemini
//
//  Created by Daniel No on 6/23/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import Foundation
import RxSwift

public class WalletVCViewModel{
    let api : JobcoinAPI
    let address : String
    let wallet: Variable<Wallet>

    init(jobcoinAPI : JobcoinAPI, address : String, wallet : Wallet) {
        self.api = jobcoinAPI
        self.address = address
        self.wallet = Variable(wallet)
    }
    
    
    
    func sendCoinTransaction(fromAddress : String, toAddress : String, amount : String){
        
        self.api.transactionSend(fromAddress: fromAddress, toAddress: toAddress, amount: amount) { [unowned self](response) in
            print("Send Transaction : \(response)")
            if(response == ResponseCode.success){
                self.api.login(walletAddress: fromAddress, completion: { [unowned self](wallet, responseCode) in
                    self.refreshWallet(walletAddress: fromAddress)
                })
            }
            
        }
        
    }
    
    func refreshWallet(walletAddress : String){
        self.api.login(walletAddress: walletAddress, completion: { [unowned self](wallet, responseCode) in
            print("Load Wallet : \(responseCode)")
            if (responseCode == ResponseCode.success){
                guard let newWallet = wallet else{
                 return
                }
                
                self.wallet.value = newWallet
            }
        })
        
    }



}
