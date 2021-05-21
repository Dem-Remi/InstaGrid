import UIKit

final class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var swipe : UISwipeGestureRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(respondSwipe))
        centralView.addGestureRecognizer(swipe!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(swipeDirection), name: UIDevice.orientationDidChangeNotification, object: nil)
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
    
    // Central view, wich contains photos
    @IBOutlet weak var centralView: UIView!
    
    // Swipe "side" (text + arrow)
    @IBOutlet weak var swipeInformation: UIView!
    
    
    
    //======================
    // MARK: - Action
    //======================
    
    
    // Layout button action - Touch Up Inside
    @IBAction private func layoutButtonAction(_ sender: UIButton) {
        updatePhotoButtonLayout(withLayoutButton : sender)
        selectedButton(withLayoutButton : sender)
    }
    
    
    // Photo button action - Touch Up Inside
    @IBAction private func photoButtonAction(_ sender: UIButton) {
        // To access at the gallery
        picture = sender
        let  imagePickerController = UIImagePickerController ()
        imagePickerController.delegate = self
        self .present ( imagePickerController, animated: true, completion: nil )
    }
    
    
    
    //======================
    // MARK: - Func
    //======================
    
    
    // Function to update the pictures layout in the central view
    private  func updatePhotoButtonLayout(withLayoutButton : UIButton) {
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
    
    
    // Function to display or not the selected button above the layout button
    private func selectedButton(withLayoutButton : UIButton) {
        switch withLayoutButton {
        case layoutButton[0] :
            selectedRight.isHidden = false
            selectedLeft.isHidden = true
            selectedCenter.isHidden = true
        case layoutButton[1] :
            selectedRight.isHidden = true
            selectedLeft.isHidden = true
            selectedCenter.isHidden = false
        case layoutButton[2] :
            selectedRight.isHidden = true
            selectedLeft.isHidden = false
            selectedCenter.isHidden = true
        default: break
        }
    }
    
    
    // Function to share the picture after the swipe
    @objc func respondSwipe () {
        let transform : CGAffineTransform
        if swipe?.direction == .up {
            transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
        } else {
            transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        }
        UIView.animate(withDuration: 1, animations: { [self] in
            centralView.transform = transform
        }, completion:{_ in
            self.shareImage()
        } )
    }
    
    
    // Function to transform the UIView into an UIImage, in order to share the UIImage
    private func imageView (view: UIView) -> UIImage {
        let image = UIGraphicsImageRenderer ( size: centralView.bounds.size )
        return image.image { _ in centralView.drawHierarchy(in: centralView.bounds, afterScreenUpdates: true) }
    }
    
    
    // Function to share the UIImage
    private func shareImage() {
        let imageToShare = [imageView(view: centralView)]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        present(activityViewController, animated: true)
        activityViewController.completionWithItemsHandler = { _, _, _, _ in
            UIView.animate(withDuration: 0.5) {
                self.centralView.transform = .identity
            }
        }
    }
    
    
    // Function to adapt the swipe direction following orientation device
    @objc private func swipeDirection() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipe?.direction = .left
        } else {
            swipe?.direction = .up
        }
    }
    
    
    // Function to import a picture from the galery
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any] ) {
        let image = info[ UIImagePickerController.InfoKey.originalImage] as! UIImage
        picture.setImage(image, for: .normal)
        picture.imageView?.contentMode = .scaleAspectFill   // ✅ To keep the picture scale aspect 🎉
        picker.dismiss ( animated: true, completion: nil )
    }
    
    
    
    //======================
    // MARK: - Property
    //======================
    
    
    // Property picture, type UIButton
    private var picture : UIButton!
    
    
}
