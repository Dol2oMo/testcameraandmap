//
//  RegisterViewController.swift
//  ChatTest
//
//  Created by MC-MG57035 on 4/28/2560 BE.
//  Copyright © 2560 Dol2oMo. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var ProfileImage:UIImageView!
    @IBOutlet weak var emailtextfield:UITextField!
    @IBOutlet weak var passwordtextfield:UITextField!
    
    let imagepicker = UIImagePickerController()
    var selectPhoto:UIImage!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.selectPhoto(tap:)))
        tap.numberOfTapsRequired = 1
        ProfileImage.addGestureRecognizer(tap)
        
        ProfileImage.layer.cornerRadius = ProfileImage.frame.size.height/2
        ProfileImage.clipsToBounds = true
        ProfileImage.contentMode = .scaleAspectFit
        ProfileImage.backgroundColor = UIColor .black
        ProfileImage.layer.borderWidth = 2.0
        ProfileImage.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func selectPhoto(tap:UITapGestureRecognizer)  {
        
        imagepicker.delegate = self
        imagepicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagepicker.sourceType = .camera
        }
        else{
            imagepicker.sourceType = .photoLibrary
        }
        
        self.present(imagepicker, animated: true, completion: nil)
        
    }
   
    
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    

}

extension RegisterViewController
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        selectPhoto = info[UIImagePickerControllerEditedImage] as? UIImage
        ProfileImage.image = selectPhoto
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}




