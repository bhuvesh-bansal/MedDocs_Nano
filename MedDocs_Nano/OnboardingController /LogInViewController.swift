import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!



    // Add UserDataModel reference
       private let userDataModel = UserDataModel.sharedUserData

       override func viewDidLoad() {
           super.viewDidLoad()
           
           emailTextField.delegate = self
           passwordTextField.delegate = self
           
           // Add targets for text field changes
           emailTextField.addTarget(self, action: #selector(textFieldsDidChange(_:)), for: .editingChanged)
           passwordTextField.addTarget(self, action: #selector(textFieldsDidChange(_:)), for: .editingChanged)
           
           #if DEBUG
           createTestUserIfNeeded()
           #endif
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.navigationController?.setNavigationBarHidden(false, animated: false)
       }

       // MARK: - Text Field Validation
       @objc func textFieldsDidChange(_ textField: UITextField) {
           if let email = emailTextField.text, let password = passwordTextField.text,
              isValidEmail(email), isValidPassword(password) {
               loginButton.isEnabled = true
               loginButton.backgroundColor = UIColor.systemBlue
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

       // MARK: - UITextField Delegate
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if let currentText = textField.text, let textRange = Range(range, in: currentText) {
               let updatedText = currentText.replacingCharacters(in: textRange, with: string)
               if textField == emailTextField || textField == passwordTextField {
                   return !updatedText.contains(" ") // No spaces allowed
               }
           }
           return true
       }

       // MARK: - Actions
       @IBAction func loginButtonTapped(_ sender: UIButton) {
           guard let email = emailTextField.text,
                 let password = passwordTextField.text else {
               return
           }
           
           // Attempt to login using UserDataModel
           if let user = userDataModel.loginUser(email: email, password: password) {
               handleSuccessfulLogin(user: user)
           } else {
               showLoginError()
           }
       }
       
       // MARK: - Helper Methods
       private func handleSuccessfulLogin(user: User) {
           UserDefaults.standard.set(user.userId.uuidString, forKey: "loggedInUserId")
           
           let alert = UIAlertController(
               title: "Success",
               message: "Welcome back, \(user.profile.firstName)!",
               preferredStyle: .alert
           )
           
           alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
               self
           })
           
           present(alert, animated: true)
       }
       
       private func showLoginError() {
           let alert = UIAlertController(
               title: "Login Failed",
               message: "Invalid email or password. Please try again.",
               preferredStyle: .alert
           )
           
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
       
//       private func navigateToMainApp() {
//           // Implement your navigation logic here
//           guard let mainViewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") else {
//               return
//           }
//           
//           if let navigationController = self.navigationController {
//               navigationController.setViewControllers([mainViewController], animated: true)
//           } else {
//               mainViewController.modalPresentationStyle = .fullScreen
//               present(mainViewController, animated: true)
//           }
//       }
       
       private func showAlert(title: String, message: String) {
           let alert = UIAlertController(
               title: title,
               message: message,
               preferredStyle: .alert
           )
           
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
   }

   // MARK: - Testing Support
   extension LoginViewController {
       func createTestUserIfNeeded() {
           let testEmail = "test@example.com"
           let testPassword = "password123"
           
           // Check if test user exists
           if userDataModel.loginUser(email: testEmail, password: testPassword) == nil {
               // Create test user
               let _ = userDataModel.registerUser(email: testEmail, password: testPassword)
               print("Test user created: \(testEmail)")
           }
           
           // Pre-fill credentials in debug mode
           emailTextField.text = testEmail
           passwordTextField.text = testPassword
           textFieldsDidChange(emailTextField)
       }
   }
