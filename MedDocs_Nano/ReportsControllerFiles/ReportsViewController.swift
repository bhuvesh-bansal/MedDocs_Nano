import UIKit

class ReportsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedButton: UISegmentedControl!
    @IBOutlet weak var hospitalView: UIView!
    @IBOutlet weak var hospitalTableView: UITableView!
    @IBOutlet weak var tagSortCollectionView: UICollectionView!
    @IBOutlet weak var tagTableView: UITableView!
    @IBOutlet weak var tagView: UIView!

    // MARK: Properties
    var hospitals: [Tag] = [] // Tags containing hospital-related data
    var tags: [Tag] = []      // All tags

    var filteredHospitals: [Tag] = []
    var filteredTags: [Tag] = []
    var selectedTag: String = "All"
    var selectedIndex: IndexPath?

    // MARK: Default Values
    let defaultSelectedTag = "All"  // Default tag is "All"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadData()
        filterTags(by: defaultSelectedTag)
        filteredHospitals = hospitals
        filteredTags = tags
        searchBar.delegate = self

        // Ensure "All" is selected by default
        selectedIndex = IndexPath(item: 0, section: 0)
        tagSortCollectionView.reloadData()
    }

    // MARK: Data Loading
    func loadData() {
        // Load tags and hospitals from a shared data model
        let tagDataModel = TagDataModel.sharedTagData
        
        // Retrieve all tags from the model
        tags = tagDataModel.getAllTags()

        // Ensure that the tags array is not empty
        if tags.isEmpty {
            print("No tags available.")
        }
        
        // Load the hospitals using the UUIDs stored in the tags
        hospitals = tags.compactMap { tag in
            // You can filter and load actual Hospital objects by matching UUIDs
            // For this example, we'll assume you have a way to fetch a hospital by UUID
            let relatedHospitals = tag.hospital.compactMap { hospitalUUID in
                return HospitalDataModel.sharedHospitalData.getHospital(by: hospitalUUID)
            }
            
            // If any hospitals exist for the tag, include this tag as part of the filtered results
            return relatedHospitals.isEmpty ? nil : tag
        }
        
        // Ensure hospitals are available after filtering
        if hospitals.isEmpty {
            print("No hospitals associated with tags.")
        }
    }



    // MARK: UI Configuration
    func configureUI() {
        // Set Theme Colors
        view.backgroundColor = UIColor(hex: "F8F9FA")
        hospitalView.backgroundColor = UIColor(hex: "F8F9FA")
        tagView.backgroundColor = UIColor(hex: "F8F9FA")

        segmentedButton.backgroundColor = UIColor(hex: "FFFFFF")
        segmentedButton.selectedSegmentTintColor = UIColor(hex: "00AFB9")
        segmentedButton.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedButton.setTitleTextAttributes([.foregroundColor: UIColor(hex: "00AFB9")], for: .normal)

        // Table View
        hospitalTableView.layer.cornerRadius = 8
        tagTableView.layer.cornerRadius = 8
        hospitalTableView.backgroundColor = UIColor(hex: "FFFFFF")
        tagTableView.backgroundColor = UIColor(hex: "FFFFFF")

        // Collection View
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        tagSortCollectionView.collectionViewLayout = layout

        tagSortCollectionView.delegate = self
        tagSortCollectionView.dataSource = self

        hospitalTableView.dataSource = self
        hospitalTableView.delegate = self
        tagTableView.dataSource = self
        tagTableView.delegate = self
    }

    // MARK: Segmented Button Action
    @IBAction func segmentedButtonChanged(_ sender: UISegmentedControl) {
        let showHospital = sender.selectedSegmentIndex == 1
        hospitalView.isHidden = !showHospital
        tagView.isHidden = showHospital
        searchBar.text = "" // Clear search bar text
        filterContent(for: searchBar.text ?? "")
    }

    // MARK: Filtering
    func filterTags(by tagName: String) {
        if tagName == defaultSelectedTag {
            filteredTags = tags
        } else {
            filteredTags = tags.filter { $0.tagName == tagName }
        }
        tagTableView.reloadData()
    }

    func filterContent(for query: String) {
        if segmentedButton.selectedSegmentIndex == 1 {
            filteredHospitals = query.isEmpty ? hospitals : hospitals.filter { $0.tagName.lowercased().contains(query.lowercased()) }
            hospitalTableView.reloadData()
        } else {
            filteredTags = query.isEmpty ? tags : tags.filter { $0.tagName.lowercased().contains(query.lowercased()) }
            tagTableView.reloadData()
        }
    }
}

// MARK: UISearchBarDelegate
extension ReportsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContent(for: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Dismiss the keyboard
    }
}

// MARK: TableView Extensions
extension ReportsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == hospitalTableView ? filteredHospitals.count : filteredTags.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == hospitalTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "hospitalNamesTableViewCell", for: indexPath) as! HospitalNamesTableViewCell
            let hospital = filteredHospitals[indexPath.row]

            cell.hospitalNameImageLabel.text = hospital.tagName.first?.uppercased() ?? ""
            cell.hospitalNameLabel.text = hospital.tagName
            cell.hospitalDate.text = "Last updated on \(hospital.notes ?? "N/A")"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tagsDetailTableViewCell", for: indexPath) as! tagsDetailTableViewCell
            let tag = filteredTags[indexPath.row]
            cell.tagNameLabel.text = tag.tagName
            cell.tagDateLabel.text = "Last updated on \(tag.notes ?? "N/A")"
            return cell
        }
    }
}

// MARK: CollectionView Extensions
extension ReportsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count + 1 // Include "All"
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagSortCollectionViewCell", for: indexPath) as! TagSortCollectionViewCell

        if indexPath.item == 0 {
            cell.tagNameLabel.text = "All"
        } else {
            let tag = tags[indexPath.item - 1]
            cell.tagNameLabel.text = tag.tagName
        }

        let isSelected = selectedIndex == indexPath
        cell.configure(isSelected: isSelected)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previousIndex = selectedIndex
        selectedIndex = indexPath

        collectionView.reloadItems(at: [previousIndex, indexPath].compactMap { $0 })

        selectedTag = indexPath.item == 0 ? defaultSelectedTag : tags[indexPath.item - 1].tagName
        filterTags(by: selectedTag)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tagName = indexPath.item == 0 ? defaultSelectedTag : tags[indexPath.item - 1].tagName
        let textWidth = tagName.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width
        return CGSize(width: textWidth + 20, height: 30) // Add padding
    }
}

// MARK: UIColor Extension
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
