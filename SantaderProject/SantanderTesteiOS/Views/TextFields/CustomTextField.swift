//
//  CustomTextField.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 11/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import UIKit
import Cartography
import AKMaskField

class CustomTextField: UITextField, CustomTextFieldProtocol {
    
    var label : UILabel!
    var borderBottom : UIView!
    var errorLabel : UILabel!
    
    // MARK: Corner Radius
    @IBInspectable open var cornerRadius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            if !self.isShadowEnabled {
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable open var isShadowEnabled : Bool = false {
        didSet {
            self.checkShadow()
        }
    }
    
    // MARK: Border
    @IBInspectable open var borderWith : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWith
        }
    }
    @IBInspectable open var borderColor : UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    // MARK: Border bottom
    @IBInspectable open var bottomBorderHeight : CGFloat = 1
    @IBInspectable open var isBottomBorderEnabled : Bool = true {
        didSet {
            borderBottom?.isHidden = !isBottomBorderEnabled
        }
    }
    
    // MARK: Label
    @IBInspectable open var isLabelEnabled : Bool = true {
        didSet {
            errorLabel?.isHidden = true
        }
    }
    
    // MARK: Text Padding
    var padding = UIEdgeInsets.zero
    @IBInspectable open var leftPadding : CGFloat = 0 {
        didSet {
            padding.left = leftPadding
        }
    }
    @IBInspectable open var rightPadding : CGFloat = 0 {
        didSet {
            padding.right = rightPadding
        }
    }
    
    override func awakeFromNib() {
        self.label = UILabel()
        self.borderBottom = UIView()
        self.errorLabel = UILabel()
        
        super.awakeFromNib()
        
        self.initViews()
        self.setupConstraints()
        
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        guard self.isLabelEnabled else { return }
        
        let isEmpty = textField.text?.isEmpty ?? true
        if isEmpty && !self.label.isHidden {
            UIView.animate(withDuration: 0.3, animations: {
                self.label.transform = CGAffineTransform(scaleX: 1, y: 0)
            }) { _ in
                self.label.isHidden = true
                self.label.transform = CGAffineTransform.identity
            }
        } else if !isEmpty && self.label.isHidden {
            self.label.transform = CGAffineTransform(scaleX: 1, y: 0)
            self.label.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.label.transform = CGAffineTransform.identity
            })
        }
    }
    
    func initViews() {
        // MARK: TextField
        self.checkShadow()
        if let placeH = self.placeholder {
            self.attributedPlaceholder = NSAttributedString(string: placeH, attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        }
        
        // MARK: Label
        self.label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.label.text = self.placeholder
        self.label.textAlignment = .left
        self.label.textColor = self.textColor
        self.label.isHidden = true
        
        // MARK: Border bottom
        self.borderBottom.backgroundColor = self.borderColor ?? self.tintColor ?? self.textColor ?? UIColor.black
        self.borderBottom.isHidden = !isBottomBorderEnabled
        
        // MARK: Error label
        self.errorLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.errorLabel.textAlignment = .left
        self.errorLabel.textColor = #colorLiteral(red: 0.937254902, green: 0.3254901961, blue: 0.3137254902, alpha: 1)
        self.errorLabel.isHidden = true
        
        self.addSubview(self.label)
        self.addSubview(self.borderBottom)
        self.addSubview(self.errorLabel)
    }
    
    func setupConstraints() {
        constrain(label, self) { label, view in
            label.height == 20
            label.left == view.left
            label.trailing == view.trailing
            label.top == view.top - 8
        }
        constrain(borderBottom, self) { imageView, view in
            imageView.height == bottomBorderHeight
            imageView.left == view.left
            imageView.trailing == view.trailing
            imageView.bottom == view.bottom
        }
        constrain(errorLabel, self) { label, view in
            label.height == 20
            label.left == view.left
            label.trailing == view.trailing
            label.bottom == view.bottom + 20
        }
    }
    
    // MARK: Error label methods
    func showError(_ message: String){
        self.errorLabel.text = message
        self.errorLabel.isHidden = false
        self.borderBottom.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.3254901961, blue: 0.3137254902, alpha: 1)
    }
    func hideError() {
        self.errorLabel.isHidden = true
        self.borderBottom.backgroundColor = self.borderColor ?? self.tintColor ?? UIColor.black
    }
    
    private func checkShadow(){
        if self.isShadowEnabled {
            self.dropShadow(opacity: 0.1, radius: 1, offSetWidth: 3, offSetHeight: 3)
        } else {
            self.removeShadow()
        }
    }
    
    public func setText(_ text: String?) {
        self.text = text
        self.textFieldDidChange(self)
    }
    
}
