//
//  TestStoryViewController.swift
//  MedDocs_Nano
//
//  Created by Vansh Sharma on 22/01/25.
//


import UIKit

class TestStoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Outlet for the label that displays the selected medicine
    @IBOutlet weak var selectedMedicineLabel: UILabel!
    
    // Outlet for the UIPickerView
    @IBOutlet weak var medicinePicker: UIPickerView!
    
    // Array of medicines
    let medicines = ["Paracetamol", "Ibuprofen", "Amoxicillin", "Metformin", "Atorvastatin",
                     "Losartan", "Omeprazole", "Amlodipine", "Salbutamol", "Cetirizine"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set picker delegates
        medicinePicker.delegate = self
        medicinePicker.dataSource = self
        
        // Initially hide the picker view
        medicinePicker.isHidden = true
        
        // Add a tap gesture recognizer to the label
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSelectMedicineLabel))
        selectedMedicineLabel.isUserInteractionEnabled = true
        selectedMedicineLabel.addGestureRecognizer(tapGesture)
        
        // Set initial label text
        selectedMedicineLabel.text = "Select Medicine"
    }
    
    // MARK: - Gesture Action
    
    @objc func didTapSelectMedicineLabel() {
        // Toggle the visibility of the picker view
        medicinePicker.isHidden = !medicinePicker.isHidden
    }
    
    // MARK: - UIPickerViewDataSource Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return medicines.count
    }
    
    // MARK: - UIPickerViewDelegate Methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return medicines[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Update the label with the selected medicine
        selectedMedicineLabel.text = medicines[row]
        
        // Hide the picker after selection
        medicinePicker.isHidden = true
    }
}
