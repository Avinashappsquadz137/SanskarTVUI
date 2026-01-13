//
//  CategoryTabsView.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 10/01/26.
//
import SwiftUI

struct CategoryTabsView: View {

    let categories: [Category]
    @Binding var selected: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {

                // 🔸 All tab
                CategoryTabItem(
                    title: "All",
                    isSelected: selected.isEmpty
                ) {
                    selected = ""
                }

                ForEach(categories, id: \.id) { category in
                    CategoryTabItem(
                        title: category.category_name ?? "",
                        isSelected: selected == category.id
                    ) {
                        selected = category.id ?? ""
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryTabItem: View {

    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Text(title)
            .font(.system(size: 14, weight: .medium))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color.orange : Color.white)
            .foregroundColor(isSelected ? .white : .gray)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.orange, lineWidth: 1)
            )
            .onTapGesture {
                onTap()
            }
    }
}
