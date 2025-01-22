//import UIKit
//
//class AddAppointmentViewController: UIViewController {
//
//    @IBOutlet weak var hospitalNameTextField: UITextField!
//    @IBOutlet weak var doctorNameTextField: UITextField!
//    @IBOutlet weak var notesTextLabel: UITextField!
//    @IBOutlet weak var dateTimeTableView: UITableView!
//
//    @IBOutlet weak var medicationNameTextField: UITextField!
//    @IBOutlet weak var medicationDetailTableView: UITableView!
//
//    @IBOutlet weak var reportNameTextField: UITextField!
//    @IBOutlet weak var reportDetailTableView: UITableView!
//
////    var appointmentDetails: Appointment4 = Appointment4(clinic: "City Hospital", notes: "Follow-up consultation", status: "Pending", date: Date())  // Modified struct name
//    var medicationDetails: [Medication4] = [Medication4(name: "Paracetamol", type: "Tablet", dosage: "500 mg", frequency: "Everyday", startDate: Date(), notes: "For fever")]  // Modified struct name
//    var reportDetails: [Report4] = [Report4(title: "Blood Test", imageUrl: "https://example.com/blood_test.jpg", date: Date(), notes: "Routine blood work")]  // Modified struct name
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Populate the text fields with appointment data
//        hospitalNameTextField.text = appointmentDetails.clinic
//        doctorNameTextField.text = "Dr. Smith"  // Dummy name
//        notesTextLabel.text = appointmentDetails.notes
//
//        // Setup table views
//        dateTimeTableView.delegate = self
//        dateTimeTableView.dataSource = self
//
//        medicationNameTextField.text = medicationDetails.first?.name
//
//        medicationDetailTableView.delegate = self
//        medicationDetailTableView.dataSource = self
//        
//        reportNameTextField.text = reportDetails.first?.title
//        
//        reportDetailTableView.delegate = self
//        reportDetailTableView.dataSource = self
//    }
//}
//
//extension AddAppointmentViewController: UITableViewDelegate, UITableViewDataSource {
//
//    // For Appointment Dates/Times Table View
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == dateTimeTableView {
//            return 1  // Example, you could list appointment times here
//        } else if tableView == medicationDetailTableView {
//            return medicationDetails.count
//        } else if tableView == reportDetailTableView {
//            return reportDetails.count
//        }
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == dateTimeTableView {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "DateTimeCell", for: indexPath)
//            cell.textLabel?.text = "Appointment Date: \(appointmentDetails.date)"
//            return cell
//        } else if tableView == medicationDetailTableView {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationDetailCell", for: indexPath)
//            let medication = medicationDetails[indexPath.row]
//            cell.textLabel?.text = "\(medication.name) - \(medication.dosage)"
//            return cell
//        } else if tableView == reportDetailTableView {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ReportDetailCell", for: indexPath)
//            let report = reportDetails[indexPath.row]
//            cell.textLabel?.text = report.title
//            return cell
//        }
//        return UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44.0  // Adjust as needed for your content
//    }
//}
//
//// Dummy Models for Appointment, Medication, and Report
//struct Appointment4 {
//    var clinic: String
//    var notes: String
//    var status: String
//    var date: Date
//}
//
//struct Medication4 {
//    var name: String
//    var type: String
//    var dosage: String
//    var frequency: String
//    var startDate: Date
//    var notes: String
//}
//
//struct Report4 {
//    var title: String
//    var imageUrl: String
//    var date: Date
//    var notes: String
//}
