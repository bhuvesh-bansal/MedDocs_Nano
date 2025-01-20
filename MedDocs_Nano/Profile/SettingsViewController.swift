//import UIKit
//
//class SettingsViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    var sections: [(header: String, items: [[String: String]])] = [
//        ("", [["title": "Tushar Goyal", "icon": "person.circle"]]),
//        ("General", [
//            ["title": "Activity", "icon": "hourglass"],
//            ["title": "Accounts", "icon": "gear"],
//            ["title": "Accessibility", "icon": "figure.walk"],
//            ["title": "Privacy & Security", "icon": "hand.raised"],
//            ["title": "Notifications", "icon": "bell"]
//        ]),
//        ("Appearance", [
//            ["title": "Body Structure", "icon": "figure.stand"],
//            ["title": "Skin Tone", "icon": "paintpalette"]
//        ]),
//        ("Saved Content", [
//            ["title": "Saved", "icon": "folder"],
//            ["title": "Archive", "icon": "archivebox"],
//            ["title": "Blocked", "icon": "hand.raised.fill"],
//            ["title": "Outfit History", "icon": "clock"],
//            ["title": "OOTD History", "icon": "clock"]
//        ]),
//        ("", [["title": "Log Out", "icon": ""]])
//    ]
//
//    var selectedImage: UIImage? {
//        didSet {
//            if let image = selectedImage, let imageData = image.jpegData(compressionQuality: 1.0) {
//                UserDefaults.standard.set(imageData, forKey: "profileImage")
//            }
//            updateProfileInSettingsView() // Update immediately after setting image
//        }
//    }
//
//    var selectedName: String = "Tushar Goyal" {
//        didSet {
//            UserDefaults.standard.set(selectedName, forKey: "userName")
//            updateProfileInSettingsView()
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        loadUserProfile()
//    }
//
//    // MARK: - Load User Profile
//    private func loadUserProfile() {
//        if let profileImageData = UserDefaults.standard.data(forKey: "profileImage"),
//           let profileImage = UIImage(data: profileImageData) {
//            selectedImage = profileImage
//        }
//
//        if let storedUserName = UserDefaults.standard.string(forKey: "userName") {
//            selectedName = storedUserName
//        }
//
//        updateProfileInSettingsView()
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sections[section].items.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
//        let item = sections[indexPath.section].items[indexPath.row]
//
//        cell.textLabel?.text = item["title"]
//
//        if indexPath.section == 0 && indexPath.row == 0 {
//            cell.imageView?.image = selectedImage ?? UIImage(named: "sweater")
//            cell.imageView?.layer.cornerRadius = 30
//            cell.imageView?.clipsToBounds = true
//        } else if let icon = item["icon"], !icon.isEmpty {
//            cell.imageView?.image = UIImage(systemName: icon)
//        }
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        if indexPath.section == 0 && indexPath.row == 0 {
//            showChangeProfileAlert()
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        // Set the height for the first cell in the first section
//        if indexPath.section == 0 && indexPath.row == 0 {
//            return 80 // Adjust this value for the desired height
//        }
//        
//        // Default height for other cells
//        return 44 // Standard height for UITableView cells
//    }
//
//    // MARK: - Show Change Profile Alert
//    private func showChangeProfileAlert() {
//        let alert = UIAlertController(title: "Edit Profile", message: "Update your name and picture", preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.text = self.selectedName
//        }
//
//        alert.addAction(UIAlertAction(title: "Change Picture", style: .default, handler: { _ in
//            self.selectProfileImage()
//        }))
//
//        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
//            if let newName = alert.textFields?.first?.text, !newName.isEmpty {
//                self.selectedName = newName
//                self.updateUserProfile()
//            }
//        }))
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//
//    // MARK: - Select Profile Image
//    private func selectProfileImage() {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.allowsEditing = true
//        present(imagePicker, animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
//            self.selectedImage = image
//        }
//        dismiss(animated: true, completion: nil)
//    }
//
//    // MARK: - Update Profile
//    private func updateProfileInSettingsView() {
//        sections[0].items[0]["title"] = selectedName
//        tableView.reloadData()
//    }
//
//    private func updateUserProfile() {
//        if let profileVC = navigationController?.viewControllers.first(where: { $0 is userProfileViewController }) as? userProfileViewController {
//            profileVC.updateProfile(name: selectedName, image: selectedImage)
//        }
//    }
//}
