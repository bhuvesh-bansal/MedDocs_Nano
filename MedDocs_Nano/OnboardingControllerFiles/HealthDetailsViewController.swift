//
//  HealthDetailsViewController.swift
//  task
//
//  Created by TANISHQ on 20/01/25.
//

import UIKit

class HealthDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ButtonNext: UIButton!
    

    let fields = ["First Name", "Last Name", "Date of Birth", "Gender", "Phone Number", "Blood Group", "Allergies", "Address"]
    let details = ["", "", "Date", "Select", "", "Select", "", ""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        ButtonNext.layer.cornerRadius = 12.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        cell.textLabel?.text = fields[indexPath.row]
        cell.detailTextLabel?.text = details[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
