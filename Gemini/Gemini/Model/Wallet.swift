//
//  Wallet.swift
//  Gemini
//
//  Created by Daniel No on 6/22/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import Foundation

public struct Wallet : Decodable{
    let balance : String
    let transactions : [Transaction]
    
}
