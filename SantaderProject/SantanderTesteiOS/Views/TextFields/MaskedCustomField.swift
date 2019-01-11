//
//  MaskedCustomField.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 12/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import UIKit
import AKMaskField
import Cartography

class MaskedCustomField: AKMaskField, CustomTextFieldProtocol {
    
    var label : UILabel!
    var borderBottom : UIView!
    var errorLabel : UILabel!
    
    var didEditing: ((String?) -> Void)?
    
    // MARK: Label
    @IBInspectable open var isLabelEnabled : Bool = true {
        didSet {
            errorLabel?.isHidden = !self.isLabelEnabled
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.label = UILabel()
        self.borderBottom = UIView()
        self.errorLabel = UILabel()
        
        self.initViews()
        self.setupConstraints()
        
        self.maskDelegate = self
        //self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        if !self.isLabelEnabled { return }
        
        if (textField.text?.count ?? 0) <= 0 && !self.label.isHidden {
            UIView.animate(withDuration: 0.5, animations: { self.label.isHidden = true })
        } else if (textField.text?.count ?? 0) > 0 && self.label.isHidden {
            UIView.animate(withDuration: 0.5, animations: { self.label.isHidden = false })
        }
    }
    
    func initViews() {
        if let placeH = self.placeholder {
            self.attributedPlaceholder = NSAttributedString(string: placeH, attributes: [NSAttributedStringKey.foregroundColor: self.textColor ?? UIColor.lightGray])
        }
        
        self.label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.label.text = self.placeholder
        self.label.textAlignment = .left
        self.label.textColor = self.textColor
        self.label.isHidden = true
        
        self.borderBottom.backgroundColor = self.tintColor ?? self.textColor ?? UIColor.black
        
        self.errorLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.errorLabel.textAlignment = .left
        self.errorLabel.textColor = #colorLiteral(red: 0.937254902, green: 0.3254901961, blue: 0.3137254902, alpha: 1)
        self.errorLabel.isHidden = !self.isLabelEnabled
        
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
            imageView.height == 1
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
    
    func showError(_ message: String){
        self.errorLabel.text = message
        self.errorLabel.isHidden = false
        self.borderBottom.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.3254901961, blue: 0.3137254902, alpha: 1)
    }
    func hideError() {
        self.errorLabel.isHidden = true
        self.borderBottom.backgroundColor = self.tintColor ?? self.textColor ?? UIColor.black
    }
    
    public func setText(_ text: String?) {
        self.text = text
        self.textFieldDidChange(self)
    }
}

extension MaskedCustomField: AKMaskFieldDelegate {
    func maskField(_ maskField: AKMaskField, didChangedWithEvent event: AKMaskFieldEvent) {
        if event != AKMaskFieldEvent.error {
            self.didEditing?(maskField.text)
            if !self.isLabelEnabled { return }
            if (maskField.text?.count ?? 0) <= 0 && !self.label.isHidden {
                UIView.animate(withDuration: 0.5, animations: { self.label.isHidden = true })
            } else if (maskField.text?.count ?? 0) > 0 && self.label.isHidden {
                UIView.animate(withDuration: 0.5, animations: { self.label.isHidden = false })
            }
        }
    }
}
