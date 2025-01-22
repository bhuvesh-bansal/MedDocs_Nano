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
       let allergies = ["Peanuts", "Shellfish", "Eggs", "Dairy", "Wheat", "Soy", "Tree Nuts", "None"]

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

       override func viewDidLoad() {
           super.viewDidLoad()

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

       // MARK: - Open Image Picker Action Sheet
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
