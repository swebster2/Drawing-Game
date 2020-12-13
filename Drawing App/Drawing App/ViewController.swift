//
//  ViewController.swift
//  Drawing App
//
//  Created by Samantha Webster on 12/11/20.
//  Copyright © 2020 Samantha Webster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Object Connections
    @IBOutlet weak var titleColorCreator: UILabel!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var labelRed: UILabel!
    @IBOutlet weak var labelGreen: UILabel!
    @IBOutlet weak var labelBlue: UILabel!
    @IBOutlet weak var labelAlpha: UILabel!
    
    @IBOutlet weak var sliderRed: UISlider!
    @IBOutlet weak var sliderGreen: UISlider!
    @IBOutlet weak var sliderBlue: UISlider!
    @IBOutlet weak var sliderAlpha: UISlider!
    
    @IBOutlet weak var inputRed: UITextField!
    @IBOutlet weak var inputGreen: UITextField!
    @IBOutlet weak var inputBlue: UITextField!
    @IBOutlet weak var inputAlpha: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var activeTextField: UITextField? = nil
    
    @IBAction func adjustInput(_ sender: Any) {
        
        let inputR = Float(inputRed.hasText ? inputRed.text! : "255") ?? 255
        let inputG = Float(inputGreen.hasText ? inputGreen.text! : "255") ?? 255
        let inputB = Float(inputBlue.hasText ? inputBlue.text! : "255") ?? 255
        let inputA = Float(inputAlpha.hasText ? inputAlpha.text! : "255") ?? 255

        sliderRed.value = inputR
        sliderGreen.value = inputG
        sliderBlue.value = inputB
        sliderAlpha.value = inputA
        
        adjustSlider(self)
        
    }
    
    @IBAction func clickSave(_ sender: Any) {
        let inputR = Int(sliderRed.value)
        let inputG = Int(sliderGreen.value)
        let inputB = Int(sliderBlue.value)
        let inputA = Int(sliderAlpha.value)
        
        StorageHandler.set(value: Color(
                            red: inputR,
                            green: inputG,
                            blue: inputB,
                            alpha: inputA)
        )
    }
    
    @IBAction func adjustSlider(_ sender: Any) {
        
        let inputR = CGFloat(sliderRed.value)/255
        let inputG = CGFloat(sliderGreen.value)/255
        let inputB = CGFloat(sliderBlue.value)/255
        let inputA = CGFloat(sliderAlpha.value)/255

        let newColor = UIColor(red: inputR, green: inputG, blue: inputB, alpha: inputA)
    
        inputRed.text = String(Int(sliderRed.value))
        inputGreen.text = String(Int(sliderGreen.value))
        inputBlue.text = String(Int(sliderBlue.value))
        inputAlpha.text = String(Int(sliderAlpha.value))

        colorView.backgroundColor = newColor
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
        inputRed.delegate = self
        inputGreen.delegate = self
        inputBlue.delegate = self
        inputAlpha.delegate = self
        
        sliderRed.value = 255
        sliderGreen.value = 255
        sliderBlue.value = 255
        sliderAlpha.value = 255
        
        StorageHandler.getStorage()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {

          guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {

            // if keyboard size is not available for some reason, dont do anything
            return
          }

          var shouldMoveViewUp = false

          // if active text field is not nil
          if let activeTextField = activeTextField {

            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height

            // if the bottom of Textfield is below the top of keyboard, move up
            if bottomOfTextField > topOfKeyboard {
              shouldMoveViewUp = true
            }
          }

          if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
          }
        }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    @objc func didTapView() {
        self.view.endEditing(true)
    }
}

extension ViewController : UITextFieldDelegate {
// when user select a textfield, this method will be called
    func textFieldDidBeginEditing(_ textField: UITextField) {
      // set the activeTextField to the selected textfield
      self.activeTextField = textField
    }
  
// when user click 'done' or dismiss the keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
      self.activeTextField = nil
    }
}
