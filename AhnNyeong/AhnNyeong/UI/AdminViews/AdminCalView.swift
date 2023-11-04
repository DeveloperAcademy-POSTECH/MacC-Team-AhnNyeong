//
//  AdminCalView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct AdminCalView: View {
    var body: some View {
        VStack(spacing: 0) {
            CalendarView()
                .background(Color.cyan.opacity(0.1))
                .padding(EdgeInsets(top: 32, leading: 16, bottom: 32, trailing: 16))
                .background {
                    Rectangle()
                        .cornerRadius(10)
                        .foregroundColor(Color.white50)
                        .shadow(color: .black500.opacity(0.15), radius: 3.5, x: 0, y: 2)
                }
            Spacer()
                .frame(height: 200)
        }
        .padding(.horizontal, 16)
        .background(Color.white300)
    }
}

#Preview("AdminCalView") {
    AdminCalView()
}
