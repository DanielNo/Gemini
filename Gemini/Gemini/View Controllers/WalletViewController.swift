//
//  WalletViewController.swift
//  Gemini
//
//  Created by Daniel No on 6/22/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {
    @IBOutlet weak var balanceLabel: UILabel! {
        didSet{
         balanceLabel.text = self.wallet?.balance
        }
    }
    @IBOutlet weak var recipientAddressTextField: UITextField!
    @IBOutlet weak var sendAmountTextField: UITextField!
    var api : JobcoinAPI?
    private var wallet : Wallet? {
        didSet{
            balanceLabel.text = self.wallet?.balance
        }
    }
    private var walletAddress : String?
    
    convenience init(walletAddress : String, wallet : Wallet, api : JobcoinAPI) {
        self.init()
        self.wallet = wallet
        self.api = api
        self.walletAddress = walletAddress

    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        guard let myAddress = self.walletAddress, let toAddress = recipientAddressTextField.text, let amount = sendAmountTextField.text  else{
            return
        }
        
        if myAddress.count == 0 || toAddress.count == 0 || amount.count == 0 {
            let alert = UIAlertController(title: "Enter a valid Recipient Address and amount.", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        
        self.sendCoinTransaction(fromAddress: myAddress, toAddress: toAddress, amount: amount)
    }
    
}

extension WalletViewController{
    
    func sendCoinTransaction(fromAddress : String, toAddress : String, amount : String){
        
        self.api?.transactionSend(fromAddress: fromAddress, toAddress: toAddress, amount: amount) { [unowned self](response) in
            var alertMessage = ""
            if(response == ResponseCode.success){
                alertMessage = "Transaction successful!"
                self.api?.login(walletAddress: fromAddress, completion: { [unowned self](wallet, responseCode) in
                    self.refreshWallet(walletAddress: fromAddress)
                })
                
            }else{
                alertMessage = "Transaction failed!"
            }
            
            let alert = UIAlertController(title: alertMessage, message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    func refreshWallet(walletAddress : String){
        self.api?.login(walletAddress: walletAddress, completion: { [unowned self](wallet, responseCode) in
            print(responseCode)
            if (responseCode == ResponseCode.success){
                self.wallet = wallet
            }
        })
        
    }



}

