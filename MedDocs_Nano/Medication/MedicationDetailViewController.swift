////
////  MedicationDetailViewController.swift
////  MedDocs_Nano
////
//  Created by TRISHA on 20/01/25.
//

import UIKit

class MedicationDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var tableView: UITableView!
    
    var medication: Medication?

        override func viewDidLoad() {
            super.viewDidLoad()
            setupTableView()
        }

        private func setupTableView() {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "medicationDetailTableViewcell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        }
    @IBOutlet weak var reportDetailsCollectionView: UICollectionView!
    @IBOutlet weak var appointmentDetailTableView: UITableView!
//    var medications: Medication =
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 6 // Number of fields to display
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? DisplayMedicationTableViewCell else {
                return UITableViewCell()
            }

            guard let medication = medication else { return cell }

            // Configure the cell with title and detail
            switch indexPath.row {
            case 0:
                cell.titleLabel.text = "Name"
                cell.detailLabel.text = medication.medicineName
            case 1:
                cell.titleLabel.text = "Type"
                cell.detailLabel.text = medication.type.rawValue
            case 2:
                cell.titleLabel.text = "Frequency"
                cell.detailLabel.text = medication.frequency.rawValue
            case 3:
                cell.titleLabel.text = "Start Date"
                /*cell.detailLabel.text = formatDate(medication.startDate)*/
            case 4:
                cell.titleLabel.text = "Notes"
                cell.detailLabel.text = medication.notes
            case 5:
                cell.titleLabel.text = "Doctor"
                cell.detailLabel.text = medication.doctorName
            default:
                break
            }
            return cell
        }

}
