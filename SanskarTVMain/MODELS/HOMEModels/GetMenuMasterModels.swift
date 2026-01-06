//
//  GetMenuMasterModels.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 29/12/25.
//
import Foundation

struct GetMenuMasterModels : Codable {
    let status : Bool?
    let message : String?
    let notification_count : Int?
    let invitation_event : Int?
    var data : [GetMenu]?
    let season_data : [String]?
    let web_view_bhajan : String?
    let web_view_news : String?
    let web_view_video : String?
    let is_premium : Int?
    let is_premium_active : String?
    let live_user : Int?
    let live_user_api_gap_duration : Int?
    let advertisement_status : Int?
    let qr_scanner : String?
    let tv_guide_ios : String?
    let tv_guide_android : String?
    let total_play : String?
    let error : [String]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case notification_count = "notification_count"
        case invitation_event = "invitation_event"
        case data = "data"
        case season_data = "season_data"
        case web_view_bhajan = "web_view_bhajan"
        case web_view_news = "web_view_news"
        case web_view_video = "web_view_video"
        case is_premium = "is_premium"
        case is_premium_active = "is_premium_active"
        case live_user = "live_user"
        case live_user_api_gap_duration = "live_user_api_gap_duration"
        case advertisement_status = "advertisement_status"
        case qr_scanner = "qr_scanner"
        case tv_guide_ios = "tv_guide_ios"
        case tv_guide_android = "tv_guide_android"
        case total_play = "total_play"
        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        notification_count = try values.decodeIfPresent(Int.self, forKey: .notification_count)
        invitation_event = try values.decodeIfPresent(Int.self, forKey: .invitation_event)
        data = try values.decodeIfPresent([GetMenu].self, forKey: .data)
        season_data = try values.decodeIfPresent([String].self, forKey: .season_data)
        web_view_bhajan = try values.decodeIfPresent(String.self, forKey: .web_view_bhajan)
        web_view_news = try values.decodeIfPresent(String.self, forKey: .web_view_news)
        web_view_video = try values.decodeIfPresent(String.self, forKey: .web_view_video)
        is_premium = try values.decodeIfPresent(Int.self, forKey: .is_premium)
        is_premium_active = try values.decodeIfPresent(String.self, forKey: .is_premium_active)
        live_user = try values.decodeIfPresent(Int.self, forKey: .live_user)
        live_user_api_gap_duration = try values.decodeIfPresent(Int.self, forKey: .live_user_api_gap_duration)
        advertisement_status = try values.decodeIfPresent(Int.self, forKey: .advertisement_status)
        qr_scanner = try values.decodeIfPresent(String.self, forKey: .qr_scanner)
        tv_guide_ios = try values.decodeIfPresent(String.self, forKey: .tv_guide_ios)
        tv_guide_android = try values.decodeIfPresent(String.self, forKey: .tv_guide_android)
        total_play = try values.decodeIfPresent(String.self, forKey: .total_play)
        error = try values.decodeIfPresent([String].self, forKey: .error)
    }

}

struct GetMenu : Codable {
    let id : String?
    let menu_title : String?
    let menu_type_id : String?
    let type : String?
    let premium_cat_id : String?
    let premium_auth_id : String?
    let list : [List]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case menu_title = "menu_title"
        case menu_type_id = "menu_type_id"
        case type = "type"
        case premium_cat_id = "premium_cat_id"
        case premium_auth_id = "premium_auth_id"
        case list = "list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        menu_title = try values.decodeIfPresent(String.self, forKey: .menu_title)
        menu_type_id = try values.decodeIfPresent(String.self, forKey: .menu_type_id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        premium_cat_id = try values.decodeIfPresent(String.self, forKey: .premium_cat_id)
        premium_auth_id = try values.decodeIfPresent(String.self, forKey: .premium_auth_id)
        list = try values.decodeIfPresent([List].self, forKey: .list)
    }

}

struct List : Codable {
    let id : String?
    let name : String?
    let description : String?
    let channel_url : String?
    let channel_url_with_ads : String?
    let image : String?
    let banner_thumbnail : String?
    let promo_url : String?
    let likes : String?
    let is_app : String?
    let is_tv : String?
    let is_web : String?
    let is_caching : String?
    let creation_time : String?
    let updation_date : String?
    let status : String?
    let new_status : String?
    let new_status1 : String?
    let third_party_channel_status : String?
    let position : String?
    let is_likes : String?
    let thumbnail_url : String?
    let vertical_banner : String?
    let thumbnail : String?
    let newly_released : String?
    let custom_episode_url : String?
    let progress : Int?
    let pause_at : String?
    let episode_id : String?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case channel_url = "channel_url"
        case channel_url_with_ads = "channel_url_with_ads"
        case image = "image"
        case banner_thumbnail = "banner_thumbnail"
        case promo_url = "promo_url"
        case likes = "likes"
        case is_app = "is_app"
        case is_tv = "is_tv"
        case is_web = "is_web"
        case is_caching = "is_caching"
        case creation_time = "creation_time"
        case updation_date = "updation_date"
        case status = "status"
        case new_status = "new_status"
        case new_status1 = "new_status1"
        case third_party_channel_status = "third_party_channel_status"
        case position = "position"
        case is_likes = "is_likes"
        case thumbnail_url = "thumbnail_url"
        case vertical_banner = "vertical_banner"
        case thumbnail = "thumbnail"
        case newly_released = "newly_released"
        case custom_episode_url = "custom_episode_url"
        case progress = "progress"
        case pause_at = "pause_at"
        case episode_id = "episode_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        channel_url = try values.decodeIfPresent(String.self, forKey: .channel_url)
        channel_url_with_ads = try values.decodeIfPresent(String.self, forKey: .channel_url_with_ads)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        banner_thumbnail = try values.decodeIfPresent(String.self, forKey: .banner_thumbnail)
        promo_url = try values.decodeIfPresent(String.self, forKey: .promo_url)
        likes = try values.decodeIfPresent(String.self, forKey: .likes)
        is_app = try values.decodeIfPresent(String.self, forKey: .is_app)
        is_tv = try values.decodeIfPresent(String.self, forKey: .is_tv)
        is_web = try values.decodeIfPresent(String.self, forKey: .is_web)
        is_caching = try values.decodeIfPresent(String.self, forKey: .is_caching)
        creation_time = try values.decodeIfPresent(String.self, forKey: .creation_time)
        updation_date = try values.decodeIfPresent(String.self, forKey: .updation_date)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        new_status = try values.decodeIfPresent(String.self, forKey: .new_status)
        new_status1 = try values.decodeIfPresent(String.self, forKey: .new_status1)
        third_party_channel_status = try values.decodeIfPresent(String.self, forKey: .third_party_channel_status)
        position = try values.decodeIfPresent(String.self, forKey: .position)
        is_likes = try values.decodeIfPresent(String.self, forKey: .is_likes)
        thumbnail_url = try values.decodeIfPresent(String.self, forKey: .thumbnail_url)
        vertical_banner = try values.decodeIfPresent(String.self, forKey: .vertical_banner)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        newly_released = try values.decodeIfPresent(String.self, forKey: .newly_released)
        custom_episode_url = try values.decodeIfPresent(String.self, forKey: .custom_episode_url)
        progress = try values.decodeIfPresent(Int.self, forKey: .progress)
        pause_at = try values.decodeIfPresent(String.self, forKey: .pause_at)
        episode_id = try values.decodeIfPresent(String.self, forKey: .episode_id)
    }

}

