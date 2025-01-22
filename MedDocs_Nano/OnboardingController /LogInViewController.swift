import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        emailTextField.delegate = self
        passwordTextField.delegate = self

        
        //loginButton.isEnabled = false

        
        emailTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//       
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @objc func textFieldsDidChange() {
       
        if let email = emailTextField.text, let password = passwordTextField.text,
           isValidEmail(email), isValidPassword(password) {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.systemBlue // Highlight enabled button
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(red: 0.0/255.0, green: 170.0/255.0, blue: 185.0/255.0, alpha: 1.0)
            loginButton.titleLabel?.textColor = .white
            loginButton.layer.cornerRadius = 8.0

 
        }
    }

    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

   
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text, let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            if textField == emailTextField {
                return !updatedText.contains(" ") // No spaces allowed in email
            }
            if textField == passwordTextField {
                return !updatedText.contains(" ") // No spaces allowed in password
            }
        }
        return true
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            print("Email: \(email), Password: \(password)")
            // Navigate to the next page (to be implemented later)
            navigateToNextPage()
        }
    }

    func navigateToNextPage() {
        // Add your segue or navigation logic here
        // Example:
        // let nextViewController = storyboard?.instantiateViewController(identifier: "NextViewController") as! NextViewController
        // navigationController?.pushViewController(nextViewController, animated: true)
    }
}

