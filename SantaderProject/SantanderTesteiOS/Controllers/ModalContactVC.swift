//
//  ModalContactVC.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 11/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import UIKit

class ModalContactVC: ViewController {

    @IBOutlet weak var lbNewMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindUI(){
        //MARK : GESTURES
        self.lbNewMsg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actCloseModal)))
    }
    
    @objc func actCloseModal(){
        self.closePopNavigation()
    }

}
