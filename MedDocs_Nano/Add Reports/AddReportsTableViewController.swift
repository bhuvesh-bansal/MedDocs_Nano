import UIKit

protocol AddReportDelegate: AnyObject {
    func didAddReport(_ report: Report)
}

class AddReportsTableViewController: UITableViewController,
                                   UIImagePickerControllerDelegate,
                                   UINavigationControllerDelegate,
                                   UITextViewDelegate,
                                   UIPickerViewDelegate,
                                   UIPickerViewDataSource,
                                   UICollectionViewDelegate,
                                   UICollectionViewDataSource {
    
    
    
    // MARK: - IBOutlets
   // weak var delegate: AddReportDelegate?
    @IBOutlet weak var reportNameTextField: UITextField!
    @IBOutlet weak var hospitalNameTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var appointmentNameTextField: UITextField!
    @IBOutlet weak var medicationNameTextField: UITextField!
    
    

        // MARK: - Properties
        weak var addReportDelegate: AddReportDelegate?
        var onReportAdded: ((Report) -> Void)?
        private var reports: [Report] = []
        private let hospitalPicker = UIPickerView()
        private let appointmentPicker = UIPickerView()
        
        private let reportDataModel = ReportDataModel.sharedReportData
        private let hospitalDataModel = HospitalDataModel.sharedHospitalData
    
    
    
    
    // Update the hospitals array initialization
    private var hospitals: [Hospital] = [
        Hospital(id: UUID(), hospitalName: "Neelam Hospital", tags: []),
        Hospital(id: UUID(), hospitalName: "City Hospital", tags: [])
    ]
        
        private var appointments = [
            "Neelam Hospital",
            "City Hospital"
        ]
        
        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupNotesTextView()
            setupCollectionView()
            setupHospitalPicker()
            setupAppointmentPicker()
        }
        
        // MARK: - Setup Methods
        private func setupUI() {
            title = "Add Report"
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Save",
                style: .done,
                target: self,
                action: #selector(saveButtonTapped)
            )
        }
        
        private func setupNotesTextView() {
            notesTextView.text = "Enter any additional details here."
            notesTextView.textColor = .lightGray
            notesTextView.delegate = self
            notesTextView.layer.borderColor = UIColor.systemGray4.cgColor
            notesTextView.layer.borderWidth = 1
            notesTextView.layer.cornerRadius = 8
        }
        
        private func setupHospitalPicker() {
            hospitalPicker.delegate = self
            hospitalPicker.dataSource = self
            
            hospitalNameTextField.inputView = hospitalPicker
            
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hospitalPickerDoneButtonTapped))
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            toolbar.setItems([flexSpace, doneButton], animated: false)
            hospitalNameTextField.inputAccessoryView = toolbar
            
            if !hospitals.isEmpty {
                hospitalNameTextField.text = hospitals[0].hospitalName
            }
        }
        
        private func setupAppointmentPicker() {
            appointmentPicker.delegate = self
            appointmentPicker.dataSource = self
            
            appointmentNameTextField.inputView = appointmentPicker
            
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(appointmentPickerDoneButtonTapped))
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            toolbar.setItems([flexSpace, doneButton], animated: false)
            appointmentNameTextField.inputAccessoryView = toolbar
            
            if !appointments.isEmpty {
                appointmentNameTextField.text = appointments[0]
            }
        }
        
        private func setupCollectionView() {
            tableView.reloadData()
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                if let reportsCell = self.tableView.cellForRow(at: IndexPath(row: 3, section: 0)) {
                    if reportsCell.contentView.viewWithTag(100) == nil {
                        let layout = UICollectionViewFlowLayout()
                        layout.scrollDirection = .horizontal
                        layout.itemSize = CGSize(width: 120, height: 150)
                        layout.minimumInteritemSpacing = 0
                        layout.minimumLineSpacing = 5
                        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
                        
                        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                        collectionView.tag = 100
                        collectionView.backgroundColor = .systemBackground
                        collectionView.delegate = self
                        collectionView.dataSource = self
                        collectionView.register(ReportCollectionViewCell.self,
                                              forCellWithReuseIdentifier: ReportCollectionViewCell.identifier)
                        collectionView.showsHorizontalScrollIndicator = false
                        
                        let addButton = UIButton(type: .system)
                        addButton.setTitle("Add", for: .normal)
                        addButton.setTitleColor(UIColor(red: 0/255, green: 175/255, blue: 185/255, alpha: 1.0), for: .normal)
                        addButton.addTarget(self, action: #selector(addReportButtonTapped), for: .touchUpInside)
                        reportsCell.contentView.addSubview(addButton)
                        
                        reportsCell.contentView.addSubview(collectionView)
                        
                        addButton.translatesAutoresizingMaskIntoConstraints = false
                        collectionView.translatesAutoresizingMaskIntoConstraints = false
                        
                        NSLayoutConstraint.activate([
                            addButton.topAnchor.constraint(equalTo: reportsCell.contentView.topAnchor, constant: 8),
                            addButton.trailingAnchor.constraint(equalTo: reportsCell.contentView.trailingAnchor, constant: -16),
                            
                            collectionView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 8),
                            collectionView.leadingAnchor.constraint(equalTo: reportsCell.contentView.leadingAnchor, constant: 8),
                            collectionView.trailingAnchor.constraint(equalTo: reportsCell.contentView.trailingAnchor, constant: -8),
                            collectionView.bottomAnchor.constraint(equalTo: reportsCell.contentView.bottomAnchor, constant: -8),
                            collectionView.heightAnchor.constraint(equalToConstant: 150)
                        ])
                    }
                }
            }
        }
    // Add these methods to your class

    @objc private func hospitalPickerDoneButtonTapped() {
        let selectedRow = hospitalPicker.selectedRow(inComponent: 0)
        hospitalNameTextField.text = hospitals[selectedRow].hospitalName
        view.endEditing(true)
    }

    @objc private func appointmentPickerDoneButtonTapped() {
        let selectedRow = appointmentPicker.selectedRow(inComponent: 0)
        appointmentNameTextField.text = appointments[selectedRow]
        view.endEditing(true)
    }
    
        
        // MARK: - Actions
//        @objc private func saveButtonTapped() {
//            guard validateInputs() else { return }
//            
//            let notes = notesTextView.textColor == .lightGray ? "" : notesTextView.text
//            
//            let newReport = reportDataModel.addReport(
//                path: reportNameTextField.text ?? "",
//                time: Date(),
//                date: Date(),
//                reportType: .jpg
//            )
//            
//            addReportDelegate?.didAddReport(newReport)
//            onReportAdded?(newReport)
//            
//            navigationController?.popViewController(animated: true)
//        }
//        
//        @objc private func hospitalPickerDoneButtonTapped() {
//            let selectedRow = hospitalPicker.selectedRow(inComponent: 0)
//            hospitalNameTextField.text = hospitals[selectedRow].hospitalName
//            view.endEditing(true)
//        }
//        
//        @objc private func appointmentPickerDoneButtonTapped() {
//            let selectedRow = appointmentPicker.selectedRow(inComponent: 0)
//            appointmentNameTextField.text = appointments[selectedRow]
//            view.endEditing(true)
//        }
//
    @objc private func saveButtonTapped() {
        // Validate required fields
        guard let reportName = reportNameTextField.text, !reportName.isEmpty,
              let hospitalName = hospitalNameTextField.text, !hospitalName.isEmpty else {
            showAlert(message: "Please fill in all required fields")
            return
        }
        
        // Check if at least one report is added
        guard !reports.isEmpty else {
            showAlert(message: "Please add at least one report image")
            return
        }
        
        // Get notes (if any)
        let notes = notesTextView.textColor == .lightGray ? "" : notesTextView.text
        
        // Get appointment name (optional)
        let appointmentName = appointmentNameTextField.text
        
        // Get medication name (optional)
        let medicationName = medicationNameTextField.text
        
//        // Create or find hospital
//        let hospital = hospitals.first { $0.hospitalName == hospitalName } ??
//            hospitalDataModel.addHospital(hospitalName: hospitalName)
        
        // Create or find hospital
        let hospital = hospitals.first { $0.hospitalName == hospitalName } ??
            hospitalDataModel.addHospital(hospitalName: hospitalName, tags: [])
        
        // Create a new tag for this report group
        let tag = TagDataModel.sharedTagData.addTag(
            tagName: reportName,
            hospital: [hospital.id],
            appointments: [],
            notes: notes ?? "",
            reports: reports.map { $0.id }
        )
        
        // Update hospital with new tag
        var updatedTags = hospital.tags
        updatedTags.append(tag.id)
        hospitalDataModel.editHospital(
            hospitalId: hospital.id,
            tags: updatedTags
        )
        
        // Update all reports in the data model
        for report in reports {
            reportDataModel.editReport(
                reportId: report.id,
                path: report.path,
                time: Date(),
                date: Date(),
                reportType: .jpg
            )
        }
        
        // Notify delegates if needed
        if let lastReport = reports.last {
            addReportDelegate?.didAddReport(lastReport)
            onReportAdded?(lastReport)
        }
        
        // Show success message
        let alert = UIAlertController(
            title: "Success",
            message: "Report details saved successfully",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }

    private func showAlert(message: String, title: String = "Error") {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
        @objc private func addReportButtonTapped() {
            let alertController = UIAlertController(
                title: "Add Report",
                message: "Choose a source for your report",
                preferredStyle: .actionSheet
            )
            
            let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { [weak self] _ in
                self?.showImagePicker(sourceType: .camera)
            }
            
            let chooseLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { [weak self] _ in
                self?.showImagePicker(sourceType: .photoLibrary)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            alertController.addAction(takePhotoAction)
            alertController.addAction(chooseLibraryAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true)
        }
        
        // MARK: - Helper Methods
        private func validateInputs() -> Bool {
            let requiredFields = [
                (reportNameTextField.text, "Report Name"),
                (hospitalNameTextField.text, "Hospital Name"),
                (appointmentNameTextField.text, "Appointment Name")
            ]
            
            for (value, fieldName) in requiredFields {
                if value?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
                    showAlert(message: "\(fieldName) is required")
                    return false
                }
            }
            return true
        }
        
        private func showAlert(message: String) {
            let alert = UIAlertController(
                title: "Error",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
        private func showImagePicker(sourceType: UIImagePickerController.SourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
        
        private func saveImage(_ image: UIImage) -> String {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileName = "\(UUID().uuidString).jpg"
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                try? imageData.write(to: fileURL)
            }
            
            return fileURL.path
        }
        
        // MARK: - UITableViewDelegate
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.row == 3 {
                return 200 // Height for reports collection view cell
            }
            return UITableView.automaticDimension
        }
        
        // MARK: - UIPickerViewDataSource
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if pickerView == hospitalPicker {
                return hospitals.count
            } else {
                return appointments.count
            }
        }
        
        // MARK: - UIPickerViewDelegate
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView == hospitalPicker {
                return hospitals[row].hospitalName
            } else {
                return appointments[row]
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let label = UILabel()
            if pickerView == hospitalPicker {
                label.text = hospitals[row].hospitalName
            } else {
                label.text = appointments[row]
            }
            label.font = .systemFont(ofSize: 16)
            label.textAlignment = .center
            label.textColor = UIColor(red: 0/255, green: 175/255, blue: 185/255, alpha: 1.0)
            return label
        }
        
        // MARK: - UICollectionViewDataSource
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return reports.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportCollectionViewCell.identifier, for: indexPath) as? ReportCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let report = reports[indexPath.item]
            let image = UIImage(contentsOfFile: report.path)
            cell.configure(with: image, title: "Report")
            
            return cell
        }
        
        // MARK: - UITextViewDelegate
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .lightGray {
                textView.text = ""
                textView.textColor = .label
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "Enter any additional details here."
                textView.textColor = .lightGray
            }
        }
        
        // MARK: - UIImagePickerControllerDelegate
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                let imagePath = saveImage(selectedImage)
                
                let report = reportDataModel.addReport(
                    path: imagePath,
                    time: Date(),
                    date: Date(),
                    reportType: .jpg
                )
                
                reports.append(report)
                
                if let reportsCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)),
                   let collectionView = reportsCell.contentView.viewWithTag(100) as? UICollectionView {
                    collectionView.reloadData()
                }
            }
            
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
