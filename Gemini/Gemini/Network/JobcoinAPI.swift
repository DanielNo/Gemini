//
//  JobcoinAPI.swift
//  Gemini
//
//  Created by Daniel No on 6/21/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import Foundation
import Alamofire


public class JobcoinAPI{
    
    func login(walletAdddress : String){
        Alamofire.request(JobcoinUrlRequest.login(walletAddress: walletAdddress)).responseJSON { (data) in
            print(data)
            print(data.response?.statusCode)
        }
        
    }
    
    func transactionViewAll(){
        Alamofire.request(JobcoinUrlRequest.transactionViewAll()).responseJSON { (data) in
            print(data)
            print(data.response?.statusCode)
        }

    }
    
    func transactionSend(){
        Alamofire.request(JobcoinUrlRequest.transactionSend(fromAddress: "test1", toAddress: "test2", amount: "1")).responseJSON { (data) in
            print(data)
            print(data.response?.statusCode)
        }

    }


}
