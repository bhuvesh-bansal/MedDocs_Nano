//
//  LogInViewController.swift
//  MedDocs_Nano
//
//  Created by TANISHQ on 20/01/25.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var textFieldEmailId: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonLoginIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textFieldEmailId.delegate = self
        textFieldPassword.delegate = self
        
        
        buttonLoginIn.layer.cornerRadius = 12.0
        
        
        
        
        
        

    }
    
    @IBAction func buttonLoginInTapped(_ sender: Any) {
    }
    
    

}
