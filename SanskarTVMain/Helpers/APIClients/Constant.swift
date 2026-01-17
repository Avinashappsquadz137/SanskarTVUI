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

    static let getMenuMaster                  = "data_model_v1/menu_master/get_menu_master"
    static let getShortsVideo                   = "data_model/Shorts_video/get_shorts_video"
    static let controlSearchVideos              = "data_model/videos/video_control/search_videos"
    static let masterSearchCentralSearch              = "data_model/user/Master_search/centralSearch"
}


