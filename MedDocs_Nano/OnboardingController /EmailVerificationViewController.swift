

import UIKit

class EmailVerificationViewController: UIViewController {
    
    // Add these properties
    var expectedCode: String = ""
    var userEmail: String?
    
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
        }
        
        private func setupUI() {
            // Configure text field
            codeTextField.delegate = self
            codeTextField.keyboardType = .numberPad
            codeTextField.addTarget(self, action: #selector(codeTextFieldDidChange(_:)), for: .editingChanged)
            
            verifyButton.isEnabled = false
        }
        
        @IBAction func verifyCodeTapped(_ sender: UIButton) {
            guard let enteredCode = codeTextField.text, !enteredCode.isEmpty else {
                showErrorAlert(message: "Please enter the verification code.")
                return
            }
            
            if enteredCode == expectedCode {
                showSuccessAlert(message: "Code verified successfully")
            } else {
                showErrorAlert(message: "Invalid verification code.")
            }
        }
        
        @objc func codeTextFieldDidChange(_ textField: UITextField) {
            // Enable verify button when 4 digits are entered
            verifyButton.isEnabled = (textField.text?.count == 4)
        }
        
        private func showErrorAlert(message: String) {
            let alert = UIAlertController(
                title: "Error",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
        private func showSuccessAlert(message: String) {
            let alert = UIAlertController(
                title: "Success",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                // Navigate to reset password screen
                self?.performSegue(withIdentifier: "toResetPassword", sender: nil)
            })
            present(alert, animated: true)
        }
    }

    // MARK: - UITextFieldDelegate
    extension EmailVerificationViewController: UITextFieldDelegate {
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Only allow digits
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            let isNumeric = allowedCharacters.isSuperset(of: characterSet)
            
            // Get the current text length and add the length of string that's about to be added
            let currentText = textField.text ?? ""
            let newLength = currentText.count + string.count - range.length
            
            // Return true if the edit is a deletion or the new length is less than or equal to 4
            return isNumeric && (newLength <= 4 || string.isEmpty)
        }
    }
