//
//  LoginViewController.swift
//  Gemini
//
//  Created by Daniel No on 6/21/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var walletAddressTextField: UITextField!
    var viewModel : LoginVCViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    convenience init(viewModel : LoginVCViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    @IBAction func signInWallet(_ sender: Any) {
        let address = walletAddressTextField.text!
        print("sign in \(address)")
        self.viewModel?.api.login(walletAddress: address) { [unowned self](wallet,responseCode) in
            print(responseCode)
            if (responseCode == ResponseCode.success){
                guard let loggedInWallet = wallet else{
                    return
                }
                let walletViewModel = WalletVCViewModel(jobcoinAPI: self.viewModel.api, wallet: loggedInWallet)
                let walletVC = WalletViewController(viewModel: walletViewModel)
                self.navigationItem.title = "Logout"
                self.navigationController?.pushViewController(walletVC, animated: true)
            }
            
        }

    }
    

}
