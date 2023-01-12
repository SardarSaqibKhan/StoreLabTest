//
//  FavouriteImagesViewModel.swift
//  challange
//
//  Created by sardar saqib on 09/01/2023.
//

import Foundation
class FavouriteImagesViewModel{
    weak var delegate:FavouriteImagesViewToVMDelegates?
    var collectionViewCellHeight:CGFloat = 100
    var numberOfCellInRow:CGFloat = 3
    var collectionviewLineSpacing:CGFloat = 2
    
    var favouriteImages = [AllImagesModel]()
    
    func getFavouriteImages(){
        CoreDataManager.shared.getAllFavouriteImages {[weak self] didSuccess, favouriteImages, messgae in
            if didSuccess ?? false{
                self?.favouriteImages = favouriteImages ?? []
                self?.delegate?.didRecieveFavouriteImages(didRevieve: true)
            }
            else{
                self?.delegate?.didRecieveFavouriteImages(didRevieve: false)
            }
        }
    }
}
// MARK: --- VIEW TO VIEW MODEL DELEGATES -----
protocol FavouriteImagesViewToVMDelegates:AnyObject{
    
    func didRecieveFavouriteImages(didRevieve:Bool)
}
