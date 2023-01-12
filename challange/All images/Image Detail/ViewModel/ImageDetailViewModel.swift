//
//  ImageDetailViewModel.swift
//  challange
//
//  Created by sardar saqib on 09/01/2023.
//

import Foundation
import CoreData

class ImageDetailViewModel{
    
    weak var delegate:ImageDetailViewToVMDelegates?
    
    var imageDetails = AllImagesModel()
    var isFavorite = false
    
   
    
    func makeFavourite(){
     
        CoreDataManager.shared.makeFavourite(favouriteImg: imageDetails) { [weak self] didSuccess, messgae in
            if didSuccess ?? false{
                self?.delegate?.didBecomeFavourite(didBecome: true, error: "")
            }
            else{
                self?.delegate?.didBecomeFavourite(didBecome: false, error: messgae ?? "")
            }
        }
       
    }
    func checkInFavourites(){
        CoreDataManager.shared.isAlreadyFavorite(id: imageDetails.id ?? "") { [weak self] didSuccess, messgae in
            if didSuccess ?? false{
                
                self?.delegate?.didExistInFavourites(didExist: false, error: "")
            }
            else{
                self?.delegate?.didExistInFavourites(didExist: true, error: messgae ?? "")
            }
        }
    }
}

// MARK: -------- VIEW TO VIEWMODELE DELETGATES -----
protocol ImageDetailViewToVMDelegates:AnyObject{
    func didExistInFavourites(didExist:Bool, error:String)
    func didBecomeFavourite(didBecome:Bool,error:String)
}
