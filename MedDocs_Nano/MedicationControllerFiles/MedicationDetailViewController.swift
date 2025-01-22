//
//  MedicationDetailViewController.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 20/01/25.
//

import UIKit

class MedicationDetailViewController: UIViewController {

    @IBOutlet weak var medicationDetailsTableView: UITableView!
    @IBOutlet weak var reportDetailsCollectionView: UICollectionView!
    @IBOutlet weak var appointmentDetailTableView: UITableView!
    
    let medicationDetails = [
        ("First Dosage", "1 tablet at 8 AM"),
        ("Second Dosage", "1 tablet at 6 PM"),
        ("Dosage Type", "Tablet"),
        ("Start Date", "26/12/2024"),
        ("End Date", "29/12/2024"),
        ("Prescribed By", "Dr. Smith"),
        ("Status", "Active")
    ]
    
    let appointments = [
        ("Neelam Hospital", "Shoulder ligament tear", "01/01/2025", "Upcoming"),
        ("Neelam Hospital", "Back Pain", "15/01/2025", "Completed"),
        ("Neelam Hospital", "Neck Pain", "20/01/2025", "Upcoming")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Debugging: Ensure viewDidLoad is running
        print("MedicationDetailViewController viewDidLoad called")
        // Set delegates and data sources
        medicationDetailsTableView.dataSource = self
        reportDetailsCollectionView.dataSource = self
        reportDetailsCollectionView.delegate = self
        appointmentDetailTableView.dataSource = self
        appointmentDetailTableView.delegate = self
    }
}
extension MedicationDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView DataSource for Medication Details
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == medicationDetailsTableView {
            return medicationDetails.count
        } else if tableView == appointmentDetailTableView {
            return appointments.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == medicationDetailsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "medicationDetailCell", for: indexPath) as! ShowMedicationDetailTableViewCell
            let detail = medicationDetails[indexPath.row]
            cell.titleLabel.text = detail.0
            cell.titleDescriptionLabel.text = detail.1
            print("Configured MedicationDetailCell for row \(indexPath.row)")
            return cell
        } else if tableView == appointmentDetailTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentDetailTableViewCell
            let appointment = appointments[indexPath.row]
            cell.appointmentNameImageTextLabel.text = appointment.0
            cell.appointmentNameLabel.text = appointment.1
            cell.appointmentDateLabel.text = appointment.2
            cell.appointmentStatusLabel.text = appointment.3
            print("Configured AppointmentDetailCell for row \(indexPath.row)")
            return cell
        }
        
        // Fallback case
        return UITableViewCell()
    }
    
    // MARK: - TableView Delegate (Optional)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == appointmentDetailTableView {
            print("Selected appointment row \(indexPath.row): \(appointments[indexPath.row])")
        }
    }
}

extension MedicationDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 // Example: 2 reports for now
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportCell", for: indexPath) as! ReportCollectionViewCell
        cell.imageView.image = UIImage(systemName: "doc.text") // Placeholder
        cell.uploadDate.text = indexPath.item == 0 ? "Dec 2023" : "Aug 2023"
        print("Configured ReportCollectionCell for item \(indexPath.item)")
        return cell
    }
}
