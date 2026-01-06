//
//  ShortsModels.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 02/01/26.
//

import Foundation
struct ShortsModels : Codable {
    let status : Bool?
    let message : String?
    let data : [Shorts]?
    let error : [String]?

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
        data = try values.decodeIfPresent([Shorts].self, forKey: .data)
        error = try values.decodeIfPresent([String].self, forKey: .error)
    }

}

struct Shorts : Identifiable, Codable {
    let id : String?
    let title : String?
    let description : String?
    let thumbnail : String?
    let video_url : String?
    let total_share : String?
    let total_comments : String?
    let is_liked : String?
    let total_like : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case description = "description"
        case thumbnail = "thumbnail"
        case video_url = "video_url"
        case total_share = "total_share"
        case total_comments = "total_comments"
        case is_liked = "is_liked"
        case total_like = "total_like"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        video_url = try values.decodeIfPresent(String.self, forKey: .video_url)
        total_share = try values.decodeIfPresent(String.self, forKey: .total_share)
        total_comments = try values.decodeIfPresent(String.self, forKey: .total_comments)
        is_liked = try values.decodeIfPresent(String.self, forKey: .is_liked)
        total_like = try values.decodeIfPresent(String.self, forKey: .total_like)
    }

}
