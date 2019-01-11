//
//  ViewController.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 11/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationClean()
    }
    
    func hideErrors(_ fields:[UITextField]) {
        for field in fields {
            if let custonField = field as? CustomTextFieldProtocol {
                custonField.hideError()
            }
        }
    }
    
    func openNavegador(_url : String){
        if _url == ""{
            return
        }
        let url = URL(string: _url)!
        if UIApplication.shared.canOpenURL(url) {
            //verifica se o ios é de 10 para cima senao cai no else
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
            //If you want handle the completion block than
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                    print("Open url : \(success)")
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func validateEmail(_ enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    func navigationWhite(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        //UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        self.navigationController?.view.backgroundColor = UIColor.white
    }
    
    func navigationClean(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.view.backgroundColor = .clear
        //UIApplication.shared.statusBarView?.backgroundColor = .clear
    }
    
    func closePopNavigation(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func closeDismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
