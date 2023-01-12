//
//  Tabbar.swift
//  challange
//
//  Created by sardar saqib on 07/01/2023.
//

import Foundation
import UIKit


class TabbarViewController: UITabBarController {
    
    let allImagesController = UINavigationController(rootViewController: AllImagesVC())
    let favouriteImagesController = UINavigationController(rootViewController: FavouriteImagesVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTabbar()
    }
}

extension TabbarViewController{
    func registerTabbar(){
        //Find Lawyer Controller
        allImagesController.tabBarItem.image = UIImage(named: "gallery")
        allImagesController.tabBarItem.selectedImage = UIImage(named: "gallery")!.withRenderingMode(.alwaysOriginal)
        allImagesController.tabBarItem.title = "All Images"
        
        
        //Lawyer Controller
        favouriteImagesController.tabBarItem.image = UIImage(named: "unfavorite")
        favouriteImagesController.tabBarItem.selectedImage = UIImage(named: "favorite")!.withRenderingMode(.alwaysOriginal)
        favouriteImagesController.tabBarItem.title = "My Favourite"
        
   
        
        viewControllers = [allImagesController, favouriteImagesController]
               
    }
}
