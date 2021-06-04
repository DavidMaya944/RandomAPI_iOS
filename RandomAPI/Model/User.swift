//
//  User.swift
//  RandomAPI
//
//  Created by administrador on 17/5/21.
//

import UIKit
import Foundation

struct UserResult: Codable {
    let results: [User]
}

struct User: Codable {
    var gender: String
    var name: UserName
    var location: UserLocation
    var email: String
    var login: UserLogin
    var dob: UserDate
    var registered: UserDateRegister
    var phone: String
    var cell: String
    var id: UserId?
    var picture: UserPicture
    var nat: String
    var info: Info?
}

struct UserName: Codable {
    var title: String
    var first: String
    var last: String
}

struct UserLocation: Codable {
    struct Street: Codable {
        var number: Int
        var name: String
    }
    struct Coordenates: Codable {
        var latitude: String
        var longitude: String
    }
    struct TimeZone: Codable {
        var offset: String
        var description: String
    }
    var street: Street
    var city: String
    var state: String
    var country: String
    var postcode: String
    var coordinates: Coordenates
    var timezone: TimeZone
    
    enum CodingKeys: CodingKey {
        case street
        case city
        case state
        case country
        case postcode
        case coordinates
        case timezone
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        street = try container.decode(Street.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        country = try container.decode(String.self, forKey: .country)
        state = try container.decode(String.self, forKey: .state)
        
        do {
            postcode = try container.decode(String.self, forKey: .postcode)
        } catch DecodingError.typeMismatch {
            postcode = "\(String(describing: try? container.decode(Int.self, forKey: .postcode)))"
        }
        coordinates = try container.decode(Coordenates.self, forKey: .coordinates)
        timezone = try container.decode(TimeZone.self, forKey: .timezone)
        
        
    }
}

struct UserLogin: Codable {
    var uuid: String
    var username: String
    var password: String
    var salt: String
    var md5: String
    var sha1: String
    var sha256: String
}

struct UserDate: Codable {
    var date: String
    var age: Int
}

struct UserDateRegister: Codable{
    var date: String
    var age: Int
}

struct UserPicture: Codable {
    var large: URL
    var medium: URL
    var thumbnail: URL
}

struct UserId: Codable {
    var name: String
    var value: String?
}

struct Info: Codable {
    var seed: String
    var results: Int
    var page: Int
    var version: String
}
