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
            Color.black.ignoresSafeArea(.all)
            NavigationStack {
                VStack {
                    MngViewTitle()
                    VStack{
                        
                    }
                }
//                .navigationTitle("이용자 리스트")
            }
        }
    }
}
struct MngViewTitle: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("이용자 리스트")
                .bold28Black500()
                .foregroundColor(.black400)
            Text("개별 상세 정보를 열람, 수정할 수 있습니다.")
                .medium14Black500()
        }
    }
}

#Preview {
    AdminMngView()
}
