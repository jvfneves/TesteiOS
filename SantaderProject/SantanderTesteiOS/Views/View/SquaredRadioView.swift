//
//  SquaredRadioView.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 11/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import UIKit
import Cartography

class SquaredRadioView: UIView, ProgrammableUIProtocol {
    
    let selectedView : UIView
    
    @IBInspectable open var isSelected : Bool = false {
        didSet {
            self.selectedView.isHidden = !isSelected
        }
    }
    @IBInspectable open var selectionColor : UIColor? {
        didSet {
            self.selectedView.backgroundColor = selectionColor
        }
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        initViews()
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        self.selectedView = UIView()
        super.init(frame: frame)
        initViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.selectedView = UIView()
        super.init(coder: aDecoder)
        initViews()
        setupConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        selectedView.layer.cornerRadius = (self.bounds.height - 8) / 2
//        layer.cornerRadius = self.bounds.height / 2
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
//        selectedView.layer.cornerRadius = (self.bounds.height - 8) / 2
//        layer.cornerRadius = self.bounds.height / 2
    }
    
    func initViews() {
        self.layer.cornerRadius = 3
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        
        self.selectedView.layer.cornerRadius = 3
        self.selectedView.backgroundColor = self.selectionColor
        self.selectedView.isHidden = !self.isSelected
        self.addSubview(self.selectedView)
    }
    
    func setupConstraints() {
        constrain(self.selectedView, self) { selection, view in
            selection.height == view.height - 8
            selection.width == view.width - 8
            selection.center == view.center
        }
    }
}
