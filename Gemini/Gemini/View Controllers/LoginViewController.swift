//
//  LoginViewController.swift
//  Gemini
//
//  Created by Daniel No on 6/21/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var walletAddressTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInWallet(_ sender: Any) {
        let address = walletAddressTextField.text!
        print("sign in \(address)")
        let api = JobcoinAPI()
        api.login(walletAdddress: walletAddressTextField.text!)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
