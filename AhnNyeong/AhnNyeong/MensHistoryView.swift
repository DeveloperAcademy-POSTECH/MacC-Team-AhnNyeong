//
//  MensHistoryView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 10/30/23.
//

import SwiftUI

struct MensHistoryView: View {
    let columns = [GridItem(.flexible(minimum: 200)), GridItem(.flexible(maximum: 30)), GridItem(.flexible())]
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Circle()
                    .foregroundColor(Color(.lightGray))
                    .frame(width: 30, height: 30)
                    .overlay(
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    )
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 17, trailing: 20))
            }
            Rectangle()
                .cornerRadius(20)
                .foregroundColor(.gray)
                .frame(width: 350, height: 590)
                .overlay {
                    VStack {
                        HStack {
                            Text("김생리님")
                                .font(.system(size: 20, weight: .semibold))
                            Text("의")
                                .font(.system(size: 15, weight: .semibold))
                                .padding(.leading, -7)
                            Spacer()
                        }
                        .padding(.top, 27)
                        .padding(.leading, 22)
                        HStack {
                            Text("연간 생리 주기")
                                .font(.system(size: 20, weight: .semibold))
                            Spacer()
                        }
                        .padding(.leading, 22)
                        HStack {
                            Spacer()
                            Image(systemName: "chevron.left")
                            Text("2023")
                                .bold()
                            Image(systemName: "chevron.right")
                        }
                        .padding(.trailing, 30)
                        Divider()
                            .padding(.bottom, 25)
                        LazyVGrid(columns: columns, content: {
                            Text("시작 - 종료")
                            Text("기간")
                            Text("주기")
                        })
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.bottom, 25)
                        ScrollView {
                            VStack {
                                ForEach(0..<12, id: \.self) { _ in
                                    HistoryListView()
                                }
                            }
                            .padding(.bottom, 27)
                        }
                    }
                }
        }
    }
}

struct HistoryListView: View {
    let columns = [GridItem(.flexible(minimum: 200)), GridItem(.flexible(maximum: 30)), GridItem(.flexible())]
    var body: some View {
        Rectangle()
            .cornerRadius(10)
            .foregroundColor(Color(.lightGray))
            .frame(height: 50)
            .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
            .overlay {
                LazyVGrid(columns: columns, content: {
                    Text("11.04 - 11.07")
                    Text("3")
                    Text("30")
                })
                .font(.system(size: 15, weight: .semibold))
            }
    }
}

#Preview {
    MensHistoryView()
}
