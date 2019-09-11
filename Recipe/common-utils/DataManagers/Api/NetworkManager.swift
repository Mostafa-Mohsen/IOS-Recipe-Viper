//
//  NetworkManager.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager{
    static var networkObserverDelegate: NetworkObserver?
    
    static func connectGetToUrl(parametrs:Parameters,networkObserver:NetworkObserver){
        networkObserverDelegate = networkObserver
        
        Alamofire.request(Constents.BASE_URI, method: .get, parameters: parametrs, encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
            if(response.response?.statusCode == 200){
                if let json = response.result.value as AnyObject? {
                    networkObserverDelegate?.recipesFetchsuccess(data: json)
                }
            }else {
                print(response.error!.localizedDescription)
                networkObserverDelegate?.recipesFetchfailed(message: response.error!.localizedDescription)
            }
        }
    }
    
}
