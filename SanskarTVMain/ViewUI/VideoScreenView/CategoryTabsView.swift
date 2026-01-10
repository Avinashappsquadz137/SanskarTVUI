//
//  CategoryTabsView.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 10/01/26.
//
//import SwiftUI
//
//struct CategoryTabsView: View {
//
//    let categories: [Category]
//    @Binding var selected: String
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 12) {
//                ForEach(categories, id: \.id) { category in
//                    CategoryTabItem(
//                        title: category.categoryName,
//                        isSelected: selected == category.categoryName
//                    ) {
//                        selected = category.categoryName == "All" ? "" : category.categoryName
//                    }
//                }
//            }
//            .padding(.horizontal)
//        }
//    }
//}
//
//struct CategoryTabItem: View {
//    let title: String
//    let isSelected: Bool
//    let onTap: () -> Void
//
//    var body: some View {
//        textView
//            .background(backgroundColor)
//            .foregroundColor(textColor)
//            .cornerRadius(20)
//            .overlay(border)
//            .onTapGesture(perform: onTap)
//    }
//
//    private var textView: some View {
//        Text(title)
//            .padding(.horizontal, 16)
//            .padding(.vertical, 8)
//    }
//
//    private var backgroundColor: Color {
//        isSelected ? .orange : .white
//    }
//
//    private var textColor: Color {
//        isSelected ? .white : .gray
//    }
//
//    private var border: some View {
//        RoundedRectangle(cornerRadius: 20)
//            .stroke(Color.orange, lineWidth: 1)
//    }
//}
