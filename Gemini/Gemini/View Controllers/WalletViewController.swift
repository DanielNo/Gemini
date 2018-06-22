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
         balanceLabel.text = self.walletInfo?.balance
        }
    }
    @IBOutlet weak var recipientAddressTextField: UITextField!
    @IBOutlet weak var sendAmountTextField: UITextField!
    var walletInfo : WalletInfo? {
        didSet{
            balanceLabel.text = self.walletInfo?.balance
        }
    }
    
    convenience init(walletInfo : WalletInfo?) {
        self.init()
        self.walletInfo = walletInfo
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
