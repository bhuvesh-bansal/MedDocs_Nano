import UIKit

// Define the AppointmentFive struct
struct AppointmentFive {
    var hospitalName: String
    var notes: String
    var date: Date
    var status: String
}

// Define the MedicationFive struct with an optional typeImage
struct MedicationFive {
    var typeImage: String?  // Optional typeImage, allowing it to be nil
    var medicineName: String
    var dosage: String
    var type: String
    var dateTime: String
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var AppointmentTable: UITableView!
    @IBOutlet weak var MedicationTable: UITableView!
    // Dummy data for Medications
    let medications: [MedicationFive] = [
        MedicationFive(typeImage: "pill", medicineName: "Paracetamol", dosage: "500mg", type: "Tablet", dateTime: "20 Jan 2025, 9:00 AM"),
        MedicationFive(typeImage: "waterbottle.fill", medicineName: "Torex", dosage: "10ml", type: "Liquid", dateTime: "27 Jan 2025, 9:30 AM")
    ]
    
    // Dummy data for Appointments
    var appointments: [AppointmentFive] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        generateDummyData()
        // Example UUID usage - Use a valid user UUID instead of UUID()
        appointments = [
            AppointmentFive(hospitalName: "City Hospital", notes: "Routine checkup", date: Date().addingTimeInterval(86400), status: "Pending"),
            AppointmentFive(hospitalName: "General Clinic", notes: "Annual health check-up", date: Date().addingTimeInterval(172800), status: "Visited")
        ]
        
        AppointmentTable.delegate = self
        AppointmentTable.dataSource = self
        
        MedicationTable.delegate = self
        MedicationTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reverse the appointments order and reload data
        self.appointments = appointments.reversed()
        self.AppointmentTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == AppointmentTable {
            return appointments.count
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
            let hospitalName = appointment.hospitalName
            cell.HospitalLabel.text = hospitalName.split(separator: " ").compactMap { $0.first }.map { String($0) }.joined()
            
            cell.HospitalName.text = appointment.hospitalName
            cell.Detail.text = appointment.notes

            let appointmentDate = appointment.date // Access the date from your appointment

            // Create a DateFormatter instance
            let dateFormatter = DateFormatter()

            // Format for "21 Jan"
            dateFormatter.dateFormat = "d MMM" // Day and abbreviated month
            
            let dateString = dateFormatter.string(from: appointmentDate)

            // Format for time (e.g., "10:30 AM")
            dateFormatter.dateFormat = "h:mm a" // Hour, minutes, and AM/PM
            let timeString = dateFormatter.string(from: appointmentDate)

            // Combine date and time (optional)
            let dateTimeString = "\(dateString) at \(timeString)"

            // Assign to label
            cell.AppointmentDateTime.text = dateTimeString
            return cell
            
        } else if tableView == MedicationTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Medicine", for: indexPath) as! MedicationTableViewCell
            let medication = medications[indexPath.row]
            
            // Set SF Symbol image for TypeImage
            if let typeImage = medication.typeImage {
                cell.TypeImage.image = UIImage(systemName: typeImage)  // Use SF Symbols
            }
            
            cell.MedicineName.text = medication.medicineName
            cell.Dosage.text = medication.dosage
            cell.Type.text = medication.type
            cell.MedicineDateTime.text = medication.dateTime
            return cell
        }
        return UITableViewCell()
    }
}
