//
//  ManagerMainView.swift
//  backUpMacC
//
//  Created by qwd on 10/19/23.
//

import SwiftUI

struct ManagerMainView : View {
  var body: some View {
    TabView {
        ManagerCalendarView()
        .tabItem {
          Image(systemName: "house")
            Text("홈")
        }
        ManagerListView()
        .tabItem {
          Image(systemName: "doc.text.magnifyingglass")
          Text("리스트")
        }
        ManagerSettingView()
        .tabItem {
          Image(systemName: "ellipsis.circle")
          Text("설정")
        }
    }
    .font(.headline)
    .tint(.pink)
  }
}
#Preview {
    ManagerMainView()
}

