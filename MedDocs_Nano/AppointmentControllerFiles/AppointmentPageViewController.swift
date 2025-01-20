import UIKit

class AppointmentPageViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var appointmentSortCollectionView: UICollectionView!
    @IBOutlet weak var appointmentDetailTableView: UITableView!

    // Sample data for appointments
    var appointments: [(name: String, doctor: String, date: String, status: AppointmentStatus)] = [
        ("Dental Checkup", "Dr. Smith", "20/01/2025", .pending),
        ("Eye Checkup", "Dr. Johnson", "18/01/2025", .visited),
        ("Physiotherapy", "Dr. Brown", "15/01/2025", .skipped),
        ("Skin Consultation", "Dr. Davis", "22/01/2025", .pending)
    ]

    // Filtered appointments for table view
    var filteredAppointments: [(name: String, doctor: String, date: String, status: AppointmentStatus)] = []

    // Variable to track the selected index
    var selectedCollectionIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize filtered appointments with all appointments
        filteredAppointments = appointments

        // Set delegates and data sources
        appointmentDetailTableView.delegate = self
        appointmentDetailTableView.dataSource = self
        appointmentSortCollectionView.delegate = self
        appointmentSortCollectionView.dataSource = self
        searchBar.delegate = self
    }
}

// MARK: - TableView DataSource and Delegate
extension AppointmentPageViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows in section: \(filteredAppointments.count)") // Debugging log
        return filteredAppointments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentMainPageNamesTableViewCell", for: indexPath) as! AppointmentMainPageNamesTableViewCell
        let appointment = filteredAppointments[indexPath.row]

        // Debugging logs
        print("Appointment for row \(indexPath.row): \(appointment.name), \(appointment.doctor), \(appointment.date), \(appointment.status.rawValue)")

        // Skip "Dr." and get the first two letters of the doctor's name
        let doctorName = appointment.doctor.replacingOccurrences(of: "Dr. ", with: "", options: .caseInsensitive)
        let firstTwoLetters = String(doctorName.prefix(2)).uppercased()

        if firstTwoLetters.isEmpty {
            cell.appointmentNameImageTextLabel.text = "-"
        } else {
            cell.appointmentNameImageTextLabel.text = firstTwoLetters
        }

        cell.appointmentNameLabel.text = appointment.doctor
        cell.appointmentDateLabel.text = appointment.date
        cell.appointmentStatusLabel.text = appointment.status.rawValue

        // Set the color of the status label based on the appointment status
        switch appointment.status {
        case .pending:
            cell.appointmentStatusLabel.textColor = UIColor.systemOrange
        case .visited:
            cell.appointmentStatusLabel.textColor = UIColor.systemGreen
        case .skipped:
            cell.appointmentStatusLabel.textColor = UIColor.systemRed
        }

        return cell
    }



    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - CollectionView DataSource and Delegate
extension AppointmentPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items in collection view: \(AppointmentStatus.allCases.count + 1)") // Debugging log
        return AppointmentStatus.allCases.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentStatusCollectionViewCell", for: indexPath) as! AppointmentStatusCollectionViewCell

        // Set the label text
        cell.appointmentSortNameLabel.text = indexPath.row == 0 ? "All" : AppointmentStatus.allCases[indexPath.row - 1].rawValue
        cell.appointmentSortNameLabel.textAlignment = .center

        // Apply styling for selected and non-selected cells
        if indexPath.row == selectedCollectionIndex {
            cell.backgroundColor = UIColor(red: 0.0, green: 0.69, blue: 0.73, alpha: 1.0) // #00AFB9
            cell.appointmentSortNameLabel.textColor = UIColor.white // Contrast text color
            cell.layer.borderWidth = 0 // No border for the selected cell
        } else {
            cell.backgroundColor = UIColor.white // Default background for non-selected cells
            cell.appointmentSortNameLabel.textColor = UIColor.black // Default text color
            cell.layer.borderWidth = 1 // Black border for non-selected cells
            cell.layer.borderColor = UIColor(red: 0.0, green: 0.69, blue: 0.73, alpha: 1.0).cgColor
        }

        // Apply corner radius for consistent styling
        cell.layer.cornerRadius = 8
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = indexPath.row == 0 ? "All" : AppointmentStatus.allCases[indexPath.row - 1].rawValue
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)

        return CGSize(width: size.width + 20, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCollectionIndex = indexPath.row
        print("Selected collection index: \(selectedCollectionIndex)") // Debugging log

        if indexPath.row == 0 {
            filteredAppointments = appointments
            print("Show all appointments")
        } else {
            let selectedStatus = AppointmentStatus.allCases[indexPath.row - 1]
            filteredAppointments = appointments.filter { $0.status == selectedStatus }
            print("Filtered appointments by status: \(selectedStatus.rawValue)")
        }

        appointmentSortCollectionView.reloadData()
        appointmentDetailTableView.reloadData()
    }
}

// MARK: - SearchBar Delegate
extension AppointmentPageViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        // Debugging log
        print("Search text: '\(trimmedSearchText)'")

        // Strip "Dr." prefix from the search text, if it exists
        let cleanSearchText = trimmedSearchText.replacingOccurrences(of: "dr.", with: "", options: .caseInsensitive).trimmingCharacters(in: .whitespacesAndNewlines)

        var searchResults = appointments

        // Apply search filter if there is search text
        if !cleanSearchText.isEmpty {
            searchResults = appointments.filter { appointment in
                // Remove "Dr." prefix from the doctor's name, if it exists
                let cleanDoctorName = appointment.doctor.replacingOccurrences(of: "dr.", with: "", options: .caseInsensitive).lowercased()

                let containsSearchText = cleanDoctorName.contains(cleanSearchText)

                // Debugging log for filtering each appointment by doctor's name
                print("Checking appointment with doctor: \(appointment.doctor), contains search text: \(containsSearchText)")

                return containsSearchText
            }
        }

        // Apply status filter (if any) on searchResults
        if selectedCollectionIndex != 0 {
            let selectedStatus = AppointmentStatus.allCases[selectedCollectionIndex - 1]
            searchResults = searchResults.filter { $0.status == selectedStatus }
            print("Filtered search results by status: \(selectedStatus.rawValue)")
        }

        // Update the filteredAppointments with the final searchResults
        filteredAppointments = searchResults

        // Debugging log for the final filtered appointments
        print("Final filtered appointments: \(filteredAppointments)")

        // Reload the table view with filtered appointments
        appointmentDetailTableView.reloadData()
    }
}
