////
////  InputProfileViewController.swift
////  MedDocs_Nano
////
////  Created by TRISHA on 20/01/25.
////
//
//import UIKit
//
//class InputProfileViewController: UIViewController {
//
//    
//    @IBOutlet weak var tableView: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension InputProfileViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    // MARK: - Number of Sections
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    // MARK: - Number of Rows in Section
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return profileData.count
//    }
//    
//    // MARK: - Cell Configuration
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = profileData[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath)
//        
//        cell.textLabel?.text = item.title
//        
//        // Add text field or appropriate input type based on the profile item
//        var textField: UITextField
//        if let existingTextField = cell.viewWithTag(100) as? UITextField {
//            textField = existingTextField
//        } else {
//            textField = UITextField()
//            textField.tag = 100
//            cell.contentView.addSubview(textField)
//            textField.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                textField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
//                textField.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
//                textField.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 120)
//            ])
//        }
//        
//        textField.text = item.value
//        textField.delegate = self
//        
//        switch item.inputType {
//        case .text:
//            textField.keyboardType = .default
//        case .date:
//            textField.keyboardType = .default
//            textField.placeholder = "MM/DD/YYYY"
//            // Add a DatePicker for Date of Birth
//            textField.inputView = createDatePicker(for: indexPath)
//        case .phone:
//            textField.keyboardType = .phonePad
//        case .number:
//            textField.keyboardType = .numberPad
//        }
//        
//        return cell
//    }
//    
//    // MARK: - Date Picker for Date of Birth
//    private func createDatePicker(for indexPath: IndexPath) -> UIDatePicker {
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .date
//        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
//        return datePicker
//    }
//    
//    // MARK: - Date Picker Action
//    @objc func dateChanged(_ sender: UIDatePicker) {
//        // Convert the selected date to string and update the text field
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .short
//        if let indexPath = tableView.indexPathForSelectedRow {
//            profileData[indexPath.row].value = dateFormatter.string(from: sender.date)
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//        }
//    }
//    
//    // MARK: - Save Button
//    @IBAction func saveButtonTapped(_ sender: UIButton) {
//        // Here you can save the profileData array to your desired storage
//        print(profileData)
//    }
//}
//
//extension InputProfileViewController: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        // When the user finishes editing, update the value of the field in profileData
//        if let indexPath = tableView.indexPathForSelectedRow {
//            profileData[indexPath.row].value = textField.text ?? ""
//        }
//    }
//}
//
//
