//
//  ReportsViewController.swift
//  MedDocs
//
//  Created by Bhuvesh Bansal on 15/01/25.
//

import UIKit

class ReportsViewController: UIViewController {

    @IBOutlet weak var segmentedButton: UISegmentedControl!
    
    @IBOutlet weak var hospitalImageLabel: UILabel!
    @IBOutlet weak var hospitalLabel: UILabel!
    @IBOutlet weak var hospitalDateLabel: UILabel!
    @IBOutlet weak var hospitalView: UIView!
    
    
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var tagDateLabel: UILabel!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var tagView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentation()
        // Do any additional setup after loading the view.
    }
    func segmentation(){
        if segmentedButton.selectedSegmentIndex == 0{
            hospitalView.isHidden = true
            tagView.isHidden = false
        }else{
            hospitalView.isHidden = false
            tagView.isHidden = true
        }
    }
    @IBAction func segmentedButtonChanged(_ sender: Any) {
        segmentation()
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
