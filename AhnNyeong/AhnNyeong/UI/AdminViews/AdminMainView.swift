//
//  AdminMainView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct AdminMainView: View {
    var body: some View {
        TabView {
            MensStatusView(selectedUserType: .constant(.notyet))
                .tabItem {
                    Image(systemName: "drop.fill")
                    Text("생리 현황")
                }
            AdminCalView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("달력")
                }
            AdminMngView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("이용자 리스트")
                }
        }
        .font(.headline)
        .accentColor(Color.coral500)
    }
}

#Preview {
    AdminMainView()
}
