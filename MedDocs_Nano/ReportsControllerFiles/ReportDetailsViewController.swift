//
//  ReportDetailViewController.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 16/01/25.
//

import UIKit

struct MedicationOne {
    let name: String
    let dosage: String
    let timing: String
}

struct ReportOne {
    let imageUrl: String
    let uploadDate: String
}

class ReportDetailsViewController: UIViewController {
    // Outlets
    @IBOutlet weak var medicationTableView: UITableView!
    @IBOutlet weak var reportsCollectionView: UICollectionView!
    @IBOutlet weak var lastUpdatedDateLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!

    // Data Models
    var medications: [MedicationOne] = []
    var reports: [ReportOne] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the title of the page
        navigationItem.title = "City Hospital"

        // Setup TableView
        medicationTableView.dataSource = self
        medicationTableView.delegate = self

        // Register custom cell for TableView
        // Un-comment and use this line if you have a custom Medication cell registered
        // medicationTableView.register(UINib(nibName: "MedicationTableViewCell", bundle: nil), forCellReuseIdentifier: "MedicationCell")

        // Setup CollectionView
        reportsCollectionView.dataSource = self
        reportsCollectionView.delegate = self

        // Register custom cell for CollectionView
        // Un-comment and use this line if you have a custom Report cell registered
        // reportsCollectionView.register(UINib(nibName: "ReportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ReportCell")

        // Load Data
        loadData()
    }

    private func loadData() {
        // Example Medication Data
        medications = [
            MedicationOne(name: "Diphenhydramine Syrup", dosage: "1 tbsp/ml Daily", timing: "8:00 AM"),
            MedicationOne(name: "DSR Capsule", dosage: "1 Capsule", timing: "10:00 AM"),
            MedicationOne(name: "Acetomel Syrup", dosage: "2 tbsp/ml", timing: "2:00 PM"),
            MedicationOne(name: "Paracetamol Tablet", dosage: "1 Tablet", timing: "5:00 PM")
        ]

        // Example Reports Data (with upload dates)
        reports = [
            ReportOne(imageUrl: "lab_report", uploadDate: "January 15, 2025"),
            ReportOne(imageUrl: "prescription", uploadDate: "January 10, 2025")
        ]

        // Update UI elements
        lastUpdatedDateLabel.text = "Last Updated: \(getCurrentDate())"
        notesLabel.text = "These reports are the latest from your recent consultation."

        // Reload Data
        medicationTableView.reloadData()
        reportsCollectionView.reloadData()
    }

    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: Date())
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension ReportDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue the custom cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath) as? MedicationTableViewCell else {
            return UITableViewCell()
        }
        
        let medication = medications[indexPath.row]
        
        // Configure the cell
        cell.medicationNameLabel.text = medication.name
        cell.medicationDosage.text = medication.dosage
        cell.medicineTiming.text = medication.timing
        cell.medicationImageTextLabel.text = medication.name.first?.uppercased()
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected medication: \(medications[indexPath.row].name)")
    }
}

// MARK: - UICollectionViewDataSource and UICollectionViewDelegateFlowLayout
extension ReportDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reports.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportCell", for: indexPath) as! ReportCollectionViewCell
        let report = reports[indexPath.item]

        // Configure the cell
        cell.imageView.image = UIImage(named: report.imageUrl) // Ensure this name exists in Assets
        cell.uploadDate.text = report.uploadDate

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}
