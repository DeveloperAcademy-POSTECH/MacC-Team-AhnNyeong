//
//  TodayMensInfoView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 11/4/23.
//

import SwiftUI

struct TodayMensInfoView: View {
    var title: String
    var mensDataCount = 0
    let column = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .bold24White50()
                HStack(spacing: 10) {
                    if mensDataCount == 0 {
                            Text("오늘 생리 중인 사람이 없습니다.")
                                .medium16White50()
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                    } else {
                        LazyVGrid(columns: column, spacing: 10, content: {
                            ForEach(0..<mensDataCount) { _ in
                                HStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("김이최박생리")
                                            .medium16Black500()
                                        HStack(spacing: 5) {
                                            Image("DropFill")
                                            Text("1일째")
                                                .medium16Black500()
                                        }
                                    }
                                    Spacer()
                                }
                                .padding(10)
                                .background(TodayMensInfoDetailBox())
                                .frame(width: 102, height: 63)
                            }
                        })
                    }
                }
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
        .background(TodayMensInfoBackground())
    }
}

struct TodayMensInfoBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.coral300)
            .shadow(color: .black500.opacity(0.15), radius: 4, x: 0, y: 0)
    }
}

struct TodayMensInfoDetailBox: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color.white50)
    }
}

#Preview {
    TodayMensInfoView(title: "오늘 생리 중")
}
