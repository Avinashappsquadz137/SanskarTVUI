//
//  VideoCardView.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 10/01/26.
//
import SwiftUI

struct VideoCardView: View {

    let video: Videos

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {

            // 🔹 Thumbnail
            GeometryReader { geo in
                let width = geo.size.width
                let height = width * 9 / 16   // 🎥 16:9 ratio

                ZStack {
                    AsyncImage(url: URL(string: video.thumbnail_url ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(12)

                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(
                            width: width * 0.15,
                            height: width * 0.15
                        )
                        .foregroundColor(.white)
                        .shadow(radius: 4)
                }
            }
            .frame(height: UIScreen.main.bounds.width * 9 / 16)


            // 🔹 Title
            Text(video.video_title ?? "")
                .font(.headline)
                .lineLimit(2)
            Text(video.video_desc ?? "")
                .font(.caption)
                .lineLimit(2)
            // 🔹 Meta Info
            HStack {
                Text(convertEpochMillisToDate(video.published_date ?? "")                                                                        )
                Spacer()
                Text("\(video.views ?? "0") views")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.1), radius: 4)
        .padding(.horizontal)
    }
}
