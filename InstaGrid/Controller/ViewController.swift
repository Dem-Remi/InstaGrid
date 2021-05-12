import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //======================
    // MARK: - Outlet
    //======================
    
    // Table of layout buttons
    @IBOutlet var layoutButton: [UIButton]!
    
    // Table of photo buttons
    @IBOutlet var photoButton: [UIButton]!
    
    // Icon selected right
    @IBOutlet weak var selectedRight: UIImageView!
    
    // Icon selected center
    @IBOutlet weak var selectedCenter: UIImageView!
    
    // Icon selected left
    @IBOutlet weak var selectedLeft: UIImageView!
    
    
    //======================
    // MARK: - Action
    //======================
    
    // Layout button action - Touch Up Inside
    @IBAction func layoutButtonAction(_ sender: UIButton) {
        updatePhotoButtonLayout(withLayoutButton : sender)
        selectedButton(withLayoutButton : sender)
    }
    
    // Photo button action - Touch Up Inside
    @IBAction func photoButtonAction(_ sender: UIButton) {
        
        // To access at the gallery
        butonSelectedbuton = sender
        let  imagePickerController = UIImagePickerController ()
        imagePickerController.delegate = self
        self .present ( imagePickerController, animated: true, completion: nil )
    }
    
    
    
    //======================
    // MARK: - Func
    //======================
    
    // Function to update the pictures layout in the central view
    private func updatePhotoButtonLayout(withLayoutButton : UIButton) {
        switch withLayoutButton {
        case layoutButton[0] :
            photoButton[1].isHidden = false
            photoButton[3].isHidden = false
        case layoutButton[1] :
            photoButton[1].isHidden = false
            photoButton[3].isHidden = true
        case layoutButton[2] :
            photoButton[1].isHidden = true
            photoButton[3].isHidden = false
        default: break
        }
    }
    

    
    // Function to save the picture in the button
    private var butonSelectedbuton : UIButton!
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any] ) {
        let image = info[ UIImagePickerController.InfoKey.originalImage] as! UIImage
        butonSelectedbuton.setImage(image, for: .normal)
        picker.dismiss ( animated: true, completion: nil )
    }
    
    
    
    //======================
    // MARK: - Test phase
    //======================
    
    // Function to display or not the selected button above the layout button
    private func selectedButton(withLayoutButton : UIButton) {
        switch withLayoutButton {
        case layoutButton[0] :
            selectedRight.isHidden = false
            selectedLeft.isHidden = true
            selectedCenter.isHidden = true
        case layoutButton[2] :
            selectedRight.isHidden = true
            selectedLeft.isHidden = false
            selectedCenter.isHidden = true
        case layoutButton[1] :
            selectedRight.isHidden = true
            selectedLeft.isHidden = true
            selectedCenter.isHidden = false
        default: break
        }
    }
    
    
    
    
    
    
}





