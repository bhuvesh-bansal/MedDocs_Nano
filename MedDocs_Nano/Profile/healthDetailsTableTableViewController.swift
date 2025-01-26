import UIKit

struct Personal {
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var sex: String
    var bloodType: String
    var mobileNumber: String
    var address: String
}

class healthDetailsTableTableViewController: UITableViewController, EditTableViewControllerDelegate {

    // MARK: - Delegate Method
    func didUpdateUserData(updatedUser: Personal) {
        // Update the UI with the new data
        firstName.text = updatedUser.firstName
        lastName.text = updatedUser.lastName
        
        // Format and display the updated date of birth
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateOfBirth.text = dateFormatter.string(from: updatedUser.dateOfBirth)
        
        sex.text = updatedUser.sex
        bloodType.text = updatedUser.bloodType
        mobile.text = updatedUser.mobileNumber
        address.text = updatedUser.address
    }

    
    @IBOutlet weak var dateOfBirth: UILabel!
    
    // MARK: - Outlets
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel! // Changed to UILabel
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var bloodType: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var address: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditTableViewController {
            destination.delegate = self
            
            // Pass current user data to the EditTableViewController
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let parsedDate = dateFormatter.date(from: dateOfBirth.text ?? "") ?? Date()
            
            destination.user = Personal(
                firstName: firstName.text ?? "",
                lastName: lastName.text ?? "",
                dateOfBirth: parsedDate,
                sex: sex.text ?? "",
                bloodType: bloodType.text ?? "",
                mobileNumber: mobile.text ?? "",
                address: address.text ?? ""
            )
        }
    }
}
