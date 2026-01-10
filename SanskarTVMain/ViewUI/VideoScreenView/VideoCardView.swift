//
//  VideoCardView.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 10/01/26.
//
//import SwiftUI
//
//struct VideoCardView: View {
//
//    let video: Videos
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//
//            ZStack {
//                AsyncImage(url: URL(string: video.thumbnail_url ?? "")) { image in
//                    image
//                        .resizable()
//                        .scaledToFill()
//                } placeholder: {
//                    Color.gray.opacity(0.3)
//                }
//                .frame(height: 200)
//                .clipped()
//
//                Image(systemName: "play.circle.fill")
//                    .resizable()
//                    .frame(width: 50, height: 50)
//                    .foregroundColor(.white)
//            }
//
//            Text(video.video_title ?? "")
//                .font(.headline)
//                .lineLimit(2)
//
//            HStack {
//                Text(video.published_date ?? "")
//                Spacer()
//                Text("\(video.views) views")
//            }
//            .font(.caption)
//            .foregroundColor(.gray)
//        }
//        .background(Color.white)
//        .cornerRadius(12)
//        .shadow(radius: 4)
//        .padding(.horizontal)
//    }
//}

