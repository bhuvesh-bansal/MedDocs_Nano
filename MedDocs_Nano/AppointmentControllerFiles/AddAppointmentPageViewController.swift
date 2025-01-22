////
////  AddAppointmentPageViewController.swift
////  MedDocs_Nano
////
////  Created by Bhuvesh Bansal on 20/01/25.
////
//
//import UIKit
//
//class AddAppointmentPageViewController: UIViewController {
//
//    
//    @IBOutlet weak var hospitalNameTextField: UITextField!
//    
//    @IBOutlet weak var notesTextLabel: UITextField!
//    
//    @IBOutlet weak var doctorNameTextField: UITextField!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//    @IBAction func saveBtnTapped(_ sender: UIBarButtonItem) {
//        
//        let hptName : String = hospitalNameTextField.text!
//        let notesName : String = notesTextLabel.text!
//  
//        
//         AppointmentDataModel.sharedAppointmentData.addAppointment(clinicName: hptName, notes: notesName, time: Date(), date: Date(), status: .pending)
//                
//        
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    @IBAction func cancelBtnTapped(_ sender: UIBarButtonItem) {
//        
//        self.dismiss(animated: true, completion: nil)
//    }
//}
