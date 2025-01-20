import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()

    // Data for the sections
    let appointments = [
        ("Neelam Hospital", "Shoulder ligament tear", "12 Jan 2025, 3:00 PM"),
        ("City Hospital", "High blood pressure", "14 Jan 2025, 11:00 AM")
    ]

    let medications = [
        ("Paracetamol", "Tablet", "1mg", "12 Jan 2025, 8:00 AM", "capsule"),
        ("Cough Syrup", "Liquid", "100ml", "12 Jan 2025, 8:00 PM", "syrup")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Ensure the ViewController is embedded in a UINavigationController
        if self.navigationController == nil {
            let navigationController = UINavigationController(rootViewController: self)
            present(navigationController, animated: true, completion: nil)
        }

        // Define the screen bounds
        let screenHeight = min(view.bounds.height, 768) // Maximum height: 769
        let tableViewTopMargin: CGFloat = 360          // Start 400 points from the top
        let tableViewHeight = screenHeight - tableViewTopMargin

        // Configure the table view
        tableView.frame = CGRect(x: 0, y: tableViewTopMargin, width: view.bounds.width, height: tableViewHeight)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AppointmentCell.self, forCellReuseIdentifier: "AppointmentCell")
        tableView.register(MedicationCell.self, forCellReuseIdentifier: "MedicationCell")

        // Add the table view to the view
        view.addSubview(tableView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // Two sections: Appointments and Medications
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? appointments.count : medications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentCell
            let appointment = appointments[indexPath.row]
            cell.configure(with: appointment)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath) as! MedicationCell
            let medication = medications[indexPath.row]
            cell.configure(with: medication)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .white

        let label = UILabel(frame: CGRect(x: 16, y: 10, width: tableView.frame.width - 100, height: 30))
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = section == 0 ? "Your Appointments" : "Your Medications"
        headerView.addSubview(label)

        let button = UIButton(frame: CGRect(x: tableView.frame.width - 90, y: 10, width: 80, height: 30))
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        headerView.addSubview(button)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// Custom UITableViewCell for Appointments
class AppointmentCell: UITableViewCell {
    let iconView = UIView()
    let hospitalNameLabel = UILabel()
    let detailLabel = UILabel()
    let dateTimeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Configure the icon view
        iconView.frame = CGRect(x: 16, y: 25, width: 50, height: 50)
        iconView.backgroundColor = .systemTeal
        iconView.layer.cornerRadius = 25
        iconView.clipsToBounds = true
        contentView.addSubview(iconView)

        // Configure the hospital name label
        hospitalNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        hospitalNameLabel.frame = CGRect(x: 80, y: 10, width: contentView.frame.width - 100, height: 20)
        contentView.addSubview(hospitalNameLabel)

        // Configure the detail label
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.textColor = .darkGray
        detailLabel.frame = CGRect(x: 80, y: 35, width: contentView.frame.width - 100, height: 20)
        contentView.addSubview(detailLabel)

        // Configure the date/time label
        dateTimeLabel.font = UIFont.systemFont(ofSize: 12)
        dateTimeLabel.textColor = .gray
        dateTimeLabel.textAlignment = .right
        dateTimeLabel.frame = CGRect(x: contentView.frame.width - 150, y: 70, width: 140, height: 20)
        contentView.addSubview(dateTimeLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with appointment: (String, String, String)) {
        let initials = appointment.0.components(separatedBy: " ").compactMap { $0.first }.map { String($0) }.joined()
        let initialsLabel = UILabel(frame: iconView.bounds)
        initialsLabel.text = initials
        initialsLabel.textColor = .white
        initialsLabel.textAlignment = .center
        initialsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        iconView.addSubview(initialsLabel)

        hospitalNameLabel.text = appointment.0
        detailLabel.text = appointment.1
        dateTimeLabel.text = appointment.2
    }
}

// Custom UITableViewCell for Medications
class MedicationCell: UITableViewCell {
    let iconView = UIView()
    let medicineNameLabel = UILabel()
    let typeLabel = UILabel()
    let dosageLabel = UILabel()
    let dateTimeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Configure the icon view
        iconView.frame = CGRect(x: 16, y: 15, width: 70, height: 70)
        iconView.layer.cornerRadius = 35
        iconView.clipsToBounds = true
        contentView.addSubview(iconView)

        // Configure the medicine name label
        medicineNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        medicineNameLabel.frame = CGRect(x: 100, y: 10, width: contentView.frame.width - 120, height: 20)
        contentView.addSubview(medicineNameLabel)

        // Configure the type label
        typeLabel.font = UIFont.systemFont(ofSize: 14)
        typeLabel.textColor = .darkGray
        typeLabel.frame = CGRect(x: 100, y: 35, width: contentView.frame.width - 120, height: 20)
        contentView.addSubview(typeLabel)

        // Configure the dosage label
        dosageLabel.font = UIFont.systemFont(ofSize: 14)
        dosageLabel.textColor = .darkGray
        dosageLabel.frame = CGRect(x: 100, y: 55, width: contentView.frame.width - 120, height: 20)
        contentView.addSubview(dosageLabel)

        // Configure the date/time label
        dateTimeLabel.font = UIFont.systemFont(ofSize: 12)
        dateTimeLabel.textColor = .gray
        dateTimeLabel.textAlignment = .right
        dateTimeLabel.frame = CGRect(x: contentView.frame.width - 150, y: 75, width: 140, height: 20)
        contentView.addSubview(dateTimeLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with medication: (String, String, String, String, String)) {
        let initials = medication.0.components(separatedBy: " ").compactMap { $0.first }.map { String($0) }.joined()
        let initialsLabel = UILabel(frame: iconView.bounds)
        initialsLabel.text = initials
        initialsLabel.textColor = .white
        initialsLabel.textAlignment = .center
        initialsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        iconView.addSubview(initialsLabel)

        medicineNameLabel.text = medication.0
        typeLabel.text = medication.1
        dosageLabel.text = medication.2
        dateTimeLabel.text = medication.3
    }
}


