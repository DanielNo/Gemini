//
//  Wallet.swift
//  Gemini
//
//  Created by Daniel No on 6/22/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import Foundation
import RxSwift

public struct Wallet : Decodable{
    let balance : Variable<String>
    let transactions : Variable<[Transaction]>
    var balanceHistory : [Double] = [Double]()
    var address : String = ""
    
    private enum CodingKeys: CodingKey {
        case balance
        case transactions
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        balance = Variable<String>(try values.decode(String.self, forKey: CodingKeys.balance))
        let sortedTransactions =  (try values.decode([Transaction].self, forKey: CodingKeys.transactions)).sorted { (a, b) -> Bool in
            return a.timestamp < b.timestamp
        }
        transactions = Variable<[Transaction]>(sortedTransactions)
    }
    
    mutating func createBalanceHistory() throws{
        guard let initialBalance = transactions.value.first?.amount else{
            throw DecodeError.noInitialBalance
        }
        
        guard var castedBalance = Double(initialBalance) else{
            throw DecodeError.invalidBalance
        }
        
        var balanceHistoryData = [0.0,castedBalance]
        for transaction in transactions.value {
            guard let transactionAmount = Double(transaction.amount) else{
                throw DecodeError.noInitialBalance
            }
            if transaction.fromAddress != nil{
                let balanceChange = transaction.fromAddress == self.address ? -(transactionAmount) : transactionAmount
                castedBalance = castedBalance + balanceChange
                balanceHistoryData.append(castedBalance)
            }
        }
        self.balanceHistory = balanceHistoryData
    }
    
    
    
    public enum DecodeError : Error{
        case noInitialBalance
        case invalidBalance
        case invalidTransaction
    }

}
