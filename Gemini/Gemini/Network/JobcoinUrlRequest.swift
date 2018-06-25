//
//  JobcoinUrlRequest.swift
//  Gemini
//
//  Created by Daniel No on 6/21/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum JobcoinDomain{
    static let testEnv = "http://jobcoin.gemini.com/plenty/api/"
    
}

public enum JobcoinUrlRequest : URLRequestConvertible {
    case login(walletAddress : String)
    case transactionViewAll()
    case transactionSend(fromAddress : String, toAddress : String, amount : String)

    var baseUrl : String{
        switch self {
        case .login:
            return JobcoinDomain.testEnv
        case .transactionViewAll:
            return JobcoinDomain.testEnv
        case .transactionSend:
            return JobcoinDomain.testEnv
        }
    }
    
    var method: HTTPMethod
    {
        switch self {
        case .login:
            return .get
        case .transactionViewAll:
            return .get
        case .transactionSend:
            return .post
        }
    }
    
    var path: String
    {
        switch self {
        case .login(walletAddress : let walletAddress):
            return "addresses/\(walletAddress)"
        case .transactionViewAll():
            return "transactions"
        case .transactionSend(_ , _, _):
            return "transactions"
        }
    }

    
    public func asURLRequest() throws -> URLRequest{
        let urlstr = baseUrl + path
        guard let url = try? urlstr.asURL() else{
            throw RequestError.invalidURL
        }
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = self.method.rawValue
        urlReq.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        switch self {
        case .transactionSend(let fromAddress, let toAddress, let amount):
            let parameters = ["fromAddress" : fromAddress, "toAddress" : toAddress, "amount" : amount]
            
            guard let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else{
                throw RequestError.invalidBodyParameters
            }
            urlReq.httpBody = data
        default :
            break
        }
        print(urlReq)
        return urlReq

        
    }

    enum RequestError : Error{
        case invalidURL
        case invalidBodyParameters
    }


}
