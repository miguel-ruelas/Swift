//
//  UserDetailViewController.swift
//  MRuel002-P6
//
//  Created by COP4655 on 7/22/18.
//  Copyright © 2018 COP4655. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UINavigationControllerDelegate {
    

    
    var contactIndex: Int?
    
    private var datePicker: UIDatePicker?
    
    
    
    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var lastTextField: UITextField!
    @IBOutlet var pinTextField: UITextField!
    @IBOutlet var isAdminCheckBox: UIButton!
    @IBOutlet var isActiveCheckBox: UIButton!
    var active = false
    var admin = false
   
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UserDetailViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    
    @IBAction func deleteUser(_ sender: Any)
    {
        print("Delete User not implemented yet")
    }
    
    private func configureView() {
        // Update the user interface for the detail item.
        if let user = detailItem
        {
            if let textField = firstTextField
            {
                
                textField.text = user.fname
            }
            
            if let textField = lastTextField
            {
                
                textField.text = user.lname
            }
            
            if let textField = pinTextField
            {
                
                textField.text = String(user.id)
            }
            
            if let checkBox = isAdminCheckBox
            {
                
                checkBox.isSelected = user.isAdmin
            }
            
            if let checkBox = isActiveCheckBox
            {
                
                checkBox.isSelected = user.isActive
            }

        }
        
    }
    
    @IBAction func saveUser(_ sender: Any)
    {
       print("Save User not implemented yet")
    }
    
    
    
    
    func viewTapped(gestureRecognizer: UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
   
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        configureView()
        
        
    }

    @IBAction func cancelButtonPressed(_ sender: Any)
    {
        if let nav = self.navigationController {
        nav.popViewController(animated: true)
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    


    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var detailItem: Users? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
}


