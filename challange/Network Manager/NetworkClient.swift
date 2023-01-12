//
//  NetworkClient.swift
//  ios-starter-project
//
//  Created by Mehtab Ahmed on 26/06/21.


/*******************************************************************
 FUNCTION PARAMS
 
 'keyPath': By default this wrapper parse JSON from 'response["data"]'
 but if required object is at nested path within 'response["data"]' then keyPath can be use to parse that object. This param can be use to parse a nested object till level 5. You can pass multiple keypath string separated by comma. For example
 
 {
    "data" : {
            "user" : {
                      "favourites": {
                                "fruit" : {
 
                                 }
 
                      }
            }
     }
 }
 
 To parse fruit object in above JSON we can use keyPath as
 keyPath = "user,favourites,fruit"
 
 'parseCompleteResponseToRequiredObject': By default wrapper convert JSON to model object from 'response["data"]' path but if you want to convert whole JSON into your model then pass true in this param
 
********************************************************************/

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

enum Errors: String {
    case NETWORK_ERROR, SERIALIZATION_ERROR, OTHER
    
    var description: String {
        switch self {
        case .NETWORK_ERROR:
            return "No internet connection!"
        case .SERIALIZATION_ERROR:
            return "Cannot parse data. Data is not in the correct format"
        case .OTHER:
            return "Something went wrong"
        }
    }
}


class NetworkClient: NetworkManager {
    
    static let shared = NetworkClient()
    
    var isNetworkAvailable:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    private init() {
        super.init()
    }
    
    
    func getRequest<T: Decodable>(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, keyPath:String = "",checkInternetConnectivity:Bool = true, parseCompleteResponseToRequiredObject: Bool = false,  showLoader:Bool = true, completion: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        
        if checkInternetConnectivity {
            if !isNetworkAvailable {
                failure(Errors.NETWORK_ERROR.description)
                return
            }
        }
        
        if showLoader {
            Utility.showLoading()
        }
        
        getRequest(url, parameters: parameters, headers: headers, completion: { [weak self] response in
        
            self?.parseResponse(response: response, keyPath: keyPath, parseCompleteResponseToRequiredObject: parseCompleteResponseToRequiredObject, completion: completion, failure: failure)
        })
    }
    
    
    
    func putRequest<T: Decodable>(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, keyPath:String = "",checkInternetConnectivity:Bool = true, parseCompleteResponseToRequiredObject: Bool = false,  showLoader:Bool = true, completion: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        
        if checkInternetConnectivity {
            if !isNetworkAvailable {
                failure(Errors.NETWORK_ERROR.description)
                return
            }
        }
        
        if showLoader {
            // Show loader here
            Utility.showLoading()
        }
        
        putRequest(url, parameters: parameters, headers: headers, completion: { [weak self] response in
            self?.parseResponse(response: response, keyPath: keyPath, parseCompleteResponseToRequiredObject: parseCompleteResponseToRequiredObject, completion: completion, failure: failure)
        })
    }
    
    
    
    func postRequest<T: Decodable>(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, keyPath:String = "",checkInternetConnectivity:Bool = true,  showLoader:Bool = true, parseCompleteResponseToRequiredObject: Bool = false, completion: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        
        if checkInternetConnectivity {
            if !isNetworkAvailable {
                failure(Errors.NETWORK_ERROR.rawValue)
                return
            }
        }
        
        if showLoader {
            DispatchQueue.main.async {
                Utility.showLoading()
            }
        }
        
        postRequest(url, parameters: parameters, headers: headers, completion: { [weak self] response in
            self?.parseResponse(response: response, keyPath: keyPath, parseCompleteResponseToRequiredObject: parseCompleteResponseToRequiredObject, completion: completion, failure: failure)
        })
    }
    
    
    func deleteRequest<T: Decodable>(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, keyPath:String = "",checkInternetConnectivity:Bool = true, parseCompleteResponseToRequiredObject: Bool = false,  showLoader:Bool = true, completion: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        
        if checkInternetConnectivity {
            if !isNetworkAvailable {
                failure(Errors.NETWORK_ERROR.description)
                return
            }
        }
        
        if showLoader {
            Utility.showLoading()
        }
        
        deleteRequest(url, parameters: parameters, headers: headers, completion: { [weak self] response in
            self?.parseResponse(response: response, keyPath: keyPath, parseCompleteResponseToRequiredObject: parseCompleteResponseToRequiredObject, completion: completion, failure: failure)
        })
        
  //      justForTesting()
    }
    
    
    func multipartRequest<T: Decodable>(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, keyPath:String = "",checkInternetConnectivity:Bool = true,  showLoader:Bool = true, parseCompleteResponseToRequiredObject:Bool = false, completion: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        
        if checkInternetConnectivity {
            if !isNetworkAvailable {
                failure(Errors.NETWORK_ERROR.rawValue)
                return
            }
        }
        
        if showLoader {
            // Show loader here
        }
        
        multipartRequest(url, parameters: parameters, headers: headers, completion: { [weak self] response in
            self?.parseResponse(response: response, keyPath: keyPath, parseCompleteResponseToRequiredObject: parseCompleteResponseToRequiredObject, completion: completion, failure: failure)
            
        }, failure: { error in
            failure(error)
        })
    }
    
    
    
    func parseResponse<T: Decodable>(response: JSON?, keyPath:String, parseCompleteResponseToRequiredObject: Bool, completion: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        
        Utility.hideLoading()
        
        
        if var response = response {
            
            parseJSON(json: response, completion: completion, failure: failure)
            
           
            /*if response["success"].boolValue {
                
                if T.self is BaseResponse.Type || parseCompleteResponseToRequiredObject {
                    parseJSON(json: response, completion: completion, failure: failure)
                    return
                }
                
                if keyPath != "" {
                    var json:JSON?
                    if keyPath.contains(",") {
                        let keyPathComponents = keyPath.components(separatedBy: ",")
                        switch keyPathComponents.count {
                        
                        case 1:
                            json = response["data"][keyPathComponents[0]]
                        case 2:
                            json = response["data"][keyPathComponents[0]][keyPathComponents[1]]
                        case 3:
                            json = response["data"][keyPathComponents[0]][keyPathComponents[1]][keyPathComponents[2]]
                        case 4:
                            json = response["data"][keyPathComponents[0]][keyPathComponents[1]][keyPathComponents[2]][keyPathComponents[3]]
                        case 5:
                            json = response["data"][keyPathComponents[0]][keyPathComponents[1]][keyPathComponents[2]][keyPathComponents[3]][keyPathComponents[4]]
                        default:
                            print("Invalid keyPath")
                        }
                    }
                    else {
                        json = response["data"][keyPath]
                    }
                    
                    parseJSON(json: json!, completion: completion, failure: failure)
                    
                } else {
                    
                    parseJSON(json: response["data"], completion: completion, failure: failure)
                }
                
            }
            else {
                failure(response["message"].string ?? "")
            }*/
        }
        // hide loader here
        
    }
    
    
    
    func parseJSON<T: Decodable>(json:JSON, completion: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        
        do {
            let data = try json.rawData()
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            completion(parsedData)
            
        }
        
        catch DecodingError.keyNotFound(let key, let context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        } catch DecodingError.valueNotFound(let type, let context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        } catch DecodingError.typeMismatch(let type, let context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        } catch DecodingError.dataCorrupted(let context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        }
    }
}
