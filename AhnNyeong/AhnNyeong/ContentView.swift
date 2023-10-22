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
                ImperMainView()
            } else if selectedUserType == .mng {
//                MngMainView()
                EmptyView() // sample
            } else {
                LoginTypeView(selectedUserType: $selectedUserType)
            }
        }
    }
}

//#Preview {
//    ContentView(selectedUserType: .notyet)
//}
