//
//  ViewController.swift
//  Meme me v1.0
//
//  Created by Khan, Furqan on 2/29/16.
//  Copyright © 2016 Khan, Furqan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

  @IBOutlet weak var imagePickerView: UIImageView!
  @IBOutlet weak var cameraBtn: UIBarButtonItem!
  @IBOutlet weak var imageBtn: UIBarButtonItem!
  @IBOutlet weak var CancelBtn: UIBarButtonItem!
  @IBOutlet weak var topTextFiled: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!
  @IBOutlet weak var navBar: UIToolbar!
  @IBOutlet weak var toolBar: UIToolbar!
  @IBOutlet weak var shareBtn: UIBarButtonItem!

  var meme: Meme!

  override func viewDidLoad() {
    super.viewDidLoad()
    setInitials()
  }

  override func viewWillAppear(animated: Bool) {
    // Check if Camera is available
    cameraBtn.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)

    // Subscribe to keyboard notifications to allow the view to raise when necessary
    subscribeToKeyboardNotifications()

    //disbale share button if there is no image
    shareBtn.enabled = imagePickerView.image != nil
  }

  func setInitials() {
    setTextAttribut(bottomTextField, str : "BOTTOM")
    setTextAttribut(topTextFiled, str : "TOP")
  }

  /*Attributes for styling the text in the text fields*/
  let memeTextAttribues = [
    NSStrokeColorAttributeName : UIColor.blackColor(),
    NSForegroundColorAttributeName : UIColor.whiteColor(),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 38)!,
    NSStrokeWidthAttributeName : NSNumber(float: -3.0)
  ]

  //General method to set both textField attributs
  func setTextAttribut(textField : UITextField, str : String) {
    textField.delegate = self
    textField.text = str
    textField.defaultTextAttributes = memeTextAttribues
    textField.textAlignment = .Center
  }

  func subscribeToKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:" , name: UIKeyboardWillHideNotification, object: nil)
  }

  func unsubscribeFromKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillHideNotification, object: nil)
  }

  func keyboardWillShow(notification: NSNotification) {
    if bottomTextField.isFirstResponder() {
      view.frame.origin.y = -getKeyboardHeight(notification)
    }
  }

  func keyboardWillHide(notification: NSNotification) {
    view.frame.origin.y = 0
  }

  func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    let userInfo = notification.userInfo!
    let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
    return keyboardSize.CGRectValue().height
  }

  // Unsubscribe
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
  }

  //Erase the default text when editing
  func textFieldDidBeginEditing(textField: UITextField) {
    if (textField == topTextFiled && topTextFiled.text == "TOP") {
      topTextFiled.text = ""
    } else if (textField == bottomTextField && bottomTextField.text == "BOTTOM") {
      bottomTextField.text = ""
    }
  }

  /*Function that allows the user to use the return key to escape from the text input*/
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  /*Function that allow user to dismiss keyboard when touches anywhere on the view*/
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    view.endEditing(true)
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
     getAnImage(UIImagePickerControllerSourceType.PhotoLibrary)
  }

  /* Action to call on camera click */
  @IBAction func pickCameraImage(sender: AnyObject) {
    getAnImage(UIImagePickerControllerSourceType.Camera)
  }


  func getAnImage(sourcetype:UIImagePickerControllerSourceType  ) {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.sourceType = sourcetype
    presentViewController(pickerController, animated: true, completion: nil)
  }

  //Func to cancel selection
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {

    dismissViewControllerAnimated(true, completion: nil)
  }

  func generateMemedImage() -> UIImage {

    navBar.hidden = true
    toolBar.hidden = true

    // render view to an image
    UIGraphicsBeginImageContext(self.view.frame.size)
    view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
    let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    navBar.hidden = false
    toolBar.hidden = false

    return memedImage
  }

  func save() {
    //Create the meme
    let memedImage = generateMemedImage()

    meme = Meme(topText: topTextFiled.text!, bottomText: bottomTextField.text!, image: imagePickerView.image!, memedImage: memedImage)
  }

  @IBAction func shareAction(sender: AnyObject) {

    let memedImage = generateMemedImage()

    let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)

    activityViewController.completionWithItemsHandler = { activity, completed, items, error in
      if completed {
        //Save the image
        self.save()
        //Dismiss the view controller
        self.dismissViewControllerAnimated(true, completion: nil)
      }
    }

    presentViewController(activityViewController, animated: true, completion: nil)
  }

  /* Reset everything on Cancel Action*/
  @IBAction func CancelAction(sender: AnyObject) {
    //if keyboard is open and user tap cancel
    view.endEditing(true)
    setInitials()
    imagePickerView.image = nil
    shareBtn.enabled = false
  }
  
  
}

