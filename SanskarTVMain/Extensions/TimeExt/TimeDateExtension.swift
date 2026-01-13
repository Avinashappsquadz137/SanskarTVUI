//
//  TimeDateExtension.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 29/12/25.
//
import Foundation
import SwiftUI


extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool,
                                          transform: (Self) -> Content,
                                          else elseTransform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            elseTransform(self)
        }
    }
}

func formatTime(seconds: Double) -> String {
    guard !seconds.isNaN && !seconds.isInfinite else { return "00:00" }
    let totalSeconds = Int(seconds)
    let hours = totalSeconds / 3600
    let minutes = (totalSeconds % 3600) / 60
    let secs = totalSeconds % 60
    
    if hours > 0 {
        return String(format: "%d:%02d:%02d", hours, minutes, secs)
    } else {
        return String(format: "%02d:%02d", minutes, secs)
    }
    
}
//MARK: Epoch
func convertEpochMillisToDate(
    _ epochMillis: String,
    format: String = "dd MMM yyyy, hh:mm a"
) -> String {
    
    guard let millis = Double(epochMillis) else { return "Invalid Date" }
    let date = Date(timeIntervalSince1970: millis / 1000)
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.locale = Locale.current
    formatter.timeZone = TimeZone.current
    
    return formatter.string(from: date)
}
