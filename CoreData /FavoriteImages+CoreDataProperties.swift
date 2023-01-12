//
//  FavoriteImages+CoreDataProperties.swift
//  
//
//  Created by sardar saqib on 09/01/2023.
//
//

import Foundation
import CoreData


extension FavoriteImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteImages> {
        return NSFetchRequest<FavoriteImages>(entityName: "FavoriteImages")
    }

    @NSManaged public var id: String?
    @NSManaged public var auther: String?
    @NSManaged public var downloadUrl: String?
    @NSManaged public var width: Double
    @NSManaged public var height: Double

}
