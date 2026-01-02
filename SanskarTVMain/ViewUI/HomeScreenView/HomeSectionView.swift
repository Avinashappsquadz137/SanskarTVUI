//
//  HomeSectionView.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 30/12/25.
//
import SwiftUI

struct HomeSectionView: View {
    let onItemTap: (List) -> Void
    let menu: GetMenu
    let selectedChannelId: String?
    @EnvironmentObject var viewModel: HomeViewModel
    
    private let videoTypeIds: Set<String> = [
        "3",   // TYPE_VIDEO
        "5",
        "11",
        "10",  // TYPE_FREE
        "17",  // TYPE_SHORTS
        "19"   // TYPE_EPISODE
    ]
    private var cardAspectRatio: CGFloat {
        if videoTypeIds.contains(menu.menu_type_id ?? "") {
            return 16.0 / 9.0      // 🔥 ALL VIDEO TYPES
        }
        
        switch menu.menu_type_id {
        case "6": // season
            return 2.0 / 3.0
        default:  // channel
            return 3.0 / 2.0
        }
    }
    
    private var cardWidth: CGFloat {
        if videoTypeIds.contains(menu.menu_type_id ?? "") {
            return 250            // 🔥 video big
        }
        
        switch menu.menu_type_id {
        case "6": // season
            return 150
        default:  // channel
            return 130
        }
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(menu.menu_title ?? "")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .fixedSize(horizontal: true, vertical: false)
                    
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.orange, .red],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 2)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                  
                }) {
                    HStack(spacing: 4) {
                        Text("Show More")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.black)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.orange)
                            
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                }
            }
            
            if let list = menu.list {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 12) {
                        
                        // 🔥 INDEX BASED ForEach (NO DUPLICATE ISSUE)
                        ForEach(Array(list.enumerated()), id: \.offset) { _, item in
                            HomeCardView(
                                item: item,
                                menuTypeId: menu.menu_type_id ?? "",
                                width: cardWidth,
                                aspectRatio: cardAspectRatio,
                                isLive: selectedChannelId == item.id && menu.menu_type_id == "1",
                                showChannelBorder: menu.menu_type_id == "1",
                                showCrown: menu.menu_type_id == "6",
                                newlyReleased: item.newly_released == "1",
                                showPlayIcon: menu.menu_type_id == "19",
                                isCurrentlyPlaying: viewModel.currentlyPlayingId == item.id,
                                isPlaying:
                                        menu.menu_type_id == "19" &&
                                        viewModel.isVideoPlaying &&
                                        viewModel.currentlyPlayingEpisodeId == item.episode_id
                            )
                            .onTapGesture {
                                if menu.menu_type_id == "1" || menu.menu_type_id == "19" {
                                    onItemTap(item)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct HomeCardView: View {
    
    let item: List
    let menuTypeId: String
    let width: CGFloat
    let aspectRatio: CGFloat
    let isLive: Bool
    let showChannelBorder: Bool
    let showCrown: Bool
    let newlyReleased: Bool
    let showPlayIcon: Bool
    let isCurrentlyPlaying: Bool
    let isPlaying: Bool
    
    private var imageURL: URL? {
        let urlString: String
        
        if ["3", "5", "11", "10", "19"].contains(menuTypeId) {
            urlString = item.thumbnail_url ?? ""
        } else if menuTypeId == "6" {
            urlString = item.vertical_banner ?? ""
        }else if menuTypeId == "17" {
            urlString = item.thumbnail ?? ""
        } else {
            urlString = item.image ?? ""
        }
        
        return URL(string: urlString)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    Color.gray.opacity(0.3)
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure:
                    Color.black.opacity(0.2)
                @unknown default:
                    EmptyView()
                }
            }
            if menuTypeId == "19", isPlaying {

                ZStack {
                    Color.black.opacity(0.25)

                    Image(systemName: "pause.circle.fill")
                        .font(.system(size: 44))
                        .foregroundColor(.white)
                        .shadow(radius: 6)
                }
            }

            if menuTypeId == "19", let progress = item.progress, progress > 0 {
                VStack {
                    Spacer()
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.white.opacity(0.3))
                                .frame(height: 4)
                            Rectangle()
                                .fill(Color.red)
                                .frame(
                                    width: geo.size.width * CGFloat(progress) / 100,
                                    height: 4
                                )
                        }
                    }
                    .frame(height: 4)
                    .padding(.horizontal, 6)
                    .padding(.bottom, 6)
                }
            }
            
            HStack (spacing :5){
                if showCrown {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.yellow)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                }
                if newlyReleased {
                    Text("NEW RELEASED")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            LinearGradient(
                                colors: [.yellow, .red],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(6)
                }
                
            }
            // 🔴 LIVE BADGE
            if isLive {
                Text("LIVE")
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.red)
                    .cornerRadius(6)
                    .padding(8)
            }
        }
        .frame(width: width, height: width / aspectRatio)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    showChannelBorder
                    ? (isLive ? Color.red : Color.gray.opacity(0.3))
                    : Color.gray,
                    lineWidth: showChannelBorder ? (isLive ? 2 : 1) : 0
                )
        )
        .clipped()
    }
}
