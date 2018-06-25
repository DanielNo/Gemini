//
//  JobcoinAPI.swift
//  Gemini
//
//  Created by Daniel No on 6/21/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import Foundation
import Alamofire

public enum ResponseCode : Int{
    case success = 200
    case notFound = 404
    case sendFailure = 422
}

public class JobcoinAPI{
    
    func login(walletAddress : String, completion: @escaping (Wallet?, ResponseCode) -> ()){
        Alamofire.request(JobcoinUrlRequest.login(walletAddress: walletAddress)).responseJSON(completionHandler: { (data) in
            
            guard let statusCode = data.response?.statusCode else{
                return
            }
            guard let responseCode = ResponseCode(rawValue: statusCode) else{
                return
            }
            if let jsonData = data.data{
                do{
                    var wallet = try JSONDecoder().decode(Wallet.self, from: jsonData)
                    wallet.address = walletAddress
                    try wallet.createBalanceHistory()
                    completion(wallet, responseCode)
                }catch{
                    completion(nil, responseCode)
                    print(error.localizedDescription)
                }
            }
        })
        
        
        
    }
    
    func transactionViewAll(){
        Alamofire.request(JobcoinUrlRequest.transactionViewAll()).responseJSON { (data) in
            print(data)
            print(data.response?.statusCode)
        }

    }
    
    func transactionSend(fromAddress : String, toAddress : String, amount : String, completion: @escaping (ResponseCode) -> ()){
        Alamofire.request(JobcoinUrlRequest.transactionSend(fromAddress: fromAddress, toAddress: toAddress, amount: amount)).responseJSON { (data) in
            print(data)
            print(data.response?.statusCode)
            guard let statusCode = data.response?.statusCode else{
                return
            }
            guard let responseCode = ResponseCode(rawValue: statusCode) else{
                return
            }

            completion(responseCode)
        }

    }
    

    
    

}
