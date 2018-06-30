//
//  UIColor+extension.swift
//  Games
//
//  Created by Dimash Bekzhan on 6/29/18.
//  Copyright © 2018 Dimash Bekzhan. All rights reserved.
//

import UIKit
import Foundation

extension Color: RawRepresentable {
    typealias RawValue = UIColor
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.red: self = .red
        case UIColor.blue: self = .blue
        case UIColor.purple: self = .purple
        case UIColor.yellow: self = .yellow
        case UIColor.orange: self = .orange
        default: return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .red: return UIColor.red
        case .blue: return UIColor.blue
        case .purple: return UIColor.purple
        case .yellow: return UIColor.yellow
        case .orange: return UIColor.orange
        }
    }
}

enum Color {
    
    case red
    case blue
    case purple
    case yellow
    case orange
    
    static let cases = [red, blue, purple, yellow, orange]
}

extension UIColor {
    var name: String? {
        switch self {
        case UIColor.red: return "red"
        case UIColor.blue: return "blue"
        case UIColor.yellow: return "yellow"
        case UIColor.orange: return "orange"
        case UIColor.purple: return "purple"
        default: return nil
        }
    }
}
