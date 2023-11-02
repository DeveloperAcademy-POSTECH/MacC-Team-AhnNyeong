//
//  OnboardingView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var tag: Int? = nil
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color(.coral300).ignoresSafeArea()
                VStack(alignment: .center, spacing: 20) {
                    
                    Image("AppTitle")
                        .resizable()
                        .frame(width: 126, height: 55)
                    Image("SMOnboarding")
                        .resizable()
                        .frame(width: 130, height: 213.69817)
                        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
                    Text("마이모미와 함께 \n소중한 월경 주기를 관리해보아요")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 1, green: 1, blue: 1))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                NavigationLink(destination: LoginView(), tag: 1, selection: self.$tag) {
                    Button(action: {
                        //누르면 LoginView로 넘어감
                        self.tag = 1
                    }, label: {
                        Rectangle()
                            .frame(width: 361, height: 58)
                            .cornerRadius(61)
                            .foregroundColor(Color(red: 1, green: 0.99, blue: 0.95))
                            .overlay {
                                Text("시작하기")
                                  .font(
                                    Font.custom("Pretendard", size: 18)
                                      .weight(.bold)
                                  )
                                  .multilineTextAlignment(.center)
                                  .foregroundColor(Color(red: 1, green: 0.29, blue: 0.26))
                            }
                    })
                    .padding(.bottom, 70)
                }
            }
            .ignoresSafeArea()
        }

    }
}

#Preview {
    OnboardingView()
}
