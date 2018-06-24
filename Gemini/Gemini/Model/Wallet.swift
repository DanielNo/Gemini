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
    
    
    private enum CodingKeys: CodingKey {
        case balance
        case transactions
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        balance = Variable<String>(try values.decode(String.self, forKey: CodingKeys.balance))
        transactions = Variable<[Transaction]>(try values.decode([Transaction].self, forKey: CodingKeys.transactions))

    }

}
