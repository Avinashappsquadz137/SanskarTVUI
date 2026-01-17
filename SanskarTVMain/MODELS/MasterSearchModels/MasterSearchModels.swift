//
//  MasterSearchModels.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 13/01/26.
//
import Foundation

struct MasterSearchModel : Codable {
    let status : Bool?
    let message : String?
    let data : MasterSearch?
    let error : MasterSearchError?

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
        data = try values.decodeIfPresent(MasterSearch.self, forKey: .data)
        error = try values.decodeIfPresent(MasterSearchError.self, forKey: .error)
    }

}

struct MasterSearch : Codable {
    let premium : [MasterSearchPremium]?
    let musics : [MasterSearchMusics]?
    let videos : [MasterSearchVideo]?

    enum CodingKeys: String, CodingKey {

        case premium = "premium"
        case musics = "musics"
        case videos = "videos"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        premium = try values.decodeIfPresent([MasterSearchPremium].self, forKey: .premium)
        musics = try values.decodeIfPresent([MasterSearchMusics].self, forKey: .musics)
        videos = try values.decodeIfPresent([MasterSearchVideo].self, forKey: .videos)
    }

}


struct MasterSearchMusics : Codable {
    let id : String?
    let title : String?
    let description : String?
    let image : String?
    let thumbnail1 : String?
    let thumbnail2 : String?
    let media_file : String?
    let artist_name : String?
    let artist_image : String?
    let mobile_menu_ids : String?
    let category : String?
    let related_guru : String?
    let artists_id : String?
    let god_id : String?
    let god_name : String?
    let god_image : String?
    let likes : String?
    let play_count : String?
    let creation_time : String?
    let published_date : String?
    let status : String?
    let uploaded_by : String?
    let deleted_by : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case description = "description"
        case image = "image"
        case thumbnail1 = "thumbnail1"
        case thumbnail2 = "thumbnail2"
        case media_file = "media_file"
        case artist_name = "artist_name"
        case artist_image = "artist_image"
        case mobile_menu_ids = "mobile_menu_ids"
        case category = "category"
        case related_guru = "related_guru"
        case artists_id = "artists_id"
        case god_id = "god_id"
        case god_name = "god_name"
        case god_image = "god_image"
        case likes = "likes"
        case play_count = "play_count"
        case creation_time = "creation_time"
        case published_date = "published_date"
        case status = "status"
        case uploaded_by = "uploaded_by"
        case deleted_by = "deleted_by"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        thumbnail1 = try values.decodeIfPresent(String.self, forKey: .thumbnail1)
        thumbnail2 = try values.decodeIfPresent(String.self, forKey: .thumbnail2)
        media_file = try values.decodeIfPresent(String.self, forKey: .media_file)
        artist_name = try values.decodeIfPresent(String.self, forKey: .artist_name)
        artist_image = try values.decodeIfPresent(String.self, forKey: .artist_image)
        mobile_menu_ids = try values.decodeIfPresent(String.self, forKey: .mobile_menu_ids)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        related_guru = try values.decodeIfPresent(String.self, forKey: .related_guru)
        artists_id = try values.decodeIfPresent(String.self, forKey: .artists_id)
        god_id = try values.decodeIfPresent(String.self, forKey: .god_id)
        god_name = try values.decodeIfPresent(String.self, forKey: .god_name)
        god_image = try values.decodeIfPresent(String.self, forKey: .god_image)
        likes = try values.decodeIfPresent(String.self, forKey: .likes)
        play_count = try values.decodeIfPresent(String.self, forKey: .play_count)
        creation_time = try values.decodeIfPresent(String.self, forKey: .creation_time)
        published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        uploaded_by = try values.decodeIfPresent(String.self, forKey: .uploaded_by)
        deleted_by = try values.decodeIfPresent(String.self, forKey: .deleted_by)
    }

}


struct MasterSearchVideo : Codable {
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
    }

}

struct MasterSearchPremium : Codable {
    let id : String?
    let mobile_menu_ids : String?
    let web_menu_ids : String?
    let android_tv_ids : String?
    let season_title : String?
    let description : String?
    let season_thumbnail : String?
    let season_banner : String?
    let vertical_banner : String?
    let custom_promo_video : String?
    let short_video : String?
    let yt_short_video : String?
    let promo_video : String?
    let yt_promo_video : String?
    let free_video : String?
    let yt_free_video : String?
    let category_id : String?
    let author_id : String?
    let published_date : String?
    let creation_time : String?
    let modified_time : String?
    let uploaded_by : String?
    let status : String?
    let third_party_season_status : String?
    let position : String?
    let year_of_katha : String?
    let location : String?
    let p_author_name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case mobile_menu_ids = "mobile_menu_ids"
        case web_menu_ids = "web_menu_ids"
        case android_tv_ids = "android_tv_ids"
        case season_title = "season_title"
        case description = "description"
        case season_thumbnail = "season_thumbnail"
        case season_banner = "season_banner"
        case vertical_banner = "vertical_banner"
        case custom_promo_video = "custom_promo_video"
        case short_video = "short_video"
        case yt_short_video = "yt_short_video"
        case promo_video = "promo_video"
        case yt_promo_video = "yt_promo_video"
        case free_video = "free_video"
        case yt_free_video = "yt_free_video"
        case category_id = "category_id"
        case author_id = "author_id"
        case published_date = "published_date"
        case creation_time = "creation_time"
        case modified_time = "modified_time"
        case uploaded_by = "uploaded_by"
        case status = "status"
        case third_party_season_status = "third_party_season_status"
        case position = "position"
        case year_of_katha = "year_of_katha"
        case location = "location"
        case p_author_name = "p_author_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        mobile_menu_ids = try values.decodeIfPresent(String.self, forKey: .mobile_menu_ids)
        web_menu_ids = try values.decodeIfPresent(String.self, forKey: .web_menu_ids)
        android_tv_ids = try values.decodeIfPresent(String.self, forKey: .android_tv_ids)
        season_title = try values.decodeIfPresent(String.self, forKey: .season_title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        season_thumbnail = try values.decodeIfPresent(String.self, forKey: .season_thumbnail)
        season_banner = try values.decodeIfPresent(String.self, forKey: .season_banner)
        vertical_banner = try values.decodeIfPresent(String.self, forKey: .vertical_banner)
        custom_promo_video = try values.decodeIfPresent(String.self, forKey: .custom_promo_video)
        short_video = try values.decodeIfPresent(String.self, forKey: .short_video)
        yt_short_video = try values.decodeIfPresent(String.self, forKey: .yt_short_video)
        promo_video = try values.decodeIfPresent(String.self, forKey: .promo_video)
        yt_promo_video = try values.decodeIfPresent(String.self, forKey: .yt_promo_video)
        free_video = try values.decodeIfPresent(String.self, forKey: .free_video)
        yt_free_video = try values.decodeIfPresent(String.self, forKey: .yt_free_video)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        author_id = try values.decodeIfPresent(String.self, forKey: .author_id)
        published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
        creation_time = try values.decodeIfPresent(String.self, forKey: .creation_time)
        modified_time = try values.decodeIfPresent(String.self, forKey: .modified_time)
        uploaded_by = try values.decodeIfPresent(String.self, forKey: .uploaded_by)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        third_party_season_status = try values.decodeIfPresent(String.self, forKey: .third_party_season_status)
        position = try values.decodeIfPresent(String.self, forKey: .position)
        year_of_katha = try values.decodeIfPresent(String.self, forKey: .year_of_katha)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        p_author_name = try values.decodeIfPresent(String.self, forKey: .p_author_name)
    }

}


struct MasterSearchError: Codable {
    let code: Int?
    let message: String?
}

