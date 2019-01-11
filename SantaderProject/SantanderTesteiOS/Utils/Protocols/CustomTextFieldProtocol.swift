//
//  CustomTextFieldProtocol.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 11/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import Foundation
import UIKit

//MARK : Usado para customizar alguns comonetes de layout
protocol CustomTextFieldProtocol: class, ProgrammableUIProtocol {
    var label : UILabel! {get set}
    var borderBottom : UIView! {get set}
    var errorLabel : UILabel! {get set}
    
    func showError(_ message: String)
    func hideError()
}
extension CustomTextFieldProtocol where Self: UITextField { }
