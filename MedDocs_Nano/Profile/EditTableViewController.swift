import UIKit

protocol EditTableViewControllerDelegate: AnyObject {
    func didUpdateUserData(updatedUser: Personal)
}

class EditTableViewController: UITableViewController {
    weak var delegate: EditTableViewControllerDelegate?

    @IBOutlet weak var first: UITextField!
    @IBOutlet weak var last: UITextField!
    @IBOutlet weak var dateOfBirth: UIDatePicker!
    @IBOutlet weak var sex: UIButton! // Pull-down button for sex
    @IBOutlet weak var bloodType: UIButton!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var address: UITextField!

    @IBAction func saveButtonClicked(_ sender: Any) {
        let updatedUser = Personal(
            firstName: first.text ?? "",
            lastName: last.text ?? "",
            dateOfBirth: dateOfBirth.date,
            sex: sex.title(for: .normal) ?? "",
            bloodType: bloodType.title(for: .normal) ?? "",
            mobileNumber: mobile.text ?? "",
            address: address.text ?? ""
        )
        
        delegate?.didUpdateUserData(updatedUser: updatedUser)
        navigationController?.popViewController(animated: true)
    }

    var user: Personal?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = user {
            navigationItem.title = "Edit \(user.firstName)"
            first.text = user.firstName
            last.text = user.lastName
            dateOfBirth.date = user.dateOfBirth
            sex.setTitle(user.sex, for: .normal)
            bloodType.setTitle(user.bloodType, for: .normal)
            mobile.text = user.mobileNumber
            address.text = user.address
        }

        // Configure the pull-down menu for sex
        configureSexPullDownMenu()
        configureBloodTypePullDownMenu()
    }

    func configureSexPullDownMenu() {
        // Create menu actions for "Sex" options
        let maleOption = UIAction(title: "Male", image: UIImage(systemName: "person")) { _ in
            print("Male selected")
            self.sex.setTitle("Male", for: .normal)
        }
        
        let femaleOption = UIAction(title: "Female", image: UIImage(systemName: "person.fill")) { _ in
            print("Female selected")
            self.sex.setTitle("Female", for: .normal)
        }
        
        let otherOption = UIAction(title: "Other", image: UIImage(systemName: "questionmark.circle")) { _ in
            print("Other selected")
            self.sex.setTitle("Other", for: .normal)
        }
        
        // Create UIMenu for the "Sex" field
        let sexMenu = UIMenu(title: "Select Gender", children: [maleOption, femaleOption, otherOption])
        
        // Attach the menu to the button
        sex.menu = sexMenu
        sex.showsMenuAsPrimaryAction = true // Automatically shows the menu when tapped
        sex.changesSelectionAsPrimaryAction = false // Prevents automatic deselection of other options
    }
    func configureBloodTypePullDownMenu() {
            // Create menu actions for "Blood Type" options
            let bloodTypeOptions = [
                UIAction(title: "A+", image: nil) { _ in
                    print("A+ selected")
                    self.bloodType.setTitle("A+", for: .normal)
                },
                UIAction(title: "A-", image: nil) { _ in
                    print("A- selected")
                    self.bloodType.setTitle("A-", for: .normal)
                },
                UIAction(title: "B+", image: nil) { _ in
                    print("B+ selected")
                    self.bloodType.setTitle("B+", for: .normal)
                },
                UIAction(title: "B-", image: nil) { _ in
                    print("B- selected")
                    self.bloodType.setTitle("B-", for: .normal)
                },
                UIAction(title: "AB+", image: nil) { _ in
                    print("AB+ selected")
                    self.bloodType.setTitle("AB+", for: .normal)
                },
                UIAction(title: "AB-", image: nil) { _ in
                    print("AB- selected")
                    self.bloodType.setTitle("AB-", for: .normal)
                },
                UIAction(title: "O+", image: nil) { _ in
                    print("O+ selected")
                    self.bloodType.setTitle("O+", for: .normal)
                },
                UIAction(title: "O-", image: nil) { _ in
                    print("O- selected")
                    self.bloodType.setTitle("O-", for: .normal)
                }
            ]
            
            // Create UIMenu for the "Blood Type" field
            let bloodTypeMenu = UIMenu(title: "Select Blood Type", children: bloodTypeOptions)
            
            // Attach the menu to the button
            bloodType.menu = bloodTypeMenu
            bloodType.showsMenuAsPrimaryAction = true
            bloodType.changesSelectionAsPrimaryAction = false
        }
}
