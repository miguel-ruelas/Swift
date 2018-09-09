//
//  Event+CoreDataProperties.swift
//  MRuel002-P6
//
//  Created by COP4655 on 7/22/18.
//  Copyright © 2018 COP4655. All rights reserved.
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var timeIn: Date?
    @NSManaged public var timeOut: Date?
    @NSManaged public var person: Users?
    @NSManaged public var timelog: TimeLog?

}
