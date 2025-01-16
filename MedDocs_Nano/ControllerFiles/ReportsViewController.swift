//
//  ReportsViewController.swift
//  MedDocs
//
//  Created by Bhuvesh Bansal on 15/01/25.
//

import UIKit

struct Hospital {
    let name: String
    let imageText: String
    let date: String
}

struct Tag {
    let imageName: String
    let name: String
    let date: String
}

class ReportsViewController: UIViewController {

    @IBOutlet weak var segmentedButton: UISegmentedControl!
    @IBOutlet weak var hospitalView: UIView!
    @IBOutlet weak var hospitalTableView: UITableView!
    @IBOutlet weak var tagSortCollectionView: UICollectionView!
    @IBOutlet weak var tagTableView: UITableView!
    @IBOutlet weak var tagView: UIView!
    
    var hospitals: [Hospital] = [
        Hospital(name: "City Hospital", imageText: "🏥", date: "12 Jan 2023"),
        Hospital(name: "General Clinic", imageText: "🏥", date: "10 Feb 2023"),
        Hospital(name: "Apollo Hospital", imageText: "🏥", date: "15 Mar 2023")
    ]

    var tags: [Tag] = [
        Tag(imageName: "tagIcon", name: "Neck Pain", date: "12 Feb 2023"),
        Tag(imageName: "tagIcon", name: "Back Pain", date: "10 Jan 2024")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentation()
        hospitalTableView.dataSource = self
        hospitalTableView.delegate = self
        tagTableView.dataSource = self
        tagTableView.delegate = self
    }
    
    func segmentation() {
        if segmentedButton.selectedSegmentIndex == 0 {
            hospitalView.isHidden = true
            tagView.isHidden = false
        } else {
            hospitalView.isHidden = false
            tagView.isHidden = true
        }
    }
    
    @IBAction func segmentedButtonChanged(_ sender: Any) {
        segmentation()
    }
}

extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == hospitalTableView {
            return hospitals.count
        } else if tableView == tagTableView {
            return tags.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == hospitalTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "hospitalNamesTableViewCell", for: indexPath) as! hospitalNamesTableViewCell
            let hospital = hospitals[indexPath.row]
            cell.hospitalNameImageLabel.text = hospital.imageText
            cell.hospitalNameLabel.text = hospital.name
            cell.hospitalDate.text = hospital.date
            return cell
        } else if tableView == tagTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tagsDetailTableViewCell", for: indexPath) as! tagsDetailTableViewCell
            let tag = tags[indexPath.row]
            //cell.tagImageView.image = UIImage(named: tag.imageName)
            cell.tagNameLabel.text = tag.name
            cell.tagDateLabel.text = tag.date
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == hospitalTableView {
            print("Selected Hospital: \(hospitals[indexPath.row].name)")
        } else if tableView == tagTableView {
            print("Selected Tag: \(tags[indexPath.row].name)")
        }
    }
}
