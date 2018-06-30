//
//  HelperFunctions.swift
//  Games
//
//  Created by Dimash Bekzhan on 6/30/18.
//  Copyright © 2018 Dimash Bekzhan. All rights reserved.
//

import Foundation
import UIKit


func createAlert(withMessage message: String, action: (() -> Void)?) -> UIAlertController {
    let alert = UIAlertController(title: "Ooops", message: message, preferredStyle: .alert)
    var handler: ((UIAlertAction) -> Void)? = nil
    
    if let action = action {
        handler = { (_) -> Void in
            action()
        }
    }
  
    let action = UIAlertAction(title: "OK", style: .cancel, handler: handler)
    
    alert.addAction(action)
    return alert
}

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

func generateRandomNumber(withNumberOfDecimalPlaces places: Int) -> Int {
    var number = 0
    for power in 0..<places {
        let digit = Int(arc4random_uniform(9) + 1)
        number = number + digit * (10 ^^ power)
    }
    return number
}
