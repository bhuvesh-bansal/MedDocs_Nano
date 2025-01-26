
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!



        // MARK: - Properties
        private let userManager = UserManager.shared
        
        // MARK: - Lifecycle Methods
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupTextFieldTargets()
        }
        
        // MARK: - UI Setup
        private func setupUI() {
            // Configure text fields
            emailTextField.delegate = self
            passwordTextField.delegate = self
            confirmPasswordTextField.delegate = self
            
            passwordTextField.isSecureTextEntry = true
            confirmPasswordTextField.isSecureTextEntry = true
            
            // Configure sign up button
            signUpButton.backgroundColor = UIColor(red: 0.0/255.0, green: 175.0/255.0, blue: 185.0/255.0, alpha: 1.0)
            signUpButton.setTitleColor(.white, for: .normal)
            signUpButton.layer.cornerRadius = 8.0
            signUpButton.isEnabled = false
        }
        
        private func setupTextFieldTargets() {
            emailTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
            passwordTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
            confirmPasswordTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        }
        
        // MARK: - Text Field Validation
        @objc private func textFieldsDidChange() {
            if let email = emailTextField.text,
               let password = passwordTextField.text,
               let confirmPassword = confirmPasswordTextField.text,
               isValidEmail(email),
               isValidPassword(password),
               password == confirmPassword {
                
                signUpButton.isEnabled = true
                signUpButton.backgroundColor = UIColor.systemBlue
            } else {
                signUpButton.isEnabled = false
                signUpButton.backgroundColor = UIColor(red: 0.0/255.0, green: 175.0/255.0, blue: 185.0/255.0, alpha: 1.0)
            }
        }
        
        private func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        }
        
        private func isValidPassword(_ password: String) -> Bool {
            return password.count >= 8
        }
        
        // MARK: - UITextFieldDelegate
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let currentText = textField.text, let textRange = Range(range, in: currentText) {
                let updatedText = currentText.replacingCharacters(in: textRange, with: string)
                return !updatedText.contains(" ") // Disallow spaces
            }
            return true
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            switch textField {
            case emailTextField:
                passwordTextField.becomeFirstResponder()
            case passwordTextField:
                confirmPasswordTextField.becomeFirstResponder()
            case confirmPasswordTextField:
                textField.resignFirstResponder()
                if signUpButton.isEnabled {
                    signUpButtonTapped(signUpButton)
                }
            default:
                textField.resignFirstResponder()
            }
            return true
        }
        
        // MARK: - IBActions
        @IBAction func signUpButtonTapped(_ sender: UIButton) {
            guard let email = emailTextField.text,
                  let password = passwordTextField.text,
                  let confirmPassword = confirmPasswordTextField.text else {
                showAlert(message: "Please fill in all fields")
                return
            }
            
            guard password == confirmPassword else {
                showAlert(message: "Passwords do not match")
                return
            }
            
            if userManager.signUp(email: email, password: password) {
                print("Sign Up successful with Email: \(email)")
                navigateToNextPage()
            } else {
                showAlert(message: "Sign up failed. Email may already be in use.")
            }
        }
        
        // MARK: - Navigation
        private func navigateToNextPage() {
            // Add your navigation logic here
            // Example:
            // let welcomeViewController = storyboard?.instantiateViewController(identifier: "WelcomeViewController") as! WelcomeViewController
            // navigationController?.pushViewController(welcomeViewController, animated: true)
        }
        
        // MARK: - Helper Methods
        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Error",
                                        message: message,
                                        preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
