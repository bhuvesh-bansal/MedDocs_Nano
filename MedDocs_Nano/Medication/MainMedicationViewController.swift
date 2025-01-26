import UIKit

class MainMedicationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, AddMedicationDelegate {
    
    var medications: [Medication] = []
    var filteredMedications: [Medication] = [] // Array to store filtered medications
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar! // Use the IBOutlet connected to the storyboard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set the search bar delegate
        searchBar.delegate = self
        filteredMedications = medications // Initially, show all medications
    }

    // TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMedications.count // Use filtered medications
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath) as? MedicationDetailTableViewCell else {
            return UITableViewCell()
        }
        
        let medication = filteredMedications[indexPath.row] // Use filtered medications
        cell.medicationNameLabel.text = medication.medicineName
        cell.medicineTypeLabel.text = "Type: \(medication.type.rawValue)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        cell.startDateLabel.text = "Start Date: \(dateFormatter.string(from: medication.startDate))"
        
        // Display first and second dose times
        dateFormatter.dateFormat = "hh:mm a"
//        if let firstDoseTime = medication.firstDoseTime {
//            cell.startTimeLabel.text = "First Dose: \(dateFormatter.string(from: firstDoseTime))"
//        }
//        if let secondDoseTime = medication.{
//            cell.secondDoseTimeLabel.text = "Second Dose: \(dateFormatter.string(from: secondDoseTime))"
//        }

        return cell
    }


    // AddMedicationDelegate Method
    func didAddMedication(_ medication: Medication) {
        medications.append(medication)
        filteredMedications.append(medication) // Add the new medication to the filtered list
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDisplayMedication" { // Use the correct identifier from the storyboard
            if let displayMedicationVC = segue.destination as? DisplayMedicationViewController,
               let selectedMedication = sender as? Medication {
                displayMedicationVC.medication = selectedMedication
            }
        } else if let addMedicationVC = segue.destination as? AddMedicationTableTableViewController {
            addMedicationVC.delegate = self  // Set the delegate to MainMedicationViewController
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMedication = filteredMedications[indexPath.row]
        performSegue(withIdentifier: "ShowDisplayMedication", sender: selectedMedication)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Set the height of the cell to 120
    }

    // UISearchBarDelegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredMedications = medications // Show all if search text is empty
        } else {
            filteredMedications = medications.filter { medication in
                return medication.medicineName.lowercased().contains(searchText.lowercased()) // Case insensitive search
            }
        }
        tableView.reloadData() // Reload table view with filtered data
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Dismiss keyboard when search button is clicked
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filteredMedications = medications // Reset to all medications if cancel button is clicked
        tableView.reloadData()
    }
}
