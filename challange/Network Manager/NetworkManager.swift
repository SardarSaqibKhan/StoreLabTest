//
//  NetworkManager.swift
//  ios-starter-project
//
//  Created by Mehtab Ahmed on 26/06/21.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import UIKit
import SwiftyJSON

class NetworkManager: SessionManager {
    
    
    // MARK: - Public methods
    func getRequest(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, completion: @escaping (JSON?) -> Void ) {
        
        
        /*Alamofire.request(url, method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success(let data):
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: response.data!, options: [.allowFragments]) as? [[String:Any]] {
                        print(jsonObject)
                    }
                    else if let jsonObject = try JSONSerialization.jsonObject(with: response.data!, options: [.allowFragments]) as? [String:Any] {
                        print(jsonObject)
                    }
                    else {
                        print("unable to parse")
                    }
                    
                } catch {
                    
                }
            case .failure(let error):
                print("no connect Url not hit")
                print(error)
            }
        }*/
        
       
        Alamofire.request(url, method: .get , parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            self.handleResponse(response: response, completion: completion)
        }
    }
    
    func putRequest(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, completion: @escaping (JSON?) -> Void ) {
        
        Alamofire.request(url, method: .put , parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            self.handleResponse(response: response, completion: completion)
        }
    }
    
    
    func postRequest(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, completion: @escaping (JSON?) -> Void) {
        
        Alamofire.request(url, method: .post , parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                self.handleResponse(response: response, completion: completion)
        }
    }
    
    
    func deleteRequest(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, completion: @escaping (JSON?) -> Void) {
        
        Alamofire.request(url, method: .delete , parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                self.handleResponse(response: response, completion: completion)
        }
    }
    
    
    
    func handleResponse(response: DataResponse<Any>, completion: @escaping (JSON?) -> Void) {

        switch response.result {
        case .success:
            self.showRequestDetailForSuccess(responseObject: response)
            completion(JSON(response.data!))
            break

        case .failure:
            self.showRequestDetailForFailure(responseObject: response)
            completion(JSON(response.result.value!))
            break
        }
    }


    func showRequestDetailForSuccess(responseObject response : DataResponse<Any>) {

        print("\n\n\n ✅ ✅ ✅ ✅ ✅  ------- Success Response Start -------  ✅ ✅ ✅ ✅ ✅ \n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)

        if let bodyData : Data = response.request?.httpBody
        {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + bodyString!)

        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }

        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + responseString!)

        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }

        print("\n\n\n ✅ ✅ ✅  ------- Success Response End -------  ✅ ✅ ✅ \n\n\n")

    }


    func showRequestDetailForFailure(responseObject response : DataResponse<Any>) {

        print("\n\n\n ❌ ❌ ❌ ❌ ❌ ------- Failure Response Start ------- ❌ ❌ ❌ ❌ ❌ \n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)

        if let bodyData : Data = response.request?.httpBody {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + bodyString!)

        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }

        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + responseString!)

        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }

        print("\n\n\n ❌ ❌ ❌ ------- Failure Response End ------- ❌ ❌ ❌ \n")

    }
}

