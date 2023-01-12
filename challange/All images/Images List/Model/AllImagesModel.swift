//
//  AllImagesModel.swift
//  challange
//
//  Created by sardar saqib on 07/01/2023.
//

import Foundation


struct AllImagesModel : Codable{
    
    var id:String?
    var url:String?
    var downloadUrl:String?
    var author: String?
    var width: Double?
    var height: Double?
    
    
    enum CodingKeys:String, CodingKey{
        
        case id = "id"
        case author = "author"
        case url = "url"
        case width = "width"
        case height = "height"
        case downloadUrl = "download_url"
    }
}
