//
//  AdminMngView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct AdminMngView: View {
    var body: some View {
        ZStack {
            Color.white300.ignoresSafeArea()
            NavigationStack {
                VStack {
                    Text("개별 상세 정보를 열람, 수정할 수 있습니다.")
                        .medium14Black500()
                }
                .navigationTitle("이용자 리스트")
            }
            .background(Color.white300)
        }
    }
}

#Preview {
    AdminMngView()
}
