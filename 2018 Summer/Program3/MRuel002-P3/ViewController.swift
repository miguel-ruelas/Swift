//
//  ViewController.swift
//  MRuel002-P3
//
//  Created by COP4655 on 6/3/18.
//  Copyright © 2018 COP4655. All rights reserved.
//

//  PROGRAMMER:     Miguel Ruelas
//  PANTHERID:      4808540
//  CLASS:          COP4655 RVCC 1185
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     #3
//  DUE:            Sunday 06/03/18
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let myContacts = ContactDB.sharedInstance
    var currentContact = Contact(name:"",email:"")
    
  
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentContact = myContacts.nextContact()
        nameTextField.text = currentContact.name
        emailTextField.text = currentContact.email

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newButtonPressed(_ sender: UIButton)
    {
        //print("new was pressed")
        if !validateInput()
        {
            return
        }
        let nameString: String? = nameTextField.text
        let emailString: String? = emailTextField.text
        if let tempName = nameString
        {
            if let tempEmail = emailString
            {
                if tempName == currentContact.name
                {
                    if tempEmail == currentContact.email
                    {
                        let redCol = UIColor.red
                        nameTextField.layer.borderColor = redCol.cgColor
                        nameTextField.layer.borderWidth = 1.0
                        emailTextField.layer.borderColor = redCol.cgColor
                        emailTextField.layer.borderWidth = 1.0
                        return
                    }
                }
                let newContact: Contact = Contact(name: tempName, email: tempEmail )
                myContacts.addContact(new: newContact)
            }
        }

    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton)
    {
        //print("update was pressed")
        if !validateInput()
        {
            return
        }
        let nameString: String? = nameTextField.text
        let emailString: String? = emailTextField.text
        if let tempName = nameString
        {
            if let tempEmail = emailString
            {
                currentContact = Contact(name: tempName, email: tempEmail )
                myContacts.updateContact(modified: currentContact)
            }
        }
        
        
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton)
    {
        //print("next was pressed")
        currentContact = myContacts.nextContact()
        nameTextField.text = currentContact.name
        emailTextField.text = currentContact.email
        emailTextField.layer.borderWidth = 0
        nameTextField.layer.borderWidth = 0
        
    }
    
    @IBAction func prevButtonPressed(_ sender: UIButton)
    {
        //print("prev was pressed")
        currentContact = myContacts.prevContact()
        nameTextField.text = currentContact.name
        emailTextField.text = currentContact.email
        emailTextField.layer.borderWidth = 0
        nameTextField.layer.borderWidth = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //print("ShouldReturnFired")
        if validateInput()
        {
            textField.resignFirstResponder()
        }
        
        return true


    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        //print("ShouldBeginFired")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if validateInput()
        {

        }

    }
    
    func validateInput() -> Bool
    {
        var validName = false
        var validEmail = false
        
        let redCol = UIColor.red
        emailTextField.layer.borderWidth = 0
        nameTextField.layer.borderWidth = 0
 
        if let tempName = nameTextField.text
        {
            if let tempEmail = emailTextField.text
            {
                if tempName != ""
                {
                    validName = true
                    
                }
                else
                {
                    nameTextField.layer.borderColor = redCol.cgColor
                    nameTextField.layer.borderWidth = 1.0
                }
                if tempEmail != ""
                {
                    validEmail = true
                }
                else
                {
                    emailTextField.layer.borderColor = redCol.cgColor
                    emailTextField.layer.borderWidth = 1.0
                }
                
            }
        }
        return validName && validEmail

        
    }
    
    


}

