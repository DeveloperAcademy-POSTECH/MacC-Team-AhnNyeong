//
//  SwiftUIView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 11/5/23.
//

import SwiftUI

struct MensStatusView: View {
    @Binding var selectedUserType: ContentView.LoginType
    @State private var showNew = false
    @State private var checkMensNotStarted = false
    let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "Y년 M월 d일(EEE)"
        return formatter
    }()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    TodayMensInfoView(title: "오늘 생리 중")
                        .padding(.top, 10)
                        .onAppear {
                            // if 생리 시작 입력이 예정일로부터 14일간 입력되지 않은 사람이 있으면
                            checkMensNotStarted = true
                        }
                        .alert(isPresented: $checkMensNotStarted) {
                            Alert(
                                title: Text("생리 시작 지연 알림"),
                                message: Text("하월경의 생리 시작 입력이 예정일로부터 \n14일간 입력되지 않고 있습니다."),
                                primaryButton: .default(Text("알림 중단"), action: {
                                    // some Action
                                }),
                                secondaryButton: .default(Text("확인")))
                        }
                    NextMensInfoView(title: "곧 생리 예정")
                    Spacer()
                }
                .padding(.horizontal, 16)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            // TODO: - AdminAlarmListView 모달로 출력
                        }, label: {
                            ToolbarBellView(badgeCnt: 999)
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showNew = true
                        }, label: {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(Color.coral500)
                        })
                    }
                }
                .toolbarBackground(Color.white300, for: .navigationBar)
                .navigationDestination(isPresented: $showNew) { SettingMainView(selectedUserType: $selectedUserType, userName: "이김생리")
                }
                .navigationTitle(Text("\(dateformat.string(from: Date()))"))
            }
            .background(Color.white300)
        }
    }
}

#Preview {
    MensStatusView(selectedUserType: .constant(.notyet))
}
