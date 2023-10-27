//
//  MngSettingView.swift
//  AhnNyeong
//
//  Created by OhSuhyun on 2023.10.27.
//

import SwiftUI

struct MngSettingView: View {
    let userName: String
    let pageSize = 25.0
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "checkmark.shield")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("\(userName) 사회복지사님")
                    .font(.system(size: pageSize, weight: .semibold))
                Image(systemName: "pencil.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
            }
            .frame(height: 24)
            .padding(.top, 120)
            Text("기관 인증됨")
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.white)
                .padding(.all, 4)
                .background {
                    Rectangle()
                        .cornerRadius(4.0)
                        .foregroundColor(.gray)
                }
                .padding(.top, 8)
            Rectangle()
                .roundedCorner(24.0, corners: [.topLeft, .topRight])
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 12.0, y: -4)
                .padding(.top, 40)
                .overlay {
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                        List {
                            Section {
                                SettingList(listTitle: "데이터 관리", listCaption: "대상자와의 데이터를 추가 및 삭제할 수 있습니다.", navigationTo: "")
                                SettingList(listTitle: "알람 설정", listCaption: "생리 현황 알림 받기의 시간대 설정 및 종류별 알림 활성화를 할 수 있습니다. ", navigationTo: "")
                                SettingList(listTitle: "서비스 약관", listCaption: "개인정보처리방침 및 서비스 이용약관을 확인할 수 있습니다. ", navigationTo: "")
                                SettingList(listTitle: "사용 가이드", listCaption: "대상자 앱의 사용 가이드 라인과 본 앱의 사용 가이드를 볼 수 있습니다. ", navigationTo: "")
                                SettingList(listTitle: "이메일 문의", listCaption: "팀 ‘안녕'에게 하실 말씀이나 앱에 대한 개선점을 보내주세요.", navigationTo: "")
                                Text("로그아웃")
                                    .font(.system(size: 20.0, weight: .semibold))
                                    .padding(.top, 16)
                            } footer: {
                                HStack(alignment: .center) {
                                    Spacer()
                                    Text("계정삭제")
                                        .underline()
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                .listRowSeparator(.hidden)
                            }
                        }
                        .listStyle(.plain)
                        Spacer()
                    }
                    .padding(.top, 64)
                }
        }
        .ignoresSafeArea()
    }
}

struct SettingList: View {
    let listTitle: String
    let listCaption: String
    let navigationTo: String
    let titleSize = 20.0
    let captionSize = 11.0
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(listTitle)
                    .font(.system(size: titleSize, weight: .semibold))
                Text(listCaption)
                    .font(.system(size: captionSize, weight: .light))
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: titleSize, weight: .semibold))
                .foregroundColor(.gray)
        }
        .padding(.top, 16)
    }
}

#Preview {
    MngSettingView(userName: "오복지")
}

// MARK: - for Specific Rounded Corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
