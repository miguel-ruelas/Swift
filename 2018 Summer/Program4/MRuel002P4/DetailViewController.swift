//
//  ViewController.swift
//  MRuel002P4
//
//  Created by COP4655 on 7/6/18.
//  Copyright © 2018 COP4655. All rights reserved.
//

//  PROGRAMMER:     Miguel Ruelas
//  PANTHERID:      4808540
//  CLASS:          COP4655 RVCC 1185
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     #4
//  DUE:            Saturday 07/07/18


import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    var selection: Contact?
    
    let myContacts = ContactDB.sharedInstance
    
    var contactIndex: Int?
    
    private var datePicker: UIDatePicker?
    
  
    
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var lastTextField: UITextField!
    @IBOutlet var add1TextField: UITextField!
    @IBOutlet var add2TextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var stTextField: UITextField!
    @IBOutlet var zipTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var birthTextField: UITextField! //datepicker
    @IBOutlet var contactImageView: UIImageView!
    
    @IBOutlet var mySelection: UILabel!
        
    override func viewDidLoad()
    {
            super.viewDidLoad()
        
            // Do any additional setup after loading the view, typically from a nib.
            datePicker = UIDatePicker()
            datePicker?.datePickerMode = .date
            datePicker?.addTarget(self, action: #selector(DetailViewController.dateChanged(datePicker:)), for: .valueChanged)
            birthTextField.inputView=datePicker;
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.viewTapped(gestureRecognizer:)))
            view.addGestureRecognizer(tapGesture)
        
    }
    
    @IBAction func changeImage(_ sender: Any)
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Image Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else
            {
                print("Camera not available")
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func deleteContact(_ sender: Any)
    {
        if let index = contactIndex
        {
            selection = Contact(cfname: "NewContact",cemail:"New@gmail.com")
            if index <= myContacts.numCount(), index > -1
            {
                myContacts.delContact(row: index)
                contactIndex = -1
                load()
            }
            
        }
        
    }
    
    private func load()
    {
        if let testSelection = selection?.fname
        {
            firstTextField.text = testSelection
        }
        else
        {
            firstTextField.text = ""
        }
        if let testSelection = selection?.lname
        {
            lastTextField.text = testSelection
        }
        else
        {
            lastTextField.text = ""
        }
        navigationItem.title = "\(firstTextField.text ?? "") \(lastTextField.text ?? "")"
        if let testSelection = selection?.add1
        {
            add1TextField.text = testSelection
        }
        else
        {
            add1TextField.text = ""
        }
        if let testSelection = selection?.add2
        {
            add2TextField.text = testSelection
        }
        else
        {
            add2TextField.text = ""
        }
        if let testSelection = selection?.city
        {
            cityTextField.text = testSelection
        }
        else
        {
            cityTextField.text = ""
        }
        if let testSelection = selection?.st
        {
            stTextField.text = testSelection
        }
        else
        {
            stTextField.text = ""
        }
        if let testSelection = selection?.zip
        {
            zipTextField.text = testSelection
        }
        else
        {
            zipTextField.text = ""
        }
        
        if let testSelection = selection?.birthDate
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            birthTextField.text = dateFormatter.string(from: testSelection)
        }
        
        if let testSelection = selection?.email
        {
            emailTextField.text = testSelection
        }
        else
        {
            emailTextField.text = ""
        }
        if let testSelection = selection?.phoneNumber
        {
            phoneTextField.text = testSelection
        }
        if let testSelection = selection?.picture
        {
            contactImageView.image = testSelection
        }

    }
    
    @IBAction func saveContact(_ sender: Any)
    {
        if let fname = firstTextField.text
        {
            selection?.fname = fname
        }
        if let lname = lastTextField.text
        {
            selection?.lname = lname
        }
        if let phone = phoneTextField.text
        {
           selection?.phoneNumber = phone
        }
        if let email = emailTextField.text
        {
            selection?.email = email
        }
        if let add1 = add1TextField.text
        {
            selection?.add1 = add1
        }
        if let add2 = add2TextField.text
        {
            selection?.add2 = add2
        }
        if let city = cityTextField.text
        {
            selection?.city = city
        }
        if let st = stTextField.text
        {
            selection?.st = st
        }
        if let zip = zipTextField.text
        {
            selection?.zip = zip
        }
        
        if let picture = contactImageView.image
        {
            selection?.picture = picture
        }
    
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if let dateString = birthTextField.text
        {
            selection?.birthDate = dateFormatter.date(from: dateString)
        }
        if let index = contactIndex, let contact = selection
        {
            if index > -1
            {
                myContacts.updateContact(modified: contact, row: index)
                print("Saved Modified Contact")
            }
            else
            {
                myContacts.addContact(new: contact)
                print("Saved new Contact")
                selection = Contact(cfname: "NewContact",cemail:"New@gmail.com")
                contactIndex = -1
                load()


            }
           
        }
        else
        {
           
                print("Error Saving")
        }
        
        
    }


    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        contactImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion: nil)
    
    }
    
    func viewTapped(gestureRecognizer: UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
    func dateChanged(datePicker: UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        birthTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
        
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        load()
        
        
    }


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

