////
////  HomeScreenViewController.swift
////  MedDocs_Nano
////
////  Created by Vansh Sharma on 17/01/25.
////
//
//import UIKit
//
//class HomeScreenViewController: UIViewController {
//
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

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var greetingSubLabel: UILabel!
    @IBOutlet weak var addAppointmentButton: UIButton!
    @IBOutlet weak var addMedicationButton: UIButton!
    @IBOutlet weak var addReportButton: UIButton!
    @IBOutlet weak var appointmentsTableView: UITableView!
    @IBOutlet weak var medicationsTableView: UITableView!
    
    // Data arrays for TableView
    var appointments: [Appoint] = [
        Appoint(hospitalName: "Neelam Hospital", description: "Shoulder ligament tear", date: "27/12/2024", time: "4:00 PM"),
        Appoint(hospitalName: "City Hospital", description: "High blood pressure", date: "13/01/2025", time: "11:00 AM")
    ]
    
    var medications: [Medicat] = [
        Medicat(name: "Paracetamol Tablet", dosage: "1 mg", date: "27/12/2024", time: "9:00 AM"),
        Medicat(name: "Cough Syrup", dosage: "Liquid", date: "27/12/2024", time: "1:00 PM")
    ]

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup TableView
        appointmentsTableView.dataSource = self
        appointmentsTableView.delegate = self
        medicationsTableView.dataSource = self
        medicationsTableView.delegate = self
        
    }
    
    // MARK: - Actions
    @IBAction func addAppointmentTapped(_ sender: UIButton) {
        print("Add Appointment tapped")
    }
    
    @IBAction func addMedicationTapped(_ sender: UIButton) {
        print("Add Medication tapped")
    }
    
    @IBAction func addReportTapped(_ sender: UIButton) {
        print("Add Report tapped")
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == appointmentsTableView {
            return appointments.count
        } else if tableView == medicationsTableView {
            return medications.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == appointmentsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath)
            let appointment = appointments[indexPath.row]
            cell.textLabel?.text = "\(appointment.hospitalName) - \(appointment.description) (\(appointment.date), \(appointment.time))"
            return cell
        } else if tableView == medicationsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath)
            let medication = medications[indexPath.row]
            cell.textLabel?.text = "\(medication.name) \(medication.dosage) (\(medication.date), \(medication.time))"
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - Models
struct Appoint {
    let hospitalName: String
    let description: String
    let date: String
    let time: String
}

struct Medicat {
    let name: String
    let dosage: String
    let date: String
    let time: String
}
