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
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("사용 시작하기")
                    .font(.title2)
                    .padding(.bottom, 11.65)
                Text("대상자로 접속하면 생리 증상을 입력할 수 있습니다.\n관리자로 접속하면 대상자가 입력한 생리 증상을 조회할 수 있습니다.")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.bottom, 36.53)
                VStack {
                    NavigationLink(destination: ManagerViewForMVP(selectedUserType: $selectedUserType)) {
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
                    NavigationLink(destination: ImperView(selectedUserType: $selectedUserType)) {
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
                    Spacer()
                    Text("본 화면은 사용성 테스트를 위해 제작되었습니다. ")
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(EdgeInsets(top: 30, leading: 15, bottom: 25, trailing: 15))
        }
        .navigationTitle("마이모미")
    }
}

//#Preview {
//    LoginTypeView()
//}
