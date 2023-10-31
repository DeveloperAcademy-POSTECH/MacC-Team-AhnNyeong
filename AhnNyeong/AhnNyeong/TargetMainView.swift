//
//  ImperGreetingView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 10/26/23.
//

import SwiftUI

struct TargetMainView: View {
    @State var startDefaultBtnClick = false
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
                NavigationLink(destination: SympView()) {
                    //MARK: 에러날 시 NavigationLink 전체 주석하고 사용
                    Image("startDefault")
                    .padding(.top, 63)
                }
                Text("생리를 시작했나요?")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.top, 40)
                NavigationLink(destination: CalView()) { //MARK: CalView() 파일명 교체필요, 에러날 시 NavigationLink 전체 주석하고 사용
                    Text("\(Image(systemName: "calendar")) 달력 보기")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(.coral400))
                        .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white).shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 8, x: 0, y: 4))
                    //MARK: - Button Extension 적용필요
                }
                .padding(.top, 40)
            }
            .padding(EdgeInsets(top: 30, leading: 16, bottom: 30, trailing: 16))
        }
    }
}

#Preview {
    TargetMainView()
}
