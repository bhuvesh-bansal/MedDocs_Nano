

import UIKit

class EmailVerificationViewController: UIViewController {

    @IBOutlet weak var otpTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func verifyTapped(_ sender: UIButton) {
        guard let otp = otpTextField.text, !otp.isEmpty else {
            showAlert(message: "Please enter the OTP.")
            return
        }
        
        if otp == "1111" {
            performSegue(withIdentifier: "toResetPassword", sender: nil)
        } else {
            showAlert(message: "Invalid OTP. Please try again.")
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
