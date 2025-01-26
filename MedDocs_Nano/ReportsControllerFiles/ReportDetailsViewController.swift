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
    let type: String
    let date: String
    let time: String
}

struct ReportOne {
    let imageUrl: String
    let uploadDate: String
}

class ReportDetailsViewController: UIViewController {
    // Outlets
    @IBOutlet weak var medicationTableView: UITableView!
    // Identifier: MedicationCell
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

        // Setup CollectionView
        reportsCollectionView.dataSource = self
        reportsCollectionView.delegate = self

        // Load Data
        loadData()
    }

    private func loadData() {
        // Updated Medication Data
        medications = [
            MedicationOne(name: "Paracetamol", dosage: "500 mg", type: "Tablet", date: "20/01/2025", time: "08:00 AM"),
            MedicationOne(name: "Ibuprofen", dosage: "200 mg", type: "Capsule", date: "18/01/2025", time: "09:00 PM"),
            MedicationOne(name: "Cetirizine", dosage: "10 mg", type: "Tablet", date: "15/01/2025", time: "07:30 AM"),
            MedicationOne(name: "Amoxicillin", dosage: "250 mg", type: "Syrup", date: "22/01/2025", time: "12:00 PM")
        ]

        // Updated Reports Data
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath) as? MedicationDetailTableViewCell else {
            return UITableViewCell()
        }

        let medication = medications[indexPath.row]

        // Configure the cell
        cell.medicationNameLabel.text = medication.name
        cell.amountLabel.text = "\(medication.dosage)"
        cell.medicineTypeLabel.text = "\(medication.type)"
        cell.startDateLabel.text = "\(medication.date)"
        cell.startTimeLabel.text = "\(medication.time)"
//        cell.medicationImageView.image = UIImage(systemName: "pills.fill")  Example SF Symbol
        

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportCell", for: indexPath) as! ReportDetailCollectionViewCell
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
