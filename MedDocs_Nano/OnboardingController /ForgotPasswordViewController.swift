import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendCodeButton: UIButton! // Outlet for the Send Code button

    override func viewDidLoad() {
        super.viewDidLoad()
        //sendCodeButton.isEnabled = false // Disable the button by default
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // Hide the navigation bar when this view appears
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar when leaving this view
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBAction func sendCodeTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, isValidEmail(email) else {
            showAlert(message: "Please enter a valid email.")
            return
        }
        
        if email == "abc@gmail.com" {
            performSegue(withIdentifier: "toEmailVerification", sender: nil)
        } else {
            showAlert(message: "Email not found.")
        }
    }

    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        if let email = textField.text {
            sendCodeButton.isEnabled = isValidEmail(email) // Enable or disable the button based on email validity
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
