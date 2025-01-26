//
//  AddAppointmentPageViewController.swift
//  MedDocs_Nano
//
//  Created by Vansh Sharma on 20/01/25.
//

import UIKit

class AddAppointmentPageViewController: UIViewController {

    
    @IBOutlet weak var hospitalNameTextField: UITextField!
    
    @IBOutlet weak var notesTextLabel: UITextField!
    
    @IBOutlet weak var doctorNameTextField: UITextField!
    
    @IBOutlet weak var aDate: UIDatePicker!
    
    @IBOutlet weak var aTime: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveBtnTapped(_ sender: UIBarButtonItem) {
        
        let hptName : String = hospitalNameTextField.text!
        let notesName : String = notesTextLabel.text!
        
        let dctName: String = doctorNameTextField.text!
        
        let selectedDate = aDate.date
               
               // Get selected time from the time picker
        let selectedTime = aTime.date
        
        let calendar = Calendar.current
    
                let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
                
        var combinedComponents = DateComponents()
     
               combinedComponents.hour = timeComponents.hour
               combinedComponents.minute = timeComponents.minute
        
        guard let combinedDate = calendar.date(from: combinedComponents) else {
                    print("Failed to combine date and time")
                    return
                }
        
        AppointmentDataModel.sharedAppointmentData.addAppointment(clinicName: hptName, notes: notesName,doctorname: dctName, time: combinedDate, date: selectedDate, status: .pending)
                
        
        self.dismiss(animated: true, completion: nil)
    }
    
  
}
