//
//  Pencil.swift
//  Paint
//
//  Created by Denis Abramov on 16.04.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import Foundation
import UIKit

enum Pencil {
    case black
    case grey
    case red
    case darkBlue
    case lightBlue
    case darkGreen
    case lightGreen
    case brown
    case orange
    case yellow
    case eraser
    
    init?(tag: Int) {
        switch tag {
        case 1:
            self = .black
        case 2:
            self = .grey
        case 3:
            self = .red
        case 4:
            self = .darkBlue
        case 5:
            self = .lightBlue
        case 6:
            self = .darkGreen
        case 7:
            self = .lightGreen
        case 8:
            self = .brown
        case 9:
            self = .orange
        case 10:
            self = .yellow
        case 11:
            self = .eraser
        default:
            return nil
        }
    }
    
    var color: UIColor {
        switch self {
        case .black:
            return .black
        case .grey:
            return UIColor(white: 105.0 / 255.0, alpha: 1.0)
        case .red:
            return UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        case .darkBlue:
            return UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        case .lightBlue:
            return UIColor(red: 51.0 / 255.0, green: 204.0 / 255.0, blue: 1.0, alpha: 1.0)
        case .darkGreen:
            return UIColor(red: 102.0 / 255.0, green: 204.0 / 255.0, blue: 0.0, alpha: 1.0)
        case .lightGreen:
            return UIColor(red: 102.0 / 255.0, green: 1.0, blue: 0.0, alpha: 1.0)
        case .brown:
            return UIColor(red: 160.0 / 255.0, green: 82.0 / 255.0, blue: 45.0 / 255.0, alpha: 1.0)
        case .orange:
            return UIColor(red: 1.0, green: 102.0 / 255.0, blue: 0.0, alpha: 1.0)
        case .yellow:
            return UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        case .eraser:
            return .white
        }
    }
}
