import UIKit

class DisplayMedicationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var medication: Medication? // Medication object passed from MainMedicationViewController
    var details: [(title: String, detail: String)] = [] // Key-value data for table view

    @IBOutlet weak var tableView: UITableView!

   
        // Populate details array with medication data
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self

            if let medication = medication {
                details = [
                    ("Medication Name", medication.medicineName),
                    ("Hospital Name", medication.hospitalName),
                    ("Doctor Name", medication.doctorName),
                    ("Notes", medication.notes),
                    ("Frequency", medication.frequency.rawValue),
                    ("First Dose Time", formatTime(from: medication.dosage.first?.time)),
                    ("Second Dose Time", formatTime(from: medication.dosage.last?.time))
                ]
            } else {
                print("Medication is nil")
            }
            tableView.reloadData()
        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDisplayMedication" {
            if let displayMedicationVC = segue.destination as? DisplayMedicationViewController,
               let selectedMedication = sender as? Medication {
                print("Preparing to pass medication: \(selectedMedication.medicineName)")  // Debugging
                displayMedicationVC.medication = selectedMedication
            } else {
                print("Error: sender is not a valid Medication object")
            }
        }
    }

    

    // Helper to format time
    private func formatTime(from date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }

    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        let detail = details[indexPath.row]
        cell.textLabel?.text = detail.title
        cell.detailTextLabel?.text = detail.detail
        return cell
    }

    // MARK: - TableView Delegate (Optional)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Optional: Handle cell selection (e.g., show more details or edit)
    }
}
