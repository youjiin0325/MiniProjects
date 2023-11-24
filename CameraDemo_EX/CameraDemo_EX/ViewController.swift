

import UIKit
import MobileCoreServices//추가
import UniformTypeIdentifiers//추가


//비디오키트
import AVKit
import AVFoundation

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
            //무비버전 ["public.movie"] or [UTType.moview.identifier]
            imagePicker.mediaTypes = [UTType.image.identifier]//어떤 이미지 사용? ["public.image"]-> 모든 이미지 사용
            imagePicker.allowsEditing = false

            self.present(imagePicker, animated: true, completion: nil)
            newMedia = true
        }
    }
    
    @IBAction func useCameraRoll(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
                  
                  let imagePicker = UIImagePickerController()

                  imagePicker.delegate = self
                  imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                  imagePicker.mediaTypes = [UTType.image.identifier]
                  imagePicker.allowsEditing = false

                  self.present(imagePicker, animated: true, completion: nil)
                  
                  newMedia = false
              }
          }
    func imagePickerController(_ picker: UIImagePickerController,
         didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            // UIImagePickerController.InfoKey.mediaType
            let mediaType = info[.mediaType] as! NSString

            self.dismiss(animated: true, completion: nil)
        
           if mediaType.isEqual(to: UTType.image.identifier) {
            
            //info 에서 들어오는 이미지의 타입이 우리가 원하는 타입이 아니기 때문에 as!  UIImage 변환
           let image = info[.originalImage] as! UIImage
            
            //위에서 이미지를 가져오면 뿌려주기
            imageView.image = image
            
            //새로운 이미지가 맞으면?
            //#selector(ViewController.image(image:didFinishSavingWithError:contextInfo:)) -> alert창 처리를 위한 것 ,보통은 (image,self,nil,nil)
            if newMedia == true {
                UIImageWriteToSavedPhotosAlbum(image,self,nil,nil)
                
                   //오류가 발생하면 경고 상자를 사용자에게 보고하고 싶은 경우
//                UIImageWriteToSavedPhotosAlbum(image,self,
//                   #selector(ViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            }
          }
        }
    
    //오류가 발생하면 경고상자를 통해 사용자에게 보고
    @objc func image(image: UIImage, didFinishSavingWithError error:NSErrorPointer, contextInfo: UnsafeRawPointer) {
        
        if error != nil {
                    let alert = UIAlertController(title: "Save Failed",
                                                  message: "Failed to save image",
                                                  preferredStyle: .alert) // UIAlertController.Style.alert
                    let cancelAction = UIAlertAction(title: "OK",
                                                     style: .cancel,
                                                     handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true, completion: nil)
                }

            }
            

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.dismiss(animated: true, completion: nil)
    }
    
    
    //가기 직전 정보를 얻어서 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dest = segue.destination as! AVPlayerViewController
        let url = URL(string: "https://www.apple.com/105/media/us/mac/family/2023/1b2bbf5c-ddc5-44a1-9dfb-7a51c49143fa/anim/welcome/xlarge.mp4")
        
        if let movieUrl = url {
            dest.player = AVPlayer(url: movieUrl)
        }
    }
          
}
