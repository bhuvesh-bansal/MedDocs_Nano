//
//  ReportDetailViewController.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 16/01/25.
//

import UIKit

class ReportDetailsViewController: UIViewController {
    // Outlets
    @IBOutlet weak var medicationTableView: UITableView!
    @IBOutlet weak var reportsCollectionView: UICollectionView!

    // Data Models
    var medications: [Medication] = []
    var reports: [Report] = []

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
        // Example Medication Data
//        medications = [
//            Medication(name: "Diphenhydramine Syrup", dosage: "1 tbsp/ml Daily", timing: "8:00 AM"),
//            Medication(name: "DSR Capsule", dosage: "1 Capsule", timing: "10:00 AM"),
//            Medication(name: "Acetomel Syrup", dosage: "2 tbsp/ml", timing: "2:00 PM"),
//            Medication(name: "Paracetamol Tablet", dosage: "1 Tablet", timing: "5:00 PM")
//        ]
//
//        // Example Reports Data
//        reports = [
//            Report(title: "Lab Report", imageUrl: "lab_report"), // Replace with actual image names
//            Report(title: "Prescription", imageUrl: "prescription") // Replace with actual image names
//        ]

        // Reload Data
        medicationTableView.reloadData()
        reportsCollectionView.reloadData()
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension ReportDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue the custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath) as! MedicationTableViewCell
        let medication = medications[indexPath.row]
        
        // Configure the cell
//        cell.medicationNameLabel.text = medication.name
//        cell.medicationDosage.text = medication.dosage
//        cell.medicineTiming.text = medication.timing
//        cell.medicationImageTextLabel.text = medication.name.first?.uppercased()
//        
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Selected medication: \(medications[indexPath.row].name)")
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
//        cell.imageView.image = UIImage(named: report.imageUrl)
//        cell.titleLabel.text = report.title
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}
