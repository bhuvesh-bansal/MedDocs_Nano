////
////  HomeScreenViewController.swift
////  MedDocs_Nano
////
////  Created by Vansh Sharma on 17/01/25.
////
//
//import UIKit
//
//class HomeScreenViewController: UIViewController {
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
//
//}


import UIKit

class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Dummy data with text and SF Symbol names
    let data = [
        ("Add Appointment", "calendar.badge.plus"),  // SF Symbol for Add Appointment
        ("Add Medication", "rectangle.and.pencil.and.ellipsis"),  // SF Symbol for Add Medication
        ("Add Report", "document.badge.arrow.up.fill")  // SF Symbol for Add Report
    ]
    
    // TableView outlet
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the data source and delegate for the table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register a basic cell type
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Set the background color of the table view to white
        tableView.backgroundColor = .white
        
        // Increase the size of each row (increase cell height)
        tableView.rowHeight = 80  // Increase the height to make cells larger
        
        // Optionally, add some space between cells
        tableView.sectionFooterHeight = 10  // This will add space between cells
        
        // Remove extra separators below the table view
        tableView.tableFooterView = UIView()
        
        // Set content insets to remove any extra padding, ensure no space at top
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Remove space at the top, left, bottom, and right
        
        // Disable scrolling to make the table view unscrollable
        tableView.isScrollEnabled = false
        
        // Add shadow and rounded corners to the table view
        tableView.layer.cornerRadius = 15  // Round the corners
        tableView.layer.masksToBounds = false  // Allow shadow outside the bounds
        tableView.layer.shadowColor = UIColor.black.cgColor  // Set shadow color
        tableView.layer.shadowOpacity = 0.2  // Set shadow opacity
        tableView.layer.shadowOffset = CGSize(width: 0, height: 4)  // Set shadow offset (distance of shadow)
        tableView.layer.shadowRadius = 4  // Set shadow blur radius
        
        // Adjust the frame of the table view to fit the content height if needed
        tableView.layoutIfNeeded()

        // Set the initial scroll value (27 points from the top)
        tableView.setContentOffset(CGPoint(x: 0, y: 27), animated: false)
    }

    // MARK: - UITableViewDataSource Methods

    // Return number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    // Return the cell for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Get the data for the current row
        let item = data[indexPath.row]
        cell.textLabel?.text = item.0
        
        // Set the SF Symbol image
        if let symbolImage = UIImage(systemName: item.1) {
            // Set the image and custom tint color
            cell.imageView?.image = symbolImage
            cell.imageView?.tintColor = UIColor(red: 3/255, green: 178/255, blue: 187/255, alpha: 1.0)  // Custom color #03B2BB
            cell.imageView?.backgroundColor = UIColor(red: 3/255, green: 178/255, blue: 187/255, alpha: 0.2) // Light background color
            cell.imageView?.layer.cornerRadius = 10
            cell.imageView?.clipsToBounds = true
            
            // Increase the size of the image view to 80x80 (increased by 20)
            let imageViewSize = CGSize(width: 80, height: 80) // New size after increase
            cell.imageView?.frame = CGRect(x: 10, y: (cell.frame.height - imageViewSize.height) / 2, width: imageViewSize.width, height: imageViewSize.height)
        }
        
        // Adjust the image view to have space between symbol and borders
        cell.imageView?.contentMode = .scaleAspectFit
        
        // Add a disclosure indicator
        cell.accessoryType = .disclosureIndicator
        
        // Return the modified cell
        return cell
    }

    // MARK: - UITableViewDelegate Methods

    // Handle selection of a row (optional)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at index: \(indexPath.row), Text: \(data[indexPath.row].0)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
