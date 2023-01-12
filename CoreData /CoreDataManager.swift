//
//  CoreDataManager.swift
//  challange
//
//  Created by sardar saqib on 09/01/2023.
//

import Foundation
import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    // MARK: - Core Data stack
    
    typealias favouriteImagesHandler = (_ didSuccess:Bool?, _ favouriteImages: [AllImagesModel]?,_ messgae: String?) -> ()
    typealias makeFavouriteHandler = (_ didSuccess:Bool?,_ messgae: String?) -> ()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "challange")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func isAlreadyFavorite(id:String, then handler:makeFavouriteHandler?=nil){
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteImages")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count == 0{
                handler!(true,"Does't exist in favourites")
            }
            else{
                handler!(false,"Its already saved in favourites")
            }
        }
        catch {
            handler!(false,"error executing fetch request:\(error.localizedDescription)")
           
        }
        
    }
    func makeFavourite(favouriteImg:AllImagesModel, then handler:makeFavouriteHandler?=nil){
        
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteImages", in: context)
        
        
        let favouriteImage = NSManagedObject(entity: entity!, insertInto: context)
        
        favouriteImage.setValue(favouriteImg.id ?? "" , forKey: "id")
        favouriteImage.setValue(favouriteImg.author ?? "", forKey: "auther")
        favouriteImage.setValue(favouriteImg.width ?? 0, forKey: "width")
        favouriteImage.setValue(favouriteImg.height ?? 0, forKey: "height")
        favouriteImage.setValue(favouriteImg.downloadUrl ?? "", forKey: "downloadUrl")
        
        
        do{
            try context.save()
            handler!(true,"")
        }
        catch let error as NSError{
            handler!(false,error.localizedDescription)

        }
        
    }
    func getAllFavouriteImages(then handler:favouriteImagesHandler? = nil){
        let context = persistentContainer.viewContext
    

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteImages")
        var favouriteImages = [AllImagesModel]()
        do {
             let result = try context.fetch(fetchRequest)
            for imgData in result as! [NSManagedObject]{
                
                var favouriteImg = AllImagesModel()
                favouriteImg.id = imgData.value(forKey: "id") as? String
                favouriteImg.author = imgData.value(forKey: "auther") as? String
                favouriteImg.width = imgData.value(forKey: "width") as? Double
                favouriteImg.height = imgData.value(forKey: "height") as? Double
                favouriteImg.downloadUrl = imgData.value(forKey: "downloadUrl") as? String
                favouriteImages.append(favouriteImg)
                
            }
            handler!(true,favouriteImages,nil)
        }
        catch let error as NSError{
            print("unable to fecth favouriet images due to:",error.description)
            handler!(false,nil,error.description)
            
        }
    }
}
