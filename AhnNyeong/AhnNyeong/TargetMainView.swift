//
//  ImperGreetingView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 10/26/23.
//

import SwiftUI

struct TargetMainView: View {
    @State var startDefaultBtnClick = false
    @State var calendarBtnClick = false
    @State var toSympView = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text("안녕하세요!")
                        .font(.system(size: 32, weight: .semibold))
                    HStack(alignment: .firstTextBaseline) {
                        Text("이김생리님")
                            .font(.system(size: 32, weight: .heavy)) 
                        //MARK: - weight extraBold로 변경필요 -> Font extension 추후 적용
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                Button(action: {
                    startDefaultBtnClick = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        toSympView = true
                    }
                }, label: {
                    Image(startDefaultBtnClick ? "startPressed" : "startDefault")
                        .padding(.top, 63)
                })
                Text(startDefaultBtnClick ? "생리를 시작했어요!" : "생리를 시작했나요?")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(startDefaultBtnClick ? Color(.coral500) : .black)
                    .padding(.top, 40)
                Button(action: {
                    calendarBtnClick = true
                }, label: {
                    Text("\(Image(systemName: "calendar")) 달력 보기")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(.coral400))
                        .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white).shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 8, x: 0, y: 4))
                })// MARK: - Button Extension 적용필요
                .padding(.top, 40)
            }
            .padding(EdgeInsets(top: 30, leading: 16, bottom: 30, trailing: 16))
//            .navigationDestination(isPresented: $toSympView) {
//                SympView()
//            }
//            .navigationDestination(isPresented: $calendarBtnClick) {
//                CalView()
//            }
        }
    }
}

#Preview {
    TargetMainView()
}
