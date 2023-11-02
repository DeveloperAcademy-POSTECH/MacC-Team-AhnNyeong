//
//  SettingGuideView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct SettingGuideView: View {
    @State var showAdminGuide = false
    @State var showTargetGuide = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SettingViewTitle(settingViewTitle: "사용 가이드")
            Group {
                ModalButton(showModal: $showAdminGuide, buttonTitle: "사회복지사 앱 사용 가이드")
                .sheet(isPresented: self.$showAdminGuide) {
                    EmptyView()
                }
                ModalButton(showModal: $showTargetGuide, buttonTitle: "이용자 앱 사용 가이드")
                .sheet(isPresented: self.$showTargetGuide) {
                    EmptyView()
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 30)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: BackButton(backBtnTitleType: .titleImage, backButtonTitle: "gearshape.fill"))
        .background(Color.white300)
    }
}

struct ModalButton: View {
    @Binding var showModal: Bool
    let buttonTitle: String
    var body: some View {
        Button(action: {
            self.showModal = true
        }, label: {
            Rectangle()
                .frame(height: 70)
                .foregroundColor(.coral500)
                .cornerRadius(10)
                .shadow(color: .black500.opacity(0.15), radius: 8, x: 0, y: 4)
                .overlay {
                    Text(buttonTitle)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white75)
                }
        })
    }
}

#Preview {
    SettingGuideView()
}
