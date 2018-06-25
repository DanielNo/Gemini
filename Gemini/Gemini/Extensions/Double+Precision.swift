//
//  Double+Precision.swift
//  Gemini
//
//  Created by Daniel No on 6/24/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import Foundation
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

