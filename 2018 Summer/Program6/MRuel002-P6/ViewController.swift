//
//  ViewController.swift
//  MRuel002-P6
//
//  Created by COP4655 on 7/20/18.
//  Copyright © 2018 COP4655. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextViewDelegate{
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var loginTextField: UITextField!
    var users = [Users]()
    var time: Timer?
    
    let dateFormatter = DateFormatter()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginTextField.becomeFirstResponder()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setTimeLabel), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        time?.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setTimeLabel()
    {
        let currentTime = Date()
        timeLabel.text = dateFormatter.string(from: currentTime)
    }
    
    @IBAction func loginPressed(_ sender: Any)
    {
        print("Login Button Pressed:")
        //get data
        fetchData()
        //get input
        if ((loginTextField.text ?? "").isEmpty)
        {
            print("enter your user id") //change to alert
            return
        }
        guard let inputId = Int16(loginTextField.text!)
            else
        {
            return
        }
        print(String(describing: inputId))
        //validate login
        var isValid = false
        isValid = validate(input: inputId)
        print("Valid:\(isValid)")
        //check for admin
        if (checkAdmin(input: inputId))
        {
            return
        }
        
        //create new clockinevent
        puchClock(validUserID : inputId)
        
        
        
        //alert user clockin successful
    }
    
    func checkAdmin(input : Int16) -> Bool
    {
        for user in users
        {
            if (user.id == input)
            {
                if (user.isAdmin)
                {
                    print("Is Admin move screen")
                    performSegue(withIdentifier: "toAdminMode", sender: self)
                    return true
                }
                
                
            }
            
        }
        return false
    }
    
    func validate(input : Int16) -> Bool
    {
        for user in users
        {
            if (user.id == input)
            {
                if (user.isActive)
                {
                    print("Valid&Active")
                    return true
                }
                print("Valid&Inactive")
                return false
            }
            
        }
        return false
    }
    
    func puchClock(validUserID : Int16)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
        let sort = NSSortDescriptor(key: "timeIn", ascending:false)
        fetchRequest.sortDescriptors = [sort]
        var lastEvent: Event? = nil
        
        
        
        do
        {
            
            let results = try context.fetch(fetchRequest)
            let allEvents = results
            let filteredEvents = allEvents.filter{$0.person?.id == validUserID}
            for event in filteredEvents
            {
                //if (event.person?.id == validUserID )
                //{
                //    print(event.timeIn?.description)
                //}
                print("id:\(event.person?.id ?? 0000 ) timein:\(String(describing: event.timeIn)))")
                
                
            }
            if (filteredEvents.count > 0)
            {
                lastEvent = filteredEvents.filter {$0.person?.id == validUserID}.first!
            }
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
        
        
        for user in users
        {
            if (user.id == validUserID)
            {
                //check timelog for event with missing clock out
                
                //print("Lastevent:\(String(describing: lastEvent.timeIn))")
                if (lastEvent != nil )
                {
                    if (lastEvent?.timeOut != nil)
                    {
                        
                        //create newclockin for user
                        let newEvent = Event(context: context)
                        
                        newEvent.timeIn = Date()
                        newEvent.person = user
                        newEvent.timelog = TimeLog(context:context)
                    }
                    else
                    {
                        //if found clock the user out
                        lastEvent?.timeOut = Date()
                        
                    }
                }
                else
                {
                    lastEvent = Event(context: context)
                    lastEvent?.timeIn = Date()
                    lastEvent?.person = user
                    lastEvent?.timelog = TimeLog(context: context)
                }
                
                
            }
            
        }
        
        if context.hasChanges
        {
            do
            {
                try context.save()
            }
            catch
            {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            print("Data Saved")
        }
        
        //REMOVE IN PRODUCTION
        print("PrintingLog")
        do
        {
            
            let results = try context.fetch(fetchRequest)
            let allEvents = results
            //let filteredEvents = allEvents.filter{$0.person?.id == validUserID}
            for event in allEvents
            {
                //if (event.person?.id == validUserID )
                //{
                //    print(event.timeIn?.description)
                //}
                print("id:\(event.person?.id ?? 0000 ) timein:\(String(describing: event.timeIn))) timeout:\(String(describing: event.timeOut))")
                
                
            }
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
        //END REMOVE
        
        
        
        
    }
    func fetchData()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Users>(entityName: "Users")
        
        do
        {
            let results = try context.fetch(fetchRequest)
            users = results
            
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
        
        //REMOVE IN PRODUCTION
        print(users.count)
        for user in users { print("\(user.id)") }
        
        if (users.count == 0)
        {
            print("Creating mock users")
            for index in 0...9
            {
                let newEmployee = Users(context: context)
                newEmployee.fname = "Bob\(index)"
                newEmployee.lname = "Test\(index)"
                let newid: Int16 = 1230 + Int16(index)
                newEmployee.id = newid
                
            }
            //create initial admin
            let newEmployee = Users(context: context)
            newEmployee.fname = "Admin\(index)"
            newEmployee.lname = "Admin\(index)"
            let newid: Int16 = 1111
            newEmployee.id = newid
            newEmployee.isAdmin = true

            
            if context.hasChanges
            {
                do
                {
                    try context.save()
                }
                catch
                {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
                print("Data Saved")
            }
            
            fetchData()
        }
    }
}

