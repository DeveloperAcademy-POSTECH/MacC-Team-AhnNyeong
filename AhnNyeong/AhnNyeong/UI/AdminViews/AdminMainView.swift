//
//  AdminMainView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct AdminMainView: View {
    let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일(EEE)"
        return formatter
    }()
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "bell")
                    .modifier(Regular26Coral500())
                Spacer()
                Image(systemName: "gearshape.fill")
                    .modifier(Regular26Coral500())
            }
            .padding(EdgeInsets(top: 11, leading: 16, bottom: 11, trailing: 16))
            HStack {
                VStack(alignment: .leading) {
                    Text("2023년")
                        .medium22Black500()
                    Text("\(dateformat.string(from: Date()))")
                        .bold28Black500()
                }
                Spacer()
            }
            TodayMensInfo()
            NextMensInfoView()
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color.white300)
    }
}

struct TodayMensInfo: View {
    let column = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("오늘 생리 중")
                    .bold24White50()
                HStack(spacing: 10) {
                    LazyVGrid(columns: column, spacing: 10, content: {
                        ForEach(0..<7) { _ in
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
            Spacer()
        }
        .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
        .background(TodayMensInfoBackground())
    }
}

struct NextMensInfoView: View {
    let column = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("곧 생리 예정")
                    .bold24Black300()
                HStack(spacing: 10) {
                    LazyVGrid(columns: column, spacing: 10, content: {
                        ForEach(0..<7) { _ in
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("김이최박생리")
                                        .medium16Black500()
                                    HStack(spacing: 5) {
                                        Image("Drop")
                                        Text("1일째")
                                            .medium16Black500()
                                    }
                                    Text("과다월경")
                                        .regular12Black500()
                                    Text("도전적 행동 주의")
                                        .regular12Black500()
                                }
                                Spacer()
                            }
                            .padding(10)
                            .background(NextMensInfoDetailBox())
                        }
                    })
                }
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
        .background(NextMensInfoBackground())
    }
}

struct TagBackgroundView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor(Color.coral100)
    }
}

struct TodayMensInfoDetailBox: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color.white50)
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

struct TodayMensInfoBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.coral300)
            .shadow(color: .black500.opacity(0.15), radius: 4, x: 0, y: 0)
    }
}

struct NextMensInfoBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.white50)
            .shadow(color: .black500.opacity(0.15), radius: 4, x: 0, y: 0)
    }
}

#Preview {
    AdminMainView()
}
