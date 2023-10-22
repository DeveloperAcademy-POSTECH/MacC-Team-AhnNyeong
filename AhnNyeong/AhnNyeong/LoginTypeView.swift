//
//  LoginTypeView.swift
//  AhnNyeong
//
//  Created by OhSuhyun on 2023.10.22.
//

import SwiftUI

struct LoginTypeView: View {
    @Binding var selectedUserType: ContentView.LoginType

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("마이 모미")
                .font(.headline)
                .padding(.bottom, 46.19)
            Text("사용 시작하기")
                .font(.subheadline)
                .padding(.bottom, 11.65)
            Text("우리가 지정해준 역할로 접속하면 되고 어쩌고 잉")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 36.53)

            VStack {
                NavigationLink(destination:ManagerViewForMVP(selectedUserType: $selectedUserType)) {
                    Button {
                        selectedUserType = .mng
                    } label: {
                        Rectangle()
                            .cornerRadius(20)
                            .foregroundColor(.secondary)
                            .frame(height: 80)
                            .overlay {
                                Text("관리자 로그인")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                    }
                    .font(.title)
                    .padding(.bottom, 19.58)
                }
                
                NavigationLink(destination: ImperView()) {
                    Button {
                        selectedUserType = .imper
                    } label: {
                        Rectangle()
                            .cornerRadius(20)
                            .foregroundColor(.secondary)
                            .frame(height: 80)
                            .overlay {
                                Text("대상자 로그인")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                    }
                    .font(.title)
                }
            }
            .padding(.bottom, 291.91)
            
            Text("본 화면은 사용성 테스트를 위해 제작되었습니다. ")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(width: 330)
            
        }
        .padding(.horizontal, 30)
    }
}

//#Preview {
//    LoginTypeView()
//}
