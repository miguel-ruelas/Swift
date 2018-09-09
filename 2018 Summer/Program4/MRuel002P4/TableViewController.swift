//
//  TableViewController.swift
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

class TableViewController: UITableViewController {
    
   let myContacts = ContactDB.sharedInstance
    var currentContact = Contact(cfname:"",cemail:"")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("ran")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myContacts.numCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let contact = myContacts.getContact(row: indexPath.row)
        if let lname = contact.lname
        {
            cell.textLabel?.text = "\(contact.fname) \(lname)"
        }
        else
        {
            cell.textLabel?.text = contact.fname
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
      myContacts.delContact(row: indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
            
            super.prepare(for: segue, sender: sender)
            
            let detailViewController = segue.destination as? DetailViewController
            
            switch(segue.identifier ?? "")
            {
                
            case "ShowDetail":
                
                let selectedItemCell = sender as? UITableViewCell
                
                let indexPath = tableView.indexPath (for: selectedItemCell!)
                
                let selectedContact = myContacts.getContact(row: (indexPath?.row)!)
                
                detailViewController?.selection = selectedContact
                
                detailViewController?.contactIndex = indexPath?.row
                
            case "AddItem":
                detailViewController?.selection = Contact(cfname: "NewContact",cemail:"New@gmail.com")
                detailViewController?.contactIndex = -1
            default:
                print ("Error")
            }
    }
}
