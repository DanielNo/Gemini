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
    
    func login(walletAdddress : String, completion: @escaping (WalletInfo?, ResponseCode) -> ()){
        Alamofire.request(JobcoinUrlRequest.login(walletAddress: walletAdddress)).responseJSON(completionHandler: { (data) in
            
            guard let statusCode = data.response?.statusCode else{
                return
            }
            guard let responseCode = ResponseCode(rawValue: statusCode) else{
                return
            }
            let error = data.error
//            print(error)
//            print(data.response?.statusCode)
//            print(data.result)
            if let jsonData = data.data{
                do{
                    let accInfo = try JSONDecoder().decode(WalletInfo.self, from: jsonData)
                    completion(accInfo, responseCode)
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
    
    // 200 = success
    // 422 = fail
    func transactionSend(){
        Alamofire.request(JobcoinUrlRequest.transactionSend(fromAddress: "test1", toAddress: "test2", amount: "1")).responseJSON { (data) in
            print(data)
            print(data.response?.statusCode)
        }

    }


}
