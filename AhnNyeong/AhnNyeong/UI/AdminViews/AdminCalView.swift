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
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(Color.white50)
                .shadow(color: .black500.opacity(0.15), radius: 3.5, x: 0, y: 2)
                .overlay {
                    VStack(spacing: 0) {
                        CalendarView()  // HARD coding
                            .background {
                                RoundedGrid()
                                    .frame(height: 460-24)
                                    .padding(.top, 22.7)
                            }
                            .frame(height: 541)
                    }
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                }
                .frame(height: 560)
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color.white300)
    }
}

struct RoundedGrid: View {
    let borderColor = Color.black75
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .strokeBorder(borderColor, style: StrokeStyle(lineWidth: 0.5))
            VStack(spacing: 0) {
                Spacer()
                ForEach(0..<5, id: \.self) { index in
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(borderColor)
                    Spacer()
                }
            }
            HStack(spacing: 0) {
                Spacer()
                ForEach(0..<6, id: \.self) { index in
                    Rectangle()
                        .frame(width: 0.5)
                        .foregroundColor(borderColor)
                    Spacer()
                }
            }
        }
        .foregroundColor(.clear)
    }
}

#Preview("AdminCalView") {
    AdminCalView()
}
