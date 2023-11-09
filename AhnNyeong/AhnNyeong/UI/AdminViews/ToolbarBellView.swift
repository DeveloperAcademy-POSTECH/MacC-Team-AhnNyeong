//
//  ToolbarBellView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 11/5/23.
//

import SwiftUI

struct ToolbarBellView: View {
    var badgeCnt: Int
    var body: some View {
        ZStack {
            Image(systemName: "bell")
                .foregroundColor(Color.coral500)
            Text(badgeCnt < 100 ? "\(badgeCnt)" : "99+")
                .foregroundColor(badgeCnt == 0 ? .clear : .white50)
                .font(Font.caption)
                .padding(EdgeInsets(top: 3, leading: 5, bottom: 3, trailing: 5))
                .background(BadgeBackgroundView(badgeCnt: badgeCnt))
                .offset(x: 10, y: -12)

        }
    }
}

struct BadgeBackgroundView: View {
    var badgeCnt: Int
    var body: some View {
        if badgeCnt < 10 {
            Circle()
                .foregroundColor(badgeCnt == 0 ? .clear :Color.coral500)
        } else {
            Capsule()
                .foregroundColor(badgeCnt == 0 ? .clear : Color.coral500)
                .frame(alignment: .topTrailing)
        }
    }
}

#Preview {
    ToolbarBellView(badgeCnt: 0)
}
