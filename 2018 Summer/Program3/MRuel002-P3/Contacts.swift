//
//  Contacts.swift
//  MRuel002-P3
//
//  Created by COP4655 on 6/3/18.
//  Copyright © 2018 COP4655. All rights reserved.


//  PROGRAMMER:     Miguel Ruelas
//  PANTHERID:      4808540
//  CLASS:          COP4655 RVCC 1185
//  INSTRUCTOR:     Steve Luis  ECS 282
//  ASSIGNMENT:     #3
//  DUE:            Sunday 06/03/18
//  Code addapted from Participation assignment #3 Solution

import Foundation

struct Contact
{
    var name: String
    var email: String
}

final class ContactDB
{
    static let sharedInstance = ContactDB()
    
    private var contactList: [Contact] = [Contact(name: "Alex", email:"alex@hotmail.com"),
                                          Contact(name: "Brenda",email:"brenda@gmail.com"),
                                          Contact(name: "Mike",email:"Mike@outlook.com")]
    
    var displayIndex = -1
    
    private init()
    {
        //Sort
        sort()
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
    
    func updateContact(modified: Contact)
    {
        //replace Contact info at displayIndex with modified
        
        contactList[displayIndex] = modified
        
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
    
    private func sort()
    {
        contactList.sort(by: { $0.name < $1.name})
    }
    
}
