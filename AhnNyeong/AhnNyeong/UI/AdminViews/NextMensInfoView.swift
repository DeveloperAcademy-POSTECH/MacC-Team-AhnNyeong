//
//  NextMensInfoView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 11/4/23.
//

import SwiftUI

struct NextMensInfoView: View {
    var title: String
    var mensDataCount = 10
    let column = [GridItem(.flexible(), alignment: .top), GridItem(.flexible(), alignment: .top)]
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .bold24Black300()
                HStack(spacing: 10) {
                    if mensDataCount == 0 {
                        Text("곧 생리 예정인 사람이 없습니다.")
                            .medium16Black300()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                    } else {
                        LazyVGrid(columns: column, spacing: 10, content: {
                            ForEach(0..<mensDataCount) { _ in
                                NextMensInfoDetailView()
                            }
                        })
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
        .background(NextMensInfoBackground())
    }
}

struct NextMensInfoDetailView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("김이최박생리")
                    .medium16Black500()
                HStack(spacing: 5) {
                    Image("Drop")
                    Text("D-1")
                        .medium16Black500()
                }
                Group {
                    Text("과다월경")
                    Text("도전적 행동 주의")
                }
                .modifier(Regular12Black500())
                .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                .background(TagBackgroundView())
            }
            Spacer()
        }
        .padding(10)
        .background(NextMensInfoDetailBox())
    }
}

struct NextMensInfoBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white50)
            .shadow(color: .black500.opacity(0.15), radius: 4, x: 0, y: 0)
    }
}

struct NextMensInfoDetailBox: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .inset(by: 0.25)
            .stroke(Color.black75, lineWidth: 0.5)
            .foregroundColor(Color.white50)
    }
}

struct TagBackgroundView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor(Color.coral100)
    }
}

#Preview {
    NextMensInfoView(title: "곧 생리 예정")
}
