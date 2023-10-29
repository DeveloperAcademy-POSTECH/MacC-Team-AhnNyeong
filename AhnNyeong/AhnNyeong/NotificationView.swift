//
//  NotificationView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 10/27/23.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Group {
                        Image(systemName: "bell")
                            .font(.title)
                            .foregroundColor(.gray)
                        Ellipse()
                            .foregroundColor(.gray)
                            .frame(width: 37, height: 18)
                            .overlay(
                                Text("999+")
                                    .font(.system(size: 12))
                            )
                            .offset(x:20, y:-10)
                    }
                }
                Spacer()
                Circle()
                    .foregroundColor(Color(.lightGray))
                    .frame(width: 30, height: 30)
                    .overlay(
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    )
            }
            
            .padding(EdgeInsets(top: 18, leading: 30, bottom: 15, trailing: 30))
            HStack(spacing: 0) {
                Button(action: {
                    
                }, label: {
                    Text("생리 현황 알림")
                })
                .buttonStyle(NotificationButton())
                .padding(.trailing, 15)
                Button(action: {
                    
                }, label: {
                    Text("일반")
                })
                .buttonStyle(NotificationButton())
                Spacer()
            }
            .padding(EdgeInsets(top: 15, leading:25, bottom: 15, trailing: 25))
            ScrollView {
                HStack {
                    Text("오늘")
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.leading, 25)
                ForEach(0..<2, id: \.self) { index in
                    NotificationListView()
                }
                HStack {
                    Text("어제")
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(EdgeInsets(top: 70, leading: 25, bottom: 0, trailing: 0))
                ForEach(0..<4, id: \.self) { index in
                    NotificationListView()
                }
            }
        }
    }
}

struct NotificationButton: ButtonStyle {
  var labelColor = Color.black
  var backgroundColor = Color.gray
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(labelColor)
      .padding(EdgeInsets(top: 8.5, leading: 11.5, bottom: 8.5, trailing: 11.5))
      .background(Rectangle().fill(backgroundColor).cornerRadius(10))
  }
}

struct NotificationListView: View {
    var body: some View {
        Rectangle()
            .cornerRadius(10)
            .foregroundColor(Color(.lightGray))
            .frame(width: 370, height: 104)
            .overlay {
                ZStack {
                    HStack(alignment: .center) {
                        Rectangle()
                            .cornerRadius(10)
                            .frame(width: 38, height: 38)
                        VStack(alignment: .leading) {
                            Text("확인해주세요")
                                .font(.system(size: 16, weight: .semibold))
                            Text("김생리의 생리 현황 알림 도착")
                                .font(.system(size: 14))
                            Text("생리통 없음, 생리양 보통, 감정상태 좋음")
                                .font(.system(size: 13))
                        }
                        .tracking(-0.9)
                        .padding(.top, 10)
                        Spacer()
                        Rectangle()
                            .cornerRadius(10)
                            .frame(width: 32, height: 32)
                    }
                    .padding(14)
                    HStack{
                        Spacer()
                        VStack {
                            Text("2분 전")
                                .font(.system(size: 13))
                                .tracking(-0.08)
                            Spacer()
                        }
                        .padding(.top, 5)
                    }
                    .padding(.trailing, 14)
                }
            }
    }
}

#Preview {
    NotificationView()
}
