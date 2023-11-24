//
//  ViewController.swift
//  CameraDemo_EX
//
//  Created by YOU on 11/24/23.
//

import UIKit
import MobileCoreServices//추가
import UniformTypeIdentifiers//추가

class ViewController: UIViewController,
                      UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    //잠시후 뒷 부분에서 필요할 Boolean 선언
    var newMedia: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func useCamera(_ sender: Any) {
        //카메라 촬영을 하면?
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            
            let imagePicker = UIImagePickerController()

            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.mediaTypes = [UTType.image.identifier]//어떤 이미지 사용? ["public.image"]-> 모든 이미지 사용
            imagePicker.allowsEditing = false

            self.present(imagePicker, animated: true, completion: nil)
            newMedia = true
        }
    }
    
    @IBAction func useCameraRoll(_ sender: Any) {
    }
}

