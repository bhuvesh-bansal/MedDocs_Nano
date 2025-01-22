import UIKit

class AddMedicationTableViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var medicationNameTextField: UITextField!
    @IBOutlet weak var hospitalNameTextField: UITextField!
    @IBOutlet weak var doctorNameTextField: UITextField!
    @IBOutlet weak var appointmentName: UITextField! // Corrected name
    @IBOutlet weak var medicineTypeButton: UIButton!
    @IBOutlet weak var frequencyButton: UIButton!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var amountStepper: UIStepper!
    @IBOutlet weak var firstDoseTimeLabel: UILabel!
    @IBOutlet weak var secondDoseTimeLabel: UILabel!
    @IBOutlet weak var firstDoseTimePicker: UIDatePicker!
    @IBOutlet weak var secondDoseTimePicker: UIDatePicker!

    // MARK: - Properties
    var selectedMedicineType: MedicineType?
    var selectedFrequency: DosageFrequency?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMedicineTypeButton()
        configureFrequencyButton()

        // Set initial values for the stepper and text field
        amountStepper.value = 1
        amountTextField.text = "\(Int(amountStepper.value))"

        // Add targets for the stepper and text field
        amountStepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        amountTextField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)

        // Configure notesTextView placeholder behavior
        notesTextView.text = "Enter any additional instructions or comments here."
        notesTextView.textColor = .lightGray
        notesTextView.delegate = self

        // Set the mode of the date pickers to "Time" only
        firstDoseTimePicker.datePickerMode = .time
        secondDoseTimePicker.datePickerMode = .time

        // Initially hide the second dose picker
        secondDoseTimePicker.isHidden = true
    }

    // MARK: - Configuration Methods
    private func configureMedicineTypeButton() {
        let menuActions = MedicineType.allCases.map { type in
            UIAction(title: type.rawValue, handler: { [weak self] _ in
                self?.selectMedicineType(type)
            })
        }
        let menu = UIMenu(title: "Select Medicine Type", children: menuActions)
        medicineTypeButton.menu = menu
        medicineTypeButton.showsMenuAsPrimaryAction = true
    }

    private func configureFrequencyButton() {
        let menuActions = DosageFrequency.allCases.map { frequency in
            UIAction(title: frequency.rawValue, handler: { [weak self] _ in
                self?.selectFrequency(frequency)
            })
        }
        let menu = UIMenu(title: "Select Dosage Frequency", children: menuActions)
        frequencyButton.menu = menu
        frequencyButton.showsMenuAsPrimaryAction = true
    }

    // MARK: - Selection Methods
    private func selectMedicineType(_ type: MedicineType) {
        selectedMedicineType = type
        medicineTypeButton.setTitle(type.rawValue, for: .normal)
    }

    private func selectFrequency(_ frequency: DosageFrequency) {
        selectedFrequency = frequency
        frequencyButton.setTitle(frequency.rawValue, for: .normal)
    }

    // MARK: - Stepper and TextField Actions
    @objc func stepperValueChanged() {
        let stepperValue = Int(amountStepper.value)
        amountTextField.text = "\(stepperValue)"
    }

    @objc func textFieldValueChanged() {
        if let text = amountTextField.text, let value = Int(text) {
            amountStepper.value = Double(value)
        }
    }

    // MARK: - Time Picker Actions
    // MARK: - Time Picker Actions
    @IBAction func firstDoseTimeChanged(_ sender: UIDatePicker) {
        // Save the time to a property (for backend saving)
        let selectedFirstDoseTime = sender.date
        // Optionally, you can format the time before saving it to the backend
        let formattedFirstDoseTime = formatTime(from: selectedFirstDoseTime)
        
        // Save this data to the backend, or use it as needed
        // For example, use a model to store or pass this to a server.
        
        // Hide the second dose picker until the first dose is selected
        secondDoseTimePicker.isHidden = false
    }

    @IBAction func secondDoseTimeChanged(_ sender: UIDatePicker) {
        // Save the time to a property (for backend saving)
        let selectedSecondDoseTime = sender.date
        // Optionally, you can format the time before saving it to the backend
        let formattedSecondDoseTime = formatTime(from: selectedSecondDoseTime)
        
        // Save this data to the backend, or use it as needed
        // For example, use a model to store or pass this to a server.
    }


    // MARK: - Navigation
   

    // MARK: - Helper Methods
    private func formatTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
}

// MARK: - UITextViewDelegate
extension AddMedicationTableViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter any additional instructions or comments here."
            textView.textColor = .lightGray
        }
    }
}
