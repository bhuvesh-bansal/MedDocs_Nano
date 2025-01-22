
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
            super.viewDidLoad()

            
            emailTextField.delegate = self
            passwordTextField.delegate = self
            confirmPasswordTextField.delegate = self

            signUpButton.backgroundColor = UIColor(red: 0.0/255.0, green: 175.0/255.0, blue: 185.0/255.0, alpha: 1.0)
            signUpButton.setTitleColor(.white, for: .normal)
            signUpButton.layer.cornerRadius = 8.0

            emailTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
            passwordTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
            confirmPasswordTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        }

        @objc func textFieldsDidChange() {
            
            if let email = emailTextField.text,
               let password = passwordTextField.text,
               let confirmPassword = confirmPasswordTextField.text,
               isValidEmail(email),
               isValidPassword(password),
               password == confirmPassword {
                print("All inputs are valid")
            } else {
                print("Invalid input(s)")
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
                return !updatedText.contains(" ") // Disallow spaces
            }
            return true
        }

        @IBAction func signUpButtonTapped(_ sender: UIButton) {
            if let email = emailTextField.text,
               let password = passwordTextField.text {
                print("Sign Up with Email: \(email), Password: \(password)")
                // Navigate to the next page or show success message
                navigateToNextPage()
            }
        }

        func navigateToNextPage() {
            // Add your navigation logic here
            // Example:
            // let welcomeViewController = storyboard?.instantiateViewController(identifier: "WelcomeViewController") as! WelcomeViewController
            // navigationController?.pushViewController(welcomeViewController, animated: true)
        }
    }
