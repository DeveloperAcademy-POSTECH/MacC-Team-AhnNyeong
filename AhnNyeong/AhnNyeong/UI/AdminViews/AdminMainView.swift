//
//  AdminMainView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct AdminMainView: View {
    @Binding var selectedUserType: ContentView.LoginType
    @State private var showNew = false
    let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "Y년 M월 d일(EEE)"
        return formatter
    }()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text("2023년")
//                                .medium22Black500()
//                            Text("\(dateformat.string(from: Date()))")
//                                .bold28Black500()
//                        }
//                        Spacer()
//                    }
                    TodayMensInfoView(title: "오늘 생리 중")
                    NextMensInfoView(title: "곧 생리 예정")
                    Spacer()
                }
                .padding(.horizontal, 16)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            //
                        }, label: {
                            Image(systemName: "bell")
                                .foregroundColor(Color.coral500)
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
                .navigationDestination(isPresented: $showNew) { SettingMainView(selectedUserType: $selectedUserType, userName: "이김생리")
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text("\(dateformat.string(from: Date()))"))
            }
            .background(Color.white300)
        }
    }
}

#Preview {
    AdminMainView(selectedUserType: .constant(.notyet))
}
