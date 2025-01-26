import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendCodeButton: UIButton! // Outlet for the Send Code button



    private let userDataModel = UserDataModel.sharedUserData
       private var verificationCode: String = ""
       
       override func viewDidLoad() {
           super.viewDidLoad()
           emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
       }

       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.navigationController?.setNavigationBarHidden(false, animated: true)
       }

       @IBAction func sendCodeTapped(_ sender: UIButton) {
           guard let email = emailTextField.text, isValidEmail(email) else {
               showErrorAlert(message: "Please enter a valid email.")
               return
           }
           
           // Generate 4-digit OTP
           verificationCode = generateOTP()
           
           // For testing: Show OTP in alert
           showOTPAlert(email: email, otp: verificationCode)
       }
       
       private func showOTPAlert(email: String, otp: String) {
           let alert = UIAlertController(
               title: "OTP Sent",
               message: "Your OTP is: \(otp)\n\nIn production, this would be sent to: \(email)",
               preferredStyle: .alert
           )
           
           alert.addAction(UIAlertAction(title: "Verify OTP", style: .default) { [weak self] _ in
               self?.performSegue(withIdentifier: "toEmailVerification", sender: nil)
           })
           
           present(alert, animated: true)
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

       private func generateOTP() -> String {
           // Generate a 4-digit OTP
           return String(format: "%04d", Int.random(in: 0...9999))
       }

       @objc func emailTextFieldDidChange(_ textField: UITextField) {
           if let email = textField.text {
               sendCodeButton.isEnabled = isValidEmail(email)
           }
       }

       private func isValidEmail(_ email: String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
           let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: email)
       }

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toEmailVerification" {
               if let verificationVC = segue.destination as? EmailVerificationViewController {
                   verificationVC.expectedCode = verificationCode
                   verificationVC.userEmail = emailTextField.text
               }
           }
       }
   }
