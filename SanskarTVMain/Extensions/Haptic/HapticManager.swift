//
//  HapticManager.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 08/01/26.
//
import SwiftUI
import UIKit
final class HapticManager {
    static let shared = HapticManager()
    private init() {}

    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
