//
//  ContactVC.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 11/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import UIKit

class ContactVC: ViewController {

    @IBOutlet weak var tfNameFull: CustomTextField!
    @IBOutlet weak var tfEmail: CustomTextField!
    @IBOutlet weak var tfPhone: MaskedCustomField!
    @IBOutlet weak var yesEmailIndicator: SquaredRadioView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateFields() -> Bool{
        var result : Bool = true
        
        if self.tfNameFull.text == nil || self.tfNameFull.text?.trimmingCharacters(in: .whitespaces).count ?? 0 < 1{
            self.tfNameFull.showError("Nome inválido.")
            result = false
        }
        else{
            //self.profileFull.phone = self.tfCelular.text
            self.tfNameFull.hideError()
        }
        
        if self.tfEmail.isHidden == false{
            if self.tfEmail.text == nil || self.tfEmail.text?.trimmingCharacters(in: .whitespaces).count ?? 0 < 6{
                self.tfEmail.showError("Mínimo 6 caracteres.")
                result = false
            }
            else{
                if let email = self.tfEmail.text{
                    if !self.validateEmail(email){
                        self.tfEmail.showError("Email inválido.")
                        result = false
                    }
                    else{
                        //self.profileFull.email = email
                        self.tfEmail.hideError()
                    }
                }
                else{
                    result = false
                }
            }
        }
        
        if self.tfPhone.text == nil || self.tfPhone.text?.trimmingCharacters(in: .whitespaces).count ?? 0 != 15{
            self.tfPhone.showError("Telefone inválido.")
            result = false
        }
        else{
            //self.profileFull.phone = self.tfCelular.text
            self.tfPhone.hideError()
        }
        
        return result
    }
    
    @IBAction func switchEmailAction(_ sender: Any) {
        self.yesEmailIndicator.isSelected = !self.yesEmailIndicator.isSelected
        if !self.yesEmailIndicator.isSelected {
            self.tfEmail.isHidden = true
        } else {
            self.tfEmail.isHidden = false
        }
    }
    
    @IBAction func actSendContact(_ sender: UIButton) {
        if self.validateFields(){
            //MARK : Troca de tela
            let vc = UIStoryboard(name: STORYBOARDS.Main.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: IDENTIFIERS.modalContactVC.rawValue) as! ModalContactVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
