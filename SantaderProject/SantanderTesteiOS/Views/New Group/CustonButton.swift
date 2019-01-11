//
//  CustonButton.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 12/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {

    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? #colorLiteral(red: 0.9215686275, green: 0.462745098, blue: 0.462745098, alpha: 1) : #colorLiteral(red: 0.862745098, green: 0.09411764706, blue: 0.003921568627, alpha: 1)
        }
    }

}
