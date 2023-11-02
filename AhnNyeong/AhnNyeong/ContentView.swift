//
//  ContentView.swift
//  AhnNyeong
//
//  Created by jaelyung kim on 2023/09/12.
//

import SwiftUI

struct ContentView: View {
    enum LoginType: String {
        case imper
        case mng
        case notyet
    }
    
    @AppStorage("LoginType") private var selectedUserType: ContentView.LoginType = .notyet
    
    var body: some View {
        NavigationStack {
            if selectedUserType == .imper {
                SettingMainView(selectedUserType: $selectedUserType, userName: "이김생리")
            } else if selectedUserType == .mng {
                SettingMainView(selectedUserType: $selectedUserType, userName: "오복지")
            } else {
                LoginTypeView(selectedUserType: $selectedUserType)
            }
        }
    }
}

//#Preview {
//    let loginType: ContentView.LoginType
//    ContentView(selectedUserType: ContentView.LoginType.notyet)
//}
