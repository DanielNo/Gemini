//
//  WalletViewController.swift
//  Gemini
//
//  Created by Daniel No on 6/22/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftChart

class WalletViewController: UIViewController {
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var recipientAddressTextField: UITextField!
    @IBOutlet weak var sendAmountTextField: UITextField!
    @IBOutlet weak var balanceChart: Chart!
    
    let disposeBag = DisposeBag()
    var viewModel : WalletVCViewModel!

    
    convenience init(viewModel : WalletVCViewModel) {
        self.init()
        self.viewModel = viewModel
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindUserInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        guard let myAddress = self.viewModel?.wallet.value.address, let toAddress = recipientAddressTextField.text, let amount = sendAmountTextField.text  else{
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
    func bindUserInterface(){
        self.viewModel?.wallet
            .asObservable()
            .map { $0 }
            .bind(onNext: { (wallet) in
                self.balanceLabel.text = wallet.balance.value
                self.navigationItem.title = "Wallet : \(wallet.address)"
                self.loadBalanceChart(fromWallet: wallet)
            })
            .disposed(by:self.disposeBag)
    }
    
    func loadBalanceChart(fromWallet : Wallet?){
        guard let wallet = fromWallet else{
            return
        }
        self.balanceChart.removeAllSeries()
        var chartData = [Double]()
        for balance in wallet.balanceHistory{
            chartData.append(balance)
        }
        let series = ChartSeries(chartData)
        series.color = ChartColors.blueColor()
        series.area = true
        balanceChart?.add(series)
    }
}

extension WalletViewController{
    
    func sendCoinTransaction(fromAddress : String, toAddress : String, amount : String){

        self.viewModel?.api.transactionSend(fromAddress: fromAddress, toAddress: toAddress, amount: amount) { [unowned self](response) in
            var alertMessage = ""
            if(response == ResponseCode.success){
                alertMessage = "Transaction successful!"
                self.viewModel?.refreshWallet(walletAddress: fromAddress)

            }else{
                alertMessage = "Transaction failed!"
            }
            let alert = UIAlertController(title: alertMessage, message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }



}

