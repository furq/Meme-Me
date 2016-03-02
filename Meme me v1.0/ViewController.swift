//
//  ViewController.swift
//  Meme me v1.0
//
//  Created by Khan, Furqan | Furqan | ISDOD on 2/29/16.
//  Copyright © 2016 Khan, Furqan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var imagePickerView: UIImageView!
  @IBOutlet weak var cameraBtn: UIBarButtonItem!
  @IBOutlet weak var imageBtn: UIBarButtonItem!
  @IBOutlet weak var CancelBtn: UIBarButtonItem!

  override func viewDidLoad() {
    super.viewDidLoad()

    cameraBtn.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
  }

  /*Function to pass the selected image to the imageViewController*/
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      imagePickerView.image = image
    }
    dismissViewControllerAnimated(true, completion: nil)
  }

  /* Action to call on Album click*/
  @IBAction func pickAnImage(sender: AnyObject) {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    presentViewController(pickerController, animated: true, completion: nil)
  }

  /* Action to call on camera click */
  @IBAction func pickCameraImage(sender: AnyObject) {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    presentViewController(pickerController, animated: true, completion: nil)
  }

}

