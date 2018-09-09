//
//  Contacts.swift
//  MRuel002-P4
//
//  Created by COP4655 on 6/3/18.
//  Copyright © 2018 COP4655. All rights reserved.


//  PROGRAMMER:     Miguel Ruelas
//  PANTHERID:      4808540
//  CLASS:          COP4655 RVCC 1185
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     #4
//  DUE:            Saturday 07/07/18
//  Code addapted from Participation assignment #3 Solution

import Foundation
import UIKit

struct Contact
{
    var fname: String
    var lname: String?
    var add1: String?
    var add2: String?
    var city: String?
    var st: String?
    var zip: String?
    var email: String?
    var birthDate: Date? //
    var phoneNumber: String? //
    var picture: UIImage?
    
    init(cfname: String, clname: String? = nil, cphonenumber: String? = nil, cadd1: String? = nil,
         cadd2: String? = nil, ccity: String? = nil, cst: String? = nil, czip: String? = nil,
         cemail: String? = nil, cbirthDate: Date? = nil, cpicture: UIImage? = nil
         )
    {
        self.fname = cfname
        self.lname = clname
        self.phoneNumber = cphonenumber
        self.add1 = cadd1
        self.add2 = cadd2
        self.city = ccity
        self.st = cst
        self.zip = czip
        self.email = cemail
        self.birthDate = cbirthDate
        self.picture = cpicture
        
    }
    
}

final class ContactDB
{
    static let sharedInstance = ContactDB()

    
    private var contactList: [Contact] = [
        Contact(cfname: "Alex", cemail:"alex@hotmail.com"),
        Contact(cfname: "Brenda",cemail:"brenda@gmail.com"),
        Contact(cfname: "Max", clname:"Gomez", cemail:"maxgomez@gmail.com"),
        Contact(cfname: "Tiger", clname:"Woods", cemail:"tigw@gmail.com"),
        Contact(cfname: "Kelly", clname:"Thompson", cemail:"thompkel@gmail.com"),
        Contact(cfname: "Gloria", clname:"Estefan", cemail:"egl@gmail.com"),
        Contact(cfname: "Hector", clname:"Diaz", cemail:"diazh@gmail.com"),
        Contact(cfname: "Carlos", clname:"Gomez", cemail:"CarlosG@gmail.com"),
        Contact(cfname: "Walter", clname:"Jones", cemail:"wjonez@gmail.com"),
        Contact(cfname: "Alicia",cemail:"Ali@outlook.com")
    ]
    
    var displayIndex = -1
    
    private init()
    {
        //Sort
        sort()
    }
    
    func getContact(row: Int) -> Contact
    {
  
        
        return contactList[row]
    }
    
    func nextContact() -> Contact
    {
        //increment display index
        displayIndex += 1
        
        //Test for wrap condition
        if displayIndex >= contactList.count
        {
            displayIndex = 0
        }
        
        //Return contact index
        return contactList[displayIndex]
    }
    
    func prevContact() -> Contact
    {
        //decrement display index
        displayIndex -= 1
        
        //Test for wrap condition
        if displayIndex < 0
        {
            displayIndex = contactList.count-1
        }
        
        //return contact at index
        return contactList[displayIndex]
    }
    
    func updateContact(modified: Contact, row: Int)
    {
        //replace Contact info at displayIndex with modified
        
        contactList[row] = modified
        
        //SORT
        sort()
    }
    
    func addContact(new: Contact)
    {
        //append new to contactList
        contactList.append(new)
        
        //SORT
        sort()
    }
    
    func delContact(row: Int)
    {
        //append new to contactList
        contactList.remove(at: row)
        
        //SORT
        sort()
    }
    
    private func sort()
    {
        contactList.sort{
            guard let p0lname = $0.lname, let p1lname = $1.lname
            else
            {
                return $0.fname < $1.fname
            }
            if p0lname == p1lname
            {
                return $0.fname < $1.fname
            }
            else
            {
                return p0lname < p1lname
            }
        }
    }
    
    func numCount() -> Int
    {
        return contactList.count
    }
    
}
