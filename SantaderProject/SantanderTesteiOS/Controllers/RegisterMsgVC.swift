//
//  RegisterMsgVC.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 12/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import UIKit

class RegisterMsgVC: ViewController {
    
    var actOpenPage : (()->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actClosePage(_ sender: UIBarButtonItem) {
        self.actOpenPage?()
        self.closePopNavigation()
    }
    
}
