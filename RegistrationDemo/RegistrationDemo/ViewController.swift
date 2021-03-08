//
//  ViewController.swift
//  RegistrationDemo
//
//  Created by Sunil.Godhumala on 06/03/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var panNumber_TxtFld: UITextField!
    @IBOutlet weak var date_TxtFld: UITextField!
    @IBOutlet weak var month_TxtFld: UITextField!
    @IBOutlet weak var year_TxtFld: UITextField!
    @IBOutlet weak var next_Btn: UIButton!
    @IBOutlet weak var dontHavePan_Btn: UIButton!
    
    var validationViewModel = PanValidationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panNumber_TxtFld.layer.cornerRadius = 8
        panNumber_TxtFld.delegate = self
        self.panNumber_TxtFld.layer.borderWidth = 2
        self.panNumber_TxtFld.layer.borderColor = UIColor(red:111/255, green:170/255, blue:229/255, alpha: 1).cgColor
        
        
        date_TxtFld.layer.cornerRadius = 8
        date_TxtFld.delegate = self
        date_TxtFld.layer.borderWidth = 2
        date_TxtFld.layer.borderColor = UIColor.lightGray.cgColor
        
        month_TxtFld.layer.cornerRadius = 8
        month_TxtFld.delegate = self
        month_TxtFld.layer.borderWidth = 2
        month_TxtFld.layer.borderColor = UIColor.lightGray.cgColor

        
        year_TxtFld.layer.cornerRadius = 8
        year_TxtFld.delegate = self
        year_TxtFld.layer.borderWidth = 2
        year_TxtFld.layer.borderColor = UIColor.lightGray.cgColor
        
        next_Btn.layer.cornerRadius = 8
        
        attributedTextToLabelDescription()
    }

    func attributedTextToLabelDescription() {
        let fullString = "Providing PAN & Date of Birth helps us find and fetch your KYC from a central registry by the Government of India. Learn more"
        let regularAttributes = [NSAttributedString.Key.font: UIFont.init(name: "Avenir Book", size: 12.0)]
        let colorAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        let attributedSentence = NSMutableAttributedString(string: fullString, attributes: regularAttributes as [NSAttributedString.Key : Any])
        attributedSentence.setAttributes(colorAttributes, range: NSRange(location: fullString.count - 11, length: 11))
        lbl_description.attributedText = attributedSentence
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField != self.panNumber_TxtFld  {
            textField.layer.borderColor = UIColor(red:96/255, green:62/255, blue:176/255, alpha: 1).cgColor
            textField.layer.borderWidth = 2
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField != self.panNumber_TxtFld  {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.borderWidth = 2
        }
    }
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let dateString = date_TxtFld.text ?? ""
        let month = month_TxtFld.text ?? ""
        let year = year_TxtFld.text ?? ""
        let fullDate = dateString + "-" + month + "-" + year
        if validationViewModel.validatePan(panNumber_TxtFld.text ?? "") == false {
            Toast.show(withText: "Please enter a valid pan", position: .top)
        }
        else if validationViewModel.dateOfValidation(fullDate) == false {
            Toast.show(withText: "Please enter a valid date", position: .top)
        }
        else{
            Toast.show(withText: "Details submitted successfully", position: .top)
        }
    }
    
    @IBAction func noPanTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "NoPanVC") as! NoPanVC
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

    

