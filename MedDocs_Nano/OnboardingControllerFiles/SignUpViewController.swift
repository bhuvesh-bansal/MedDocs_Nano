//
//  SignUpViewController.swift
//  MedDocs_Nano
//
//  Created by TANISHQ on 20/01/25.
//
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var EmailIdTextField: UITextField!
    @IBOutlet weak var CreatePasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    @IBOutlet weak var buttonSignUp: UIButton!
    @IBOutlet weak var ContinueWithGoogle: UIButton!
    @IBOutlet weak var ContinueWithApple: UIButton!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmailIdTextField.delegate = self
        CreatePasswordTextField.delegate = self
        //ConfirmPasswordTextField = self
        
        buttonSignUp.layer.cornerRadius = 12.0
        ContinueWithGoogle.layer.cornerRadius = 12.0
        ContinueWithApple.layer.cornerRadius = 12.0
        
    }
    
    
    @IBAction func SignUpButtonTapped(_ sender: Any) {
        
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
