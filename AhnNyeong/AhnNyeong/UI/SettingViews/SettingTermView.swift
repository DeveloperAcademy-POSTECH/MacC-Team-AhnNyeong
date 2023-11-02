//
//  SettingTermView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct SettingTermView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SettingViewTitle(settingViewTitle: "서비스 약관")
            Group {
                NavigationLink(destination: EmptyView()) {  // not completed
                    TermList(termTitle: "(필수) 이용약관 및 정보 수집/이용")
                }
                DividingRectangle(dividingType: .listDivider)
                NavigationLink(destination: EmptyView()) {  // not completed
                    TermList(termTitle: "(필수) 민감정보 수집/이용")
                }
            }
            .padding(.leading, 16)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: BackButton(backBtnTitleType: .titleImage, backButtonTitle: "gearshape.fill"))
        .background(Color.white300)
    }
}

struct TermList: View {
    let termTitle: String
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(termTitle)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black400)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.coral500)
            }
            .padding(.vertical, 22.5)
            .padding(.trailing, 16)
            DividingRectangle(dividingType: .listDivider)
        }
    }
}

#Preview {
    SettingTermView()
}
