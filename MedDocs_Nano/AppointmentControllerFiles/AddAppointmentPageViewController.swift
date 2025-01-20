//
//  AddAppointmentPageViewController.swift
//  MedDocs_Nano
//
//  Created by Bhuvesh Bansal on 20/01/25.
//

import UIKit

class AddAppointmentPageViewController: UIViewController {

    
    @IBOutlet weak var hospitalNameTextField: UITextField!
    @IBOutlet weak var doctorNameTextField: UITextField!
    @IBOutlet weak var notesTextLabel: UITextField!
    @IBOutlet weak var dateTimeTableView: UITableView!
    
    
    @IBOutlet weak var medicationNameTextField: UITextField!
    @IBOutlet weak var medicationDetailTableView: UITableView!
    // 
    @IBOutlet weak var reportNameTextField: UITextField!
    @IBOutlet weak var reportDetailTableView: UITableView!
    
    
    
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

}
