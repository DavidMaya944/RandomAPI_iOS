//
//  UserNetworking.swift
//  RandomAPI
//
//  Created by administrador on 17/5/21.
//

import UIKit
import Foundation
import Alamofire

struct UserNetworking : Decodable{
    
    public func getUser( completionHandlers: @escaping (_ user: User) -> ()) {
        let dataRequest: DataRequest = AF.request("https://randomuser.me/api/", method: .get)
        
        dataRequest.response { (DDResponse) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let responseData = DDResponse.data else{
                return
            }
            var result: UserResult
            do{
                result = try decoder.decode(UserResult.self, from: responseData)
                guard let user = result.results.first else {
                    print("Something went wrong. Does not have users" )
                    return
                }
                completionHandlers(user)
            }catch let error{
                print("Something went wrong. \(error.localizedDescription)" )
                print(error)
            }
            
            
        }
    }
}
