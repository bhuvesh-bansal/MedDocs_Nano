import UIKit

class DisplayProfileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make imageView circular (optional, based on design preference)
        imageView.layer.cornerRadius = imageView.frame.height / 4
        imageView.clipsToBounds = true
        
        // Add a tap gesture to the image view if you want to allow users to tap the image directly to edit
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editButtonTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        // Open image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true // Allows cropping the image
        present(imagePicker, animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the selected image
        if let editedImage = info[.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageView.image = originalImage
        }
        
        // Dismiss the picker
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker when canceled
        picker.dismiss(animated: true, completion: nil)
    }
}
