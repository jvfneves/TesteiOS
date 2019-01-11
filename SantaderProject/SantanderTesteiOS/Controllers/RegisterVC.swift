//
//  RegisterVC.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 12/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import UIKit

class RegisterVC: ViewController {

    @IBOutlet weak var lbName: CustonLabel!
    @IBOutlet weak var tfName: CustomTextField!
    @IBOutlet weak var tfEmail: CustomTextField!
    @IBOutlet weak var tfPhone: MaskedCustomField!
    @IBOutlet weak var yesEmailIndicator: SquaredRadioView!
    @IBOutlet weak var lbCheck: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    
    var cellsMiniModel : [CellMiniModel] = []
    
    override func loadView() {
        super.loadView()
        
        self.loadProperty()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.loadProperty()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadProperty(){
        REST.loadCell(onCompleted: { (responseScreen) in
            self.cellsMiniModel = responseScreen?.cells ?? []
            print("responseScreen \(responseScreen)")
            DispatchQueue.main.async {
                self.setFieldsUI()
            }
        })
    }
    
    func setFieldsUI(){
        if self.cellsMiniModel.count == 0{
            return
        }
        
        //1º
        let cellOne = self.cellsMiniModel.first
        //self.lbName.topInset = CGFloat(cellOne?.topSpacing ?? 0)
        self.lbName.text = cellOne?.message ?? ""
        self.lbName.isHidden = cellOne?.hidden ?? false
        self.view.layoutIfNeeded()
        
        //2º
        if self.cellsMiniModel.indices.contains(1){
            let cellTwo = self.cellsMiniModel[1]
            self.tfName.placeholder = cellTwo.message ?? ""
            self.tfName.isHidden = cellTwo.hidden ?? false
        }
        //3º
        if self.cellsMiniModel.indices.contains(2){
            let cellThree = self.cellsMiniModel[2]
            self.tfEmail.placeholder = cellThree.message ?? ""
            self.tfEmail.isHidden = cellThree.hidden ?? false
        }
        
        //4º
        if self.cellsMiniModel.indices.contains(3){
            let cellFour = self.cellsMiniModel[3]
            self.tfPhone.placeholder = cellFour.message ?? ""
            self.tfPhone.isHidden = cellFour.hidden ?? false
        }
        
        //5º
        if self.cellsMiniModel.indices.contains(4){
            let cellFive = self.cellsMiniModel[4]
            self.lbCheck.text = cellFive.message ?? ""
        }
        
        //6º
        if self.cellsMiniModel.indices.contains(5){
            let cellSix = self.cellsMiniModel[5]
            self.btnSend.setTitle(cellSix.message ?? "", for: .normal)
        }
        
    }
    
    func validateFields() -> Bool{
        var result : Bool = true
        
        if self.cellsMiniModel.indices.contains(1){
            let cellTwo = self.cellsMiniModel[1]
            if let required = cellTwo.required, required{
                if self.tfName.text == nil || self.tfName.text?.trimmingCharacters(in: .whitespaces).count ?? 0 < 1{
                    self.tfName.showError("Nome inválido.")
                    result = false
                }
                else{
                    self.tfName.hideError()
                }
            }
        }
        
        if self.tfEmail.isHidden == false{
            let cellThree = self.cellsMiniModel[2]
            if let required = cellThree.required, required{
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
                            self.tfEmail.hideError()
                        }
                    }
                    else{
                        result = false
                    }
                }
            }
        }
        
        if self.cellsMiniModel.indices.contains(3){
            let cellFour = self.cellsMiniModel[3]
            if let required = cellFour.required, required{
                if self.tfPhone.text == nil || self.tfPhone.text?.trimmingCharacters(in: .whitespaces).count ?? 0 != 15{
                    self.tfPhone.showError("Telefone inválido.")
                    result = false
                }
                else{
                    self.tfPhone.hideError()
                }
            }
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

    @IBAction func actSend(_ sender: UIButton) {
        if self.validateFields(){
            let vc = UIStoryboard(name: STORYBOARDS.Main.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: IDENTIFIERS.registerMsgVC.rawValue) as! RegisterMsgVC
            vc.actOpenPage = {
                let nc = UIStoryboard(name: STORYBOARDS.Main.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: IDENTIFIERS.mainTBC.rawValue) as! MainTBC
                self.navigationController?.present(nc, animated: true, completion: nil)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
