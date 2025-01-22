//
//  AppointmentDetailViewController.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 20/01/25.
//

import UIKit

struct MedicationTwo {
    let name: String
    let dosage: String
    let type: String
    let date: String
    let time: String
}

struct ReportTwo {
    let imageUrl: String
    let uploadDate: String
}

class AppointmentDetailViewController: UIViewController {

    @IBOutlet weak var lastUpdatedDateLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var medicationTableView: UITableView!
    // identifier MedicationCell
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var reportsCollectionView: UICollectionView!
    // identifier reportsCell

    var medications: [MedicationTwo] = []
    var reports: [ReportTwo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

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
        // Dummy data for medications
        medications = [
            MedicationTwo(name: "Paracetamol", dosage: "500 mg", type: "Tablet", date: "20/01/2025", time: "08:00 AM"),
            MedicationTwo(name: "Ibuprofen", dosage: "200 mg", type: "Capsule", date: "18/01/2025", time: "09:00 PM"),
            MedicationTwo(name: "Cetirizine", dosage: "10 mg", type: "Tablet", date: "15/01/2025", time: "07:30 AM"),
            MedicationTwo(name: "Amoxicillin", dosage: "250 mg", type: "Syrup", date: "22/01/2025", time: "12:00 PM")
        ]

        // Dummy data for reports
        reports = [
            ReportTwo(imageUrl: "lab_report", uploadDate: "January 15, 2025"),
            ReportTwo(imageUrl: "prescription", uploadDate: "January 10, 2025")
        ]

        // Update UI elements
        lastUpdatedDateLabel.text = "Last Updated: \(getCurrentDate())"
        doctorNameLabel.text = "Dr. John Smith"
        notesLabel.text = "Follow-up consultation notes will appear here."
        tagNameLabel.text = "General Check-up"

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
extension AppointmentDetailViewController: UITableViewDataSource, UITableViewDelegate {
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
        cell.medicationDosageLabel.text = "\(medication.dosage)"
        cell.medicationTypeLabel.text = "\(medication.type)"
        cell.medicationDateLabel.text = "\(medication.date)"
        cell.medicationTimeLabel.text = "\(medication.time)"
        cell.medicationImageView.image = UIImage(systemName: "pills.fill") // Example SF Symbol

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected medication: \(medications[indexPath.row].name)")
    }
}

// MARK: - UICollectionViewDataSource and UICollectionViewDelegateFlowLayout
extension AppointmentDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reports.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reportsCell", for: indexPath) as? ReportCollectionViewCell else {
            return UICollectionViewCell() // Return a default cell if dequeuing fails
        }

        let report = reports[indexPath.item]

        // Safely load the image
        if let image = UIImage(named: report.imageUrl) {
            cell.imageView.image = image
        } else {
            // Fallback to a placeholder image if not found
            cell.imageView.image = UIImage(systemName: "doc.text") // Placeholder SF Symbol
            print("Image not found for report: \(report.imageUrl)")
        }

        // Configure the cell
        cell.uploadDate.text = report.uploadDate

        return cell
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}
