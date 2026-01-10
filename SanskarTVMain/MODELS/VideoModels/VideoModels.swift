//
//  VideoModels.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 10/01/26.
//

import Foundation


struct VideoModels : Codable {
    let status : Bool?
    let message : String?
    let data : VideoResponse?
    let error: ErrorResponse?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        if let object = try? values.decode(VideoResponse.self, forKey: .data) {
            data = object
        } else {
            data = nil
        }
        if let dict = try? values.decode([String: String].self, forKey: .error) {
            error = .dictionary(dict)
        } else if let arr = try? values.decode([String].self, forKey: .error) {
            error = .array(arr)
        } else {
            error = nil
        }
    }
}
enum ErrorResponse: Codable {
    case dictionary([String: String])
    case array([String])

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dictionary(let dict):
            try container.encode(dict)
        case .array(let arr):
            try container.encode(arr)
        }
    }
}
struct VideoResponse : Codable {
    let category : [Category]?
    let banners : [Banners]?
    let videos : [Videos]?

    enum CodingKeys: String, CodingKey {

        case category = "category"
        case banners = "banners"
        case videos = "videos"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent([Category].self, forKey: .category)
        banners = try values.decodeIfPresent([Banners].self, forKey: .banners)
        videos = try values.decodeIfPresent([Videos].self, forKey: .videos)
    }

}

struct Category : Codable {
    let id : String?
    let category_name : String?
    let creation_time : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case category_name = "category_name"
        case creation_time = "creation_time"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        creation_time = try values.decodeIfPresent(String.self, forKey: .creation_time)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Videos : Codable {
    let id : String?
    let mobile_menu_ids : String?
    let android_tv_ids : String?
    let web_menu_ids : String?
    let video_title : String?
    let video_url : String?
    let author_name : String?
    let thumbnail_url : String?
    let thumbnail_url1 : String?
    let video_desc : String?
    let category : String?
    let days : String?
    let is_sankirtan : String?
    let is_popular : String?
    let related_guru : String?
    let author_image : String?
    let comments : String?
    let views : String?
    let likes : String?
    let tags : String?
    let published_date : String?
    let creation_time : String?
    let status : String?
    let youtube_url : String?
    let custom_video_url : String?
    let youtube_views : String?
    let youtube_likes : String?
    let uploaded_by : String?
    let deleted_by : String?
    let multiple_videos : [String]?
    let is_like : String?
    let pause_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case mobile_menu_ids = "mobile_menu_ids"
        case android_tv_ids = "android_tv_ids"
        case web_menu_ids = "web_menu_ids"
        case video_title = "video_title"
        case video_url = "video_url"
        case author_name = "author_name"
        case thumbnail_url = "thumbnail_url"
        case thumbnail_url1 = "thumbnail_url1"
        case video_desc = "video_desc"
        case category = "category"
        case days = "days"
        case is_sankirtan = "is_sankirtan"
        case is_popular = "is_popular"
        case related_guru = "related_guru"
        case author_image = "author_image"
        case comments = "comments"
        case views = "views"
        case likes = "likes"
        case tags = "tags"
        case published_date = "published_date"
        case creation_time = "creation_time"
        case status = "status"
        case youtube_url = "youtube_url"
        case custom_video_url = "custom_video_url"
        case youtube_views = "youtube_views"
        case youtube_likes = "youtube_likes"
        case uploaded_by = "uploaded_by"
        case deleted_by = "deleted_by"
        case multiple_videos = "multiple_videos"
        case is_like = "is_like"
        case pause_at = "pause_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        mobile_menu_ids = try values.decodeIfPresent(String.self, forKey: .mobile_menu_ids)
        android_tv_ids = try values.decodeIfPresent(String.self, forKey: .android_tv_ids)
        web_menu_ids = try values.decodeIfPresent(String.self, forKey: .web_menu_ids)
        video_title = try values.decodeIfPresent(String.self, forKey: .video_title)
        video_url = try values.decodeIfPresent(String.self, forKey: .video_url)
        author_name = try values.decodeIfPresent(String.self, forKey: .author_name)
        thumbnail_url = try values.decodeIfPresent(String.self, forKey: .thumbnail_url)
        thumbnail_url1 = try values.decodeIfPresent(String.self, forKey: .thumbnail_url1)
        video_desc = try values.decodeIfPresent(String.self, forKey: .video_desc)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        days = try values.decodeIfPresent(String.self, forKey: .days)
        is_sankirtan = try values.decodeIfPresent(String.self, forKey: .is_sankirtan)
        is_popular = try values.decodeIfPresent(String.self, forKey: .is_popular)
        related_guru = try values.decodeIfPresent(String.self, forKey: .related_guru)
        author_image = try values.decodeIfPresent(String.self, forKey: .author_image)
        comments = try values.decodeIfPresent(String.self, forKey: .comments)
        views = try values.decodeIfPresent(String.self, forKey: .views)
        likes = try values.decodeIfPresent(String.self, forKey: .likes)
        tags = try values.decodeIfPresent(String.self, forKey: .tags)
        published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
        creation_time = try values.decodeIfPresent(String.self, forKey: .creation_time)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        youtube_url = try values.decodeIfPresent(String.self, forKey: .youtube_url)
        custom_video_url = try values.decodeIfPresent(String.self, forKey: .custom_video_url)
        youtube_views = try values.decodeIfPresent(String.self, forKey: .youtube_views)
        youtube_likes = try values.decodeIfPresent(String.self, forKey: .youtube_likes)
        uploaded_by = try values.decodeIfPresent(String.self, forKey: .uploaded_by)
        deleted_by = try values.decodeIfPresent(String.self, forKey: .deleted_by)
        multiple_videos = try values.decodeIfPresent([String].self, forKey: .multiple_videos)
        is_like = try values.decodeIfPresent(String.self, forKey: .is_like)
        pause_at = try values.decodeIfPresent(String.self, forKey: .pause_at)
    }

}

struct Banners : Codable {
    let id : String?
    let title : String?
    let image : String?
    let position : String?
    let published_date : String?
    let status : String?
    let creation_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case image = "image"
        case position = "position"
        case published_date = "published_date"
        case status = "status"
        case creation_time = "creation_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        position = try values.decodeIfPresent(String.self, forKey: .position)
        published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        creation_time = try values.decodeIfPresent(String.self, forKey: .creation_time)
    }

}

