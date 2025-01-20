//
//  AddReportsViewController.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 18/01/25.
//

import UIKit

class AddReportsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tagNameTextField: UITextField!
    @IBOutlet weak var hospitalNameTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var addReportImageButton: UIButton!
    @IBOutlet weak var reportsImagesCollectionView: UICollectionView!
    @IBOutlet weak var addAppointmentCollectionView: UICollectionView!
    @IBOutlet weak var appointmentTextField: UITextField!
    @IBOutlet weak var showAppointmentTableView: UITableView!
    
    @IBOutlet weak var addMedicationCollectionView: UICollectionView!
    @IBOutlet weak var medicationTextField: UITextField!

    @IBOutlet weak var showMedicationTableView: UITableView!
    
    
    @IBOutlet weak var tagNameTextFieldWidthConstraint: NSLayoutConstraint! // Fixed width constraint
    @IBOutlet weak var tagNameTextFieldExpandedWidthConstraint: NSLayoutConstraint! // Expandable width constraint
    
    var appointmentTags: [String] = [] // Holds appointment tags
    var appointments: [String] = ["Appointment 1", "Appointment 2", "Appointment 3"] // Dummy data for appointments
    var medications: [String] = ["Medication 1", "Medication 2", "Medication 3"] // Dummy data for medications
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup delegates
        showMedicationTableView.delegate = self
        showMedicationTableView.dataSource = self
        showAppointmentTableView.delegate = self
        showAppointmentTableView.dataSource = self
        
        // Tags Collection View setup
        addAppointmentCollectionView.delegate = self
        addAppointmentCollectionView.dataSource = self
        appointmentTextField.delegate = self  // Set the delegate for the text field
        
        // Optional: set the return key to "Done" for better user experience
        appointmentTextField.returnKeyType = .done
        
        // Dummy data for initial load (for testing visibility)
        appointmentTags.append("Dummy Appointment 1")
        appointmentTags.append("Dummy Appointment 2")
        addAppointmentCollectionView.reloadData()

        // Update text field width based on collection view content
        updateTextFieldWidth()
    }
    
    // MARK: - UITextField Delegate (To capture enter key and add tag)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let newTag = textField.text, !newTag.isEmpty {
            print("Entered new tag: \(newTag)") // Debug print
            
            // Add the tag to the data source (array)
            appointmentTags.append(newTag)
            print("Updated appointmentTags: \(appointmentTags)") // Debug print
            
            // Clear the text field after adding the tag
            textField.text = ""
            
            // Create the new index path for the item being added
            let newIndexPath = IndexPath(item: appointmentTags.count - 1, section: 0)
            
            // Insert the new item into the collection view
            addAppointmentCollectionView.insertItems(at: [newIndexPath])
            print("Item inserted at indexPath: \(newIndexPath)") // Debug print
            
            // Update the width of the text field based on collection view data
            updateTextFieldWidth()
        } else {
            print("Text field is empty, no tag added") // Debug print
        }
        
        // Dismiss the keyboard when the enter key is pressed
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Update Text Field Width Based on Collection View Data
    func updateTextFieldWidth() {
        // Check if there are any items in the collection view
        if appointmentTags.isEmpty {
            // If the collection view is empty, stretch the text field
            tagNameTextFieldWidthConstraint.priority = .defaultHigh
            tagNameTextFieldExpandedWidthConstraint.priority = .required
        } else {
            // If there are items in the collection view, set the text field to default size
            tagNameTextFieldWidthConstraint.priority = .required
            tagNameTextFieldExpandedWidthConstraint.priority = .defaultHigh
        }

        // Animate the constraint change (optional)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - UICollectionView DataSource for Appointment Tags
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appointmentTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentTagCell", for: indexPath) as! AddReportAddAppointmentCollectionViewCell
        
        // Set the label text to the current tag from the data source
        cell.appointmentLabel.text = appointmentTags[indexPath.row]
        
        // Configure the remove button
        cell.removeButton.addTarget(self, action: #selector(removeTag(_:)), for: .touchUpInside)
        cell.removeButton.tag = indexPath.row

        // Add constraints to the remove button for visibility
        // (make sure it's in the top-right corner of the cell)
        cell.removeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.removeButton.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 5),
            cell.removeButton.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -5),
            cell.removeButton.widthAnchor.constraint(equalToConstant: 20),  // Adjust the size as needed
            cell.removeButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return cell
    }

    // MARK: - Remove Tag Action
    @objc func removeTag(_ sender: UIButton) {
        let index = sender.tag
        print("Removing tag at index: \(index)") // Debug print
        appointmentTags.remove(at: index)
        addAppointmentCollectionView.reloadData() // Reload the collection view after removal
        print("Updated appointmentTags: \(appointmentTags)") // Debug print

        // Update the text field width after removal
        updateTextFieldWidth()
    }
    
    // MARK: - Add Report Image Action
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}

extension AddReportsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == showAppointmentTableView {
            return appointments.count // Return the number of appointments
        } else {
            return medications.count // Return the number of medications
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == showAppointmentTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addReportAppointmentDetailTableViewCell", for: indexPath) as! AddReportAppointmentDetailTableViewCell
            
            // Set up appointment cell
            let appointmentName = appointments[indexPath.row]
            cell.appointmentNameLabel.text = appointmentName
            cell.appointmentDateLabel.text = "Date: \(Date())" // Show only the date
            
            // Set the first letter of the appointment name to the image label
            if let firstLetter = appointmentName.first {
                cell.appointmentNameImageLabel.text = String(firstLetter)
            } else {
                cell.appointmentNameImageLabel.text = "" // Fallback in case appointment name is empty
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addReportMedicationDetailTableViewCell", for: indexPath) as! AddReportMedicationDetailTableViewCell
            
            // Set up medication cell
            let medicationName = medications[indexPath.row]
            cell.addMedicationNameLabel.text = medicationName
            cell.addMedicationDateLabel.text = "Date: \(Date())" // Show only the date
            
            // Set the first letter of the medication name to the image label
            if let firstLetter = medicationName.first {
                cell.addMedicationImageLabel.text = String(firstLetter)
            } else {
                cell.addMedicationImageLabel.text = "" // Fallback in case medication name is empty
            }
            
            return cell
        }
    }
}
