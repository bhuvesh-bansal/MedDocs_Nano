import UIKit

class ProfileTableViewController: UITableViewController ,UIPickerViewDataSource, UIPickerViewDelegate,UITextViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var MobileNumberTextField: UITextField!
    
    @IBOutlet weak var bloodGroupTextField: UITextField!
    
    @IBOutlet weak var allergiesTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    
    

    



    // MARK: - Properties
       static var profiles: [Profile] = []
       
       // Picker Views for Blood Group and Allergies
       lazy var bloodGroupPicker: UIPickerView = {
           let picker = UIPickerView()
           picker.dataSource = self
           picker.delegate = self
           return picker
       }()
       
       lazy var allergiesPicker: UIPickerView = {
           let picker = UIPickerView()
           picker.dataSource = self
           picker.delegate = self
           return picker
       }()
       
       // Data arrays for Blood Groups and Allergies
       let bloodGroups = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
       let allergies = ["Food","Drug","Environmental","NotMentioned","None"]
       
       // Date Picker and Formatter
       lazy var datePicker: UIDatePicker = {
           let picker = UIDatePicker()
           picker.datePickerMode = .date
           picker.preferredDatePickerStyle = .wheels
           picker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
           return picker
       }()
       
       lazy var datePickerToolbar: UIToolbar = {
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissDatePicker))
           let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           toolbar.setItems([space, doneButton], animated: false)
           return toolbar
       }()
       
       lazy var dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateStyle = .medium
           formatter.timeStyle = .none
           return formatter
       }()
       
       // MARK: - Lifecycle Methods
       override func viewDidLoad() {
           super.viewDidLoad()
           setupUI()
           
           // Add save button to navigation bar
           navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                             style: .done,
                                                             target: self,
                                                             action: #selector(saveProfile))
           
           // Configure profile image view
           configureProfileImageView()
       }
       
       // MARK: - UI Setup
       private func setupUI() {
           // Set input views for text fields
           bloodGroupTextField.inputView = bloodGroupPicker
           allergiesTextField.inputView = allergiesPicker
           dateTextField.inputView = datePicker
           dateTextField.inputAccessoryView = datePickerToolbar
           
           // Configure Address TextView
           addressTextView.delegate = self
           addressTextView.layer.borderColor = UIColor.lightGray.cgColor
           addressTextView.layer.borderWidth = 1.0
           addressTextView.layer.cornerRadius = 5.0
           
           // Configure Mobile Number
           MobileNumberTextField.keyboardType = .numberPad
           MobileNumberTextField.addTarget(self, action: #selector(validatePhoneNumber(_:)), for: .editingChanged)
           
           // Add target for gender segmented control
           genderSegmentedControl.addTarget(self, action: #selector(genderChanged(_:)), for: .valueChanged)
           
           // Tap gesture to dismiss keyboard
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
           self.view.addGestureRecognizer(tapGesture)
           
           // Add photo button target
           addPhotoButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
       }
       
       private func configureProfileImageView() {
           if profileImageView.image == nil {
               let configuration = UIImage.SymbolConfiguration(pointSize: 120, weight: .regular)
               let profileIcon = UIImage(systemName: "person.circle.fill", withConfiguration: configuration)?
                   .withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
               
               profileImageView.tintColor = .systemGreen
               profileImageView.image = profileIcon
           }
           
           profileImageView.contentMode = .scaleAspectFit
           profileImageView.clipsToBounds = true
       }
       
       // MARK: - Save Profile
       @objc private func saveProfile() {
           guard let name = nameTextField.text, !name.isEmpty,
                 let email = emailTextField.text, !email.isEmpty,
                 let dateText = dateTextField.text,
                 let date = dateFormatter.date(from: dateText),
                 let mobileNumber = MobileNumberTextField.text, !mobileNumber.isEmpty,
                 let bloodGroup = bloodGroupTextField.text,
                 let allergies = allergiesTextField.text,
                 let address = addressTextView.text else {
               showAlert(message: "Please fill in all required fields")
               return
           }
           
           // Validate inputs
           guard name.count >= 2 else {
               showAlert(message: "Please enter a valid name (minimum 2 characters)")
               return
           }
           
           let phoneRegex = "^[0-9]{10}$"
           let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
           guard phonePredicate.evaluate(with: mobileNumber) else {
               showAlert(message: "Please enter a valid 10-digit mobile number")
               return
           }
           
           let gender = genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex) ?? "Other"
           
           // Create new profile
           let profile = Profile(
               image: profileImageView.image?.jpegData(compressionQuality: 0.8),
               name: name,
               email: email,
               dateOfBirth: date,
               gender: gender,
               mobileNumber: mobileNumber,
               bloodGroup: bloodGroup,
               allergies: allergies,
               address: address
           )
           
           // Add to array
           ProfileTableViewController.profiles.append(profile)
           
           // Show success message and print the saved profile
           showAlert(message: "Profile saved successfully", isError: false) { [weak self] _ in
               print("Saved Profiles: \(ProfileTableViewController.profiles)")
               // Navigate back or dismiss
               self?.navigationController?.popViewController(animated: true)
           }
       }
       
       // MARK: - Alert Helper
       private func showAlert(message: String, isError: Bool = true, completion: ((UIAlertAction) -> Void)? = nil) {
           let alert = UIAlertController(
               title: isError ? "Error" : "Success",
               message: message,
               preferredStyle: .alert
           )
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
           present(alert, animated: true)
       }
       
       // MARK: - Image Picker Methods
       @objc func openImagePicker() {
           let actionSheet = UIAlertController(title: "Choose Photo", message: "Select a source", preferredStyle: .actionSheet)
           if UIImagePickerController.isSourceTypeAvailable(.camera) {
               actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in self.openCamera() }))
           }
           actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in self.openPhotoLibrary() }))
           actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           self.present(actionSheet, animated: true, completion: nil)
       }
       
       func openCamera() {
           let imagePickerController = UIImagePickerController()
           imagePickerController.delegate = self
           imagePickerController.sourceType = .camera
           imagePickerController.allowsEditing = true
           self.present(imagePickerController, animated: true, completion: nil)
       }
       
       func openPhotoLibrary() {
           let imagePickerController = UIImagePickerController()
           imagePickerController.delegate = self
           imagePickerController.sourceType = .photoLibrary
           imagePickerController.allowsEditing = true
           self.present(imagePickerController, animated: true, completion: nil)
       }
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
           if let selectedImage = info[.editedImage] as? UIImage {
               profileImageView.image = selectedImage
           }
           picker.dismiss(animated: true, completion: nil)
       }
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
       
       // MARK: - DatePicker Methods
       @objc func datePickerChanged(_ sender: UIDatePicker) {
           dateTextField.text = dateFormatter.string(from: sender.date)
       }
       
       @objc func dismissDatePicker() {
           dateTextField.resignFirstResponder()
       }
       
       // MARK: - Picker Methods
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return pickerView == bloodGroupPicker ? bloodGroups.count : allergies.count
       }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return pickerView == bloodGroupPicker ? bloodGroups[row] : allergies[row]
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           if pickerView == bloodGroupPicker {
               bloodGroupTextField.text = bloodGroups[row]
           } else {
               allergiesTextField.text = allergies[row]
           }
       }
       
       // MARK: - Mobile Number Validation
       @objc func validatePhoneNumber(_ sender: UITextField) {
           let cleanedPhoneNumber = sender.text?.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
           sender.text = cleanedPhoneNumber
       }
       
       // MARK: - Gender Segmented Control
       @objc func genderChanged(_ sender: UISegmentedControl) {
           let selectedGender = sender.titleForSegment(at: sender.selectedSegmentIndex)
           print("Selected gender: \(selectedGender ?? "Not selected")")
       }
       
       // MARK: - Dismissing Keyboard
       @objc func dismissKeyboard() {
           view.endEditing(true)
       }
   }



//You can access saved profiles from any other view controller using:
//let savedProfiles = ProfileTableViewController.profiles
