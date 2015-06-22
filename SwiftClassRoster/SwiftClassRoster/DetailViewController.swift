//  DetailViewController.swift
//  SwiftClassRoster
//
//  Created by Bradley Johnson on 6/10/15 ... reformatted and marked-up on 6-19-15 by R. Woolley.
//  Copyright (c) 2015 BPJ. All rights reserved.

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  // ---------------------- ^^ tried inheriting from ViewController instead of UIViewController so as to have access to all its stuff
  // ... trick I used a lot in Java doing my Android apps:]
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var cameraMissingAlert: UILabel!

  var selectedPerson: Person!

  override func viewDidLoad() {
      super.viewDidLoad()
      self.firstNameTextField.delegate = self
      self.lastNameTextField.delegate = self
      self.firstNameTextField.tag = 0
      self.lastNameTextField.tag = 1
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }

  func textFieldDidEndEditing(textField: UITextField) {
    switch textField.tag {
    case 0:
      self.selectedPerson.firstName = textField.text
    case 1:
      self.selectedPerson.lastName = textField.text
    default:
      break
    }
  }

  @IBAction func photoButtonPressed(sender: AnyObject) {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
      let imagePickerController = UIImagePickerController()
      imagePickerController.delegate = self
      imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
      imagePickerController.allowsEditing = true
      self.presentViewController(imagePickerController, animated: true, completion: nil)
    } else {
      // Warn the user of the missing camera in both the sim and the really-old-iPod-touch
      self.cameraMissingAlert.text = "No camera found" 
    }
  }

  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    // so, what may one want to put in here, anyway?
    // perhaps provide for persistance of the photo taken?
  }

  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject: AnyObject]) {
    let image = info[UIImagePickerControllerEditedImage] as? UIImage
      self.imageView.image = image
      picker.dismissViewControllerAnimated(true, completion: nil)
  }

}
