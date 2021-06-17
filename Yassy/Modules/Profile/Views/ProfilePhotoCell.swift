//
//  ProfilePhotoCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/21/21.
//

import UIKit

protocol UploadProfileImageProtocol: AnyObject {
    func updateProfileImage(image: UIImage)
}

class ProfilePhotoCell: BaseTableViewCell {
    override class func description() -> String {
        return "ProfilePhotoCell"
    }
    
    let photoImageView = CustomCircleImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
    
    let imagePicker = UIImagePickerController()
    
    weak var viewController: UIViewController?
    
    weak var delegate: UploadProfileImageProtocol?
    
    override func setupViews() {
        super.setupViews()
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.image = #imageLiteral(resourceName: "avatar2")
        photoImageView.isUserInteractionEnabled = true
        contentView.addSubview(photoImageView)
        photoImageView.setAnchor(top: contentView.topAnchor, left: nil, bottom: contentView.bottomAnchor, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: -16, paddingRight: 0, width: 150, height: 150)
        photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectImageTapped(_:)))
        photoImageView.addGestureRecognizer(tap)
    }
    
    @objc func selectImageTapped(_ tap: UITapGestureRecognizer){
        viewController?.present(imagePicker, animated: true, completion: nil)
    }
    
    func generateCell(imageURL: URL){
        photoImageView.loadImage(from: imageURL)
    }
}

extension ProfilePhotoCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            photoImageView.image = image
            delegate?.updateProfileImage(image: image)
        }
        viewController?.dismiss(animated: true, completion: nil)
    }
}
