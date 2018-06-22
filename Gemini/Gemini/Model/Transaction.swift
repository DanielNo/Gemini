//
//  Transaction.swift
//  Gemini
//
//  Created by Daniel No on 6/21/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import Foundation

public struct Transaction : Decodable{
    let timestamp : String
    let fromAddress : String?
    let toAddress : String
    let amount : String


}
