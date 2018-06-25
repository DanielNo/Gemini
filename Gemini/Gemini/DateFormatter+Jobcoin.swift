//
//  DateFormatter+Jobcoin.swift
//  Gemini
//
//  Created by Daniel No on 6/24/18.
//  Copyright © 2018 Daniel No. All rights reserved.
//

import Foundation

extension DateFormatter{

    //2018-06-21T16:18:48.231Z
    class func convertDateFormater(_ dateStr: String) -> Double
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let newDate = dateFormatter.date(from: dateStr)
        dateFormatter.dateFormat = "MM-dd"
        let formattedDate =  dateFormatter.string(from: newDate!)
        let dateComponents = formattedDate.components(separatedBy: "-")
        let month = dateComponents[0]
        let day = dateComponents[1]
        let shortDateStr = "\(month).\(day)"
//        let shortDateStr = "\(day)"
        let dateDouble = Double(shortDateStr)!.rounded(toPlaces: 2)
//        print(dateDouble)
        return dateDouble
    }


}
