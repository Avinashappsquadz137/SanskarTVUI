//
//  MAinTabbarVC.swift
//  InventoryAppUI
//
//  Created by Sanskar IOS Dev on 12/12/24.
//

import Foundation
import Combine   // ✅ MUST
import SwiftUI

@MainActor
final class AppUIState: ObservableObject {
    @Published var isVideoFullscreen: Bool = false
    @Published var showSearchScreen: Bool = false
    @Published var searchText: String = ""
}

struct MAinTabbarVC: View {
    @EnvironmentObject var uiState: AppUIState
    @StateObject private var homeViewModel = HomeViewModel() 
    @State var presentSideMenu = false
    @State private var selectedView = 0

    var body: some View {
        ZStack(){
            
            VStack(){
                if !uiState.isVideoFullscreen {
                    NavBar(
                        presentSideMenu: $presentSideMenu,
                        notificationCount: 5
                    )
                }
                Spacer()
                TabView(selection: $selectedView) {
                    
                    NavigationView {
                        HomeScreenView()
                            .environmentObject(homeViewModel)
                            .toolbar(uiState.isVideoFullscreen ? .hidden : .visible, for: .tabBar)
                            
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("HOME")
                    }.tag(0)
                    
                    NavigationView {
                        BhajanScreenView()
                           
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .tabItem {
                        Image(systemName: "music.note")
                        Text("BHAJAN")
                    }.tag(1)
                    
                    NavigationView {
                        PremiumVideoScreen()
                            
                           
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .tabItem {
                        Image(systemName: "crown.fill")
                        Text("PREMIUM")
                    }.tag(2)
                    
                    NavigationView {
                        VideoScreen()
                           
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .tabItem {
                        Image(systemName: "play.circle.fill")
                        Text("VIDEO")
                    }.tag(3)
                    NavigationView {
                        ShortsViewScreen()
                           
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                    .tabItem {
                        Image(systemName: "infinity.circle.fill")
                        Text("SHORTS")
                    }.tag(5)
                    
                }
                .toolbar(uiState.isVideoFullscreen ? .hidden : .visible, for: .tabBar)
                
                .onAppear(){
                    UITabBar.appearance().backgroundColor = UIColor(.brightOrange)
                }
                .accentColor(.white)
            }
            if uiState.showSearchScreen {
                MasterSearchView()
                    .environmentObject(uiState)
                    .transition(.move(edge: .trailing))
                    .zIndex(10)
            }
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedView, presentSideMenu: $presentSideMenu)))
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor(Color.brightOrange)
            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.normal.iconColor = .black
            itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
            itemAppearance.selected.iconColor = .white
            itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
            tabBarAppearance.stackedLayoutAppearance = itemAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct NavBar: View {

    @Binding var presentSideMenu: Bool
    var notificationCount: Int = 0
    @EnvironmentObject var uiState: AppUIState
    
    var body: some View {
        ZStack {
           
            HStack {
                Button {
                    presentSideMenu.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }
                Image("Sanskarlogos")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                Spacer()

                HStack(spacing: 20) {

                    Button {
                        uiState.showSearchScreen = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }

                    Button {
                        print("Profile tapped")
                    } label: {
                        Image(systemName: "person.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }

                    ZStack(alignment: .topTrailing) {
                        Button {
                            print("Notification tapped")
                        } label: {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }

                        if notificationCount > 0 {
                            Text("\(notificationCount)")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 8, y: -8)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .background(Color.white)
        .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
    }
}


