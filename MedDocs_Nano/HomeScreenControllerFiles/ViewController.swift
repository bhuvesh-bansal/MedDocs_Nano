//
//  ViewController.swift
//  HomeScreen_MedDocs
//
//  Created by Vansh Sharma on 20/01/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var AppointmentTable: UITableView!
    @IBOutlet weak var MedicationTable: UITableView!
    
   

            // Add some dummy data for testing

    
    // Sample data for Appointments
//    let appointments = [
//        ["hospitalLabel": "Hospital A", "hospitalName": "Neelam Hospital", "detail": "Shoulder ligament tear", "dateTime": "22Jan2025 10:00AM"],
//        ["hospitalLabel": "Hospital B", "hospitalName": "City Hospital", "detail": "High blood pressure", "dateTime": "25Jan2025 2:00PM"]
//    ]
    
    
            
    
    // Sample data for Medications
    let medications = [
        ["typeImage": "pill", "medicineName": "Paracetamol", "dosage": "500mg", "type": "Tablet", "dateTime": "20 Jan 2025, 9:00 AM"],
        ["typeImage": "waterbottle.fill", "medicineName": "Torex", "dosage": "10ml", "type": "Liquid", "dateTime": "27Jan2025 9:30AM"]
    ]
    
    var appointments = AppointmentDataModel.sharedAppointmentData.getAppointments()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appointments = AppointmentDataModel.sharedAppointmentData.getAppointments()
        
        AppointmentTable.delegate = self
        AppointmentTable.dataSource = self
        
        MedicationTable.delegate = self
        MedicationTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload your appointments data
        self.appointments = AppointmentDataModel.sharedAppointmentData.getAppointments().reversed()
        self.AppointmentTable.reloadData()
    }

    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == AppointmentTable {
            
            if(appointments.count <= 2) {
                return appointments.count
            }
            else{
                 return 2;
            }
            
                
        } else if tableView == MedicationTable {
            return medications.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == AppointmentTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Appointment", for: indexPath) as! AppointmentTableViewCell
            let appointment = appointments[indexPath.row]
            
            // Extract first initials for the HospitalLabel
            let hospitalName = appointment.clinicName
            
                cell.HospitalLabel.text = hospitalName.split(separator: " ").compactMap { $0.first }.map { String($0) }.joined()
            
            
            cell.HospitalName.text = appointment.clinicName
            cell.Detail.text = appointment.doctorName

            let appointmentDate = appointment.date // Access the date from your appointment
            
            let appointmentTime = appointment.time

            // Create a DateFormatter instance
            let dateFormatter = DateFormatter()

            // Format for "21 Jan"
            dateFormatter.dateFormat = "d MMM" // Day and abbreviated month
            let dateString = dateFormatter.string(from: appointmentDate)

            // Format for time (e.g., "10:30 AM")
            dateFormatter.dateFormat = "h:mm a" // Hour, minutes, and AM/PM
            let timeString = dateFormatter.string(from: appointmentTime)

            // Combine date and time (optional)
            let dateTimeString = "\(dateString) at \(timeString)"

            // Assign to label
            cell.AppointmentDateTime.text = dateTimeString
            return cell
            
        } else if tableView == MedicationTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Medicine", for: indexPath) as! MedicationTableViewCell
            let medication = medications[indexPath.row]
            
            // Set SF Symbol image for TypeImage
            if let typeImage = medication["typeImage"] {
                cell.TypeImage.image = UIImage(systemName: typeImage)  // Use SF Symbols
            }
            
            cell.MedicineName.text = medication["medicineName"]
            cell.Dosage.text = medication["dosage"]
            cell.Type.text = medication["type"]
            cell.MedicineDateTime.text = medication["dateTime"]
            return cell
        }
        return UITableViewCell()
    }
}
