import UIKit

class SettingsViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var sections: [(header: String, items: [[String: String]])] = [
        ("", [["title": "Trisha Batta", "icon": "person.circle"]]),
        ("Health Details", [
            ["title": "Age", "icon": "", "value": "25"],  // Add "value" for age
            ["title": "Date Of Birth", "icon": "", "value": "01/01/2000"],
            ["title": "Sex", "icon": "Gender", "value": "Female"],
            ["title": "Blood Type", "icon": "Blood", "value": "O+"],
            ["title": "Allergies", "icon": "", "value": "None"],
            ["title": "Mobile Number", "icon": "", "value": "123-456-7890"],
            ["title": "Address", "icon": "", "value": "123 Main St"],
        ]),
        ("Privacy", [
            ["title": "Accounts", "icon": "gear"],
            ["title": "Accessibility", "icon": "figure.walk"],
            ["title": "Privacy & Security", "icon": "hand.raised"],
            ["title": "Notifications", "icon": "bell"]
        ]),
        ("", [["title": "Log Out", "icon": ""]])
    ]


    var selectedImage: UIImage? {
        didSet {
            if let image = selectedImage, let imageData = image.jpegData(compressionQuality: 1.0) {
                UserDefaults.standard.set(imageData, forKey: "profileImage")
            }
        }
    }

    var selectedName: String = "John" {
        didSet {
            UserDefaults.standard.set(selectedName, forKey: "userName")
            updateProfileInSettingsView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserProfile()
    }

    // MARK: - Load User Profile
    private func loadUserProfile() {
        if let profileImageData = UserDefaults.standard.data(forKey: "profileImage"),
           let profileImage = UIImage(data: profileImageData) {
            selectedImage = profileImage
        }

        if let storedUserName = UserDefaults.standard.string(forKey: "userName") {
            selectedName = storedUserName
        }

        updateProfileInSettingsView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
//        let item = sections[indexPath.section].items[indexPath.row]
//
//        cell.textLabel?.text = item["title"]
//
//        if indexPath.section == 0 && indexPath.row == 0 {
//            cell.imageView?.image = selectedImage ?? UIImage(named: "fav3")
//            cell.imageView?.layer.cornerRadius = 30
//            cell.imageView?.clipsToBounds = true
//        } else if indexPath.section == sections.count - 1 && indexPath.row == 0 { // Log Out button
//            cell.textLabel?.textColor = .systemRed
//            cell.textLabel?.textAlignment = .center
//            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//            cell.imageView?.image = nil // No icon for Log Out
//        } else if let icon = item["icon"], !icon.isEmpty {
//            cell.imageView?.image = UIImage(systemName: icon)
//        }
//
//        return cell
//    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        sectionHeader.backgroundColor = .clear  // Optional, to make background clear

        if !sections[section].header.isEmpty {
            let label = UILabel()
            label.text = sections[section].header
            label.font = UIFont.boldSystemFont(ofSize: 24)  // Set your desired font size
            label.textColor = .black  // Set text color (optional)
            label.translatesAutoresizingMaskIntoConstraints = false
            sectionHeader.addSubview(label)

            // Add constraints to label to position it within the header view
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: sectionHeader.leadingAnchor, constant: 16),
                label.trailingAnchor.constraint(equalTo: sectionHeader.trailingAnchor, constant: -16),
                label.topAnchor.constraint(equalTo: sectionHeader.topAnchor, constant: 8),
                label.bottomAnchor.constraint(equalTo: sectionHeader.bottomAnchor, constant: -8)
            ])
        }

        return sectionHeader
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 && indexPath.row == 0 {
            showChangeProfileAlert()
        } else if indexPath.section == sections.count - 1 && indexPath.row == 0 { // Log Out
            handleLogOut()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 80 // Profile cell height
        }
        return 44 // Default cell height
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header.isEmpty ? nil : sections[section].header
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].header.isEmpty ? 0 : 40
    }

    // MARK: - Show Change Profile Alert
    private func showChangeProfileAlert() {
        let alert = UIAlertController(title: "Edit Profile", message: "Update your name and picture", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = self.selectedName
        }

        alert.addAction(UIAlertAction(title: "Change Picture", style: .default, handler: { _ in
            self.selectProfileImage()
        }))

        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            if let newName = alert.textFields?.first?.text, !newName.isEmpty {
                self.selectedName = newName
//                self.updateUserProfile()
            }
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            self.selectedImage = image
            // Reload the first row to update the profile picture
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        dismiss(animated: true, completion: nil)
    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
//        let item = sections[indexPath.section].items[indexPath.row]
//
//        cell.textLabel?.text = item["title"]
//
//        if indexPath.section == 0 && indexPath.row == 0 {
//            cell.imageView?.image = selectedImage ?? UIImage(named: "fav3")  // Default image if none is selected
//            cell.imageView?.layer.cornerRadius = 30
//            cell.imageView?.clipsToBounds = true
//        } else if indexPath.section == sections.count - 1 && indexPath.row == 0 { // Log Out button
//            cell.textLabel?.textColor = .systemRed
//            cell.textLabel?.textAlignment = .center
//            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//            cell.imageView?.image = nil // No icon for Log Out
//        } else if let icon = item["icon"], !icon.isEmpty {
//            cell.imageView?.image = UIImage(systemName: icon)
//        }
//
//        return cell
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        let item = sections[indexPath.section].items[indexPath.row]

        cell.textLabel?.text = item["title"]

        // Check if the section is "Health Details" and the value is available
        if indexPath.section == 1 {
            if let value = item["value"], !value.isEmpty {
                cell.detailTextLabel?.text = value  // Set the value (Age, Blood Type, etc.)
            }
        }

        // Profile picture cell (first row in section 0)
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.imageView?.image = selectedImage ?? UIImage(named: "fav3")
            cell.imageView?.layer.cornerRadius = 30
            cell.imageView?.clipsToBounds = true
        } else if indexPath.section == sections.count - 1 && indexPath.row == 0 { // Log Out button
            
            //            cell.textLabel?.textColor = .systemRed
//            cell.textLabel?.textAlignment = .center
//            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            cell.imageView?.image = nil // No icon for Log Out
        } else if let icon = item["icon"], !icon.isEmpty {
//            cell.imageView?.image = UIImage(systemName: icon)
        }
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.detailTextLabel?.textColor = .gray

        return cell
    }

    // MARK: - Select Profile Image
    private func selectProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
//            self.selectedImage = image
//            
//        }
//        dismiss(animated: true, completion: nil)
//    }
    

    // MARK: - Update Profile
    private func updateProfileInSettingsView() {
        sections[0].items[0]["title"] = selectedName
        tableView.reloadData()
    }

    // MARK: - Log Out
    private func handleLogOut() {
        // Implement log-out functionality here
        print("Log Out tapped!")
    }
}
