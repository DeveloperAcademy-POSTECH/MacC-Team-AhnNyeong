//
//  LogInCompView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct LoginCompView: View {
    var body: some View {
        ZStack {
            Color.coral300.ignoresSafeArea()
            VStack(alignment: .center, spacing: 50) {
                VStack {
                    Text("안녕하세요!")
                        .fontWeight(.medium)
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                    Text("오복지 사회복지사님")
                        .fontWeight(.heavy)
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                }
                VStack {
                    Image("SMCheck")
                    Text("로그인 완료")
                        .fontWeight(.semibold)
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

//import SwiftUI
//
//struct LoginCompView: View {
//    @State private var redirectToTestView = false
//    
//    var body: some View {
//        ZStack {
//            Color.coral300.ignoresSafeArea()
//            VStack(alignment: .center, spacing: 50) {
//                VStack {
//                    Text("안녕하세요!")
//                        .fontWeight(.medium)
//                        .font(.system(size: 32))
//                        .foregroundColor(.white)
//                    Text("오복지 사회복지사님")
//                        .fontWeight(.heavy)
//                        .font(.system(size: 32))
//                        .foregroundColor(.white)
//                }
//                VStack {
//                    Image("SMCheck")
//                    Text("로그인 완료")
//                        .fontWeight(.semibold)
//                        .font(.system(size: 22))
//                        .foregroundColor(.white)
//                }
//            }
//            NavigationLink(
//                "",
//                destination: TestView(),
//                isActive: $redirectToTestView
//            )
//            .hidden() // 숨김 처리
//            
//        }
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                redirectToTestView = true
//            }
//        }
//    }
//}





#Preview {
    LoginCompView()
}
