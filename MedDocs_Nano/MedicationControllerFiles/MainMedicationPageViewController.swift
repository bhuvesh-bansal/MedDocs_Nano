//
//  MainMedicationPageViewController.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 20/01/25.
//

import UIKit

class MainMedicationPageViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var medicationTableView: UITableView!
    // Cell Identifier MedicationCell
    
    // Sample medications data
    var medications: [(name: String, dosage: String, type: String, date: String, time: String)] = [
        ("Paracetamol", "500 mg", "Tablet", "20/01/2025", "08:00 AM"),
        ("Ibuprofen", "200 mg", "Capsule", "18/01/2025", "09:00 PM"),
        ("Cetirizine", "10 mg", "Tablet", "15/01/2025", "07:30 AM"),
        ("Amoxicillin", "250 mg", "Syrup", "22/01/2025", "12:00 PM")
    ]
    
    // Filtered medications for search
    var filteredMedications: [(name: String, dosage: String, type: String, date: String, time: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up filteredMedications
        filteredMedications = medications

        // Set up delegates and data sources
        medicationTableView.delegate = self
        medicationTableView.dataSource = self
        searchBar.delegate = self
    }
}

// MARK: - TableView Delegate and DataSource
extension MainMedicationPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMedications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath) as! MedicationDetailTableViewCell
        let medication = filteredMedications[indexPath.row]
        
        // Configure cell
        cell.medicationNameLabel.text = medication.name
        cell.medicationDosageLabel.text = medication.dosage
        cell.medicationTypeLabel.text = medication.type
        cell.medicationDateLabel.text = medication.date
        cell.medicationTimeLabel.text = medication.time
        
        // Configure image
        cell.medicationImageView.image = UIImage(systemName: "pills") // Replace with custom image if available
        cell.medicationImageView.tintColor = .systemBlue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust as per design requirements
    }
}

// MARK: - SearchBar Delegate
extension MainMedicationPageViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        // Filter medications by name
        if trimmedSearchText.isEmpty {
            filteredMedications = medications
        } else {
            filteredMedications = medications.filter { $0.name.lowercased().contains(trimmedSearchText) }
        }
        
        // Reload table view with filtered results
        medicationTableView.reloadData()
    }
}
