//
//  Constant.swift
//  Binko Movi
//
//  Created by Warln on 20/08/22.


import UIKit

class ApiRequest {
    static let shared = ApiRequest()
    
    enum BuildType {
        case dev
        case pro
    }
    
    struct Url {
        static var buildType: BuildType = .pro
        
        static var serverURL: String {
            switch buildType {
            case .dev:
                return "https://app.sanskargroup.in"
            case .pro:
                return "https://app.sanskargroup.in"
            }
        }
    }
}

struct Constant {

    static let getlogin                    = "data_model/menu_master/get_menu_master"
    
}


