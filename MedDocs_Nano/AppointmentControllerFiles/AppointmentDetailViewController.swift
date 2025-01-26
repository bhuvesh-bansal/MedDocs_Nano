//
//  AppointmentDetailViewController.swift
//  MedDocs_Nano
//
//  Created by Vansh Sharma on 21/01/25.
//

import UIKit

class AppointmentDetailViewController: UIViewController {
    
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var hospitalLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var visitedButton: UIButton!
    @IBOutlet weak var skippedButton: UIButton!
    
    var appointment: Appointment? // Appointment data passed to this view controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initially hide all UI elements until data is loaded
        doctorNameLabel.isHidden = true
        notesLabel.isHidden = true
        hospitalLabel.isHidden = true
        scheduleLabel.isHidden = true
        visitedButton.isHidden = true
        skippedButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update UI with appointment data
        updateUI()
    }
    
    /// Updates the UI with appointment details and adjusts button visibility based on status
    private func updateUI() {
        guard let appointment = appointment else { return }
        
        // Unhide all UI elements after data is loaded
        doctorNameLabel.isHidden = false
        notesLabel.isHidden = false
        hospitalLabel.isHidden = false
        scheduleLabel.isHidden = false

        // Populate labels with appointment data
        doctorNameLabel.text = appointment.doctorName.isEmpty ? "No Doctor Name" : appointment.doctorName
        hospitalLabel.text = appointment.clinicName.isEmpty ? "No Clinic Name" : appointment.clinicName
        notesLabel.text = appointment.notes.isEmpty ? "No Notes" : appointment.notes

        // Format and display the date and time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        let dateString = dateFormatter.string(from: appointment.date)

        dateFormatter.dateFormat = "h:mm a"
        let timeString = dateFormatter.string(from: appointment.time)

        scheduleLabel.text = "\(dateString) at \(timeString)"

        // Adjust button visibility based on the appointment status
        switch appointment.status {
        case .pending:
            visitedButton.isHidden = false
            skippedButton.isHidden = false
        case .skipped:
            visitedButton.isHidden = false
            skippedButton.isHidden = true
        case .visited:
            visitedButton.isHidden = true
            skippedButton.isHidden = true
        }
    }
    
    /// Action when "Skipped" button is tapped
    @IBAction func skippedCalled(_ sender: UIButton) {
        if let appointment = appointment {
            // Update appointment status to skipped
            AppointmentDataModel.sharedAppointmentData.editAppointment(
                clinicName: appointment.clinicName,
                notes: appointment.notes,
                time: appointment.time,
                date: appointment.date,
                status: .skipped
            )
            // Update local appointment object and refresh UI
            self.appointment?.status = .skipped
            updateUI()
        }
    }
    
    /// Action when "Visited" button is tapped
    @IBAction func visitedCalled(_ sender: UIButton) {
        if let appointment = appointment {
            // Update appointment status to visited
            AppointmentDataModel.sharedAppointmentData.editAppointment(
                clinicName: appointment.clinicName,
                notes: appointment.notes,
                time: appointment.time,
                date: appointment.date,
                status: .visited
            )
            // Update local appointment object and refresh UI
            self.appointment?.status = .visited
            updateUI()
        }
    }
}
