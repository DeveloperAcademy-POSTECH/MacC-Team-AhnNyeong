//
//  TargetRegiCompView.swift
//  AhnNyeong
//
//  Created by qwd on 11/2/23.
//

import SwiftUI

struct TargetRegiCompView: View {
    var body: some View {
        ZStack {
            Color.coral300.ignoresSafeArea()
            VStack {
                VStack(alignment: .center, spacing: 50) {
                    VStack {
                        Text("안녕하세요!")
                            .fontWeight(.medium)
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                        Text("이김생리 님")
                            .fontWeight(.heavy)
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                    }
                    VStack {
                        Image("SMCheck")
                        Text("회원가입 완료")
                            .fontWeight(.semibold)
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    }
                    
                }
                .padding(.vertical,180)
                VStack(alignment: .center) {
                    HStack(spacing: 0){
                        Text("회원가입을 진행하시면, ")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                        Text("마이모미")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                        Text(" 서비스의")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    HStack(spacing:0){
                        Text("Terms & Conditions")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                        Text(" 그리고 Policies에 동의하는 것으로 간주됩니다.")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                }
                
            }
            
            
            
        }
    }
}

#Preview {
    TargetRegiCompView()
}
