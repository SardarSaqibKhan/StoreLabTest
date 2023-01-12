//
//  BaseResponse.swift
//  yurist-iOS
//
//  Created by Sanam on 15/11/2022.
//

import Foundation
import SwiftyJSON


struct BaseResponse: Codable {
    
    var success = true
    var message: String?
    var data: JSON?
    
    enum CodingKeys: String, CodingKey {
        
        case success = "success"
        case message = "message"
        case data = "data"
    }
}


struct NoDataBase: Codable {
    
    var success: Bool? = false
    var message: String?
    var data:Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case success = "success"
        case message = "message"
        case data = "data"
    }
}

