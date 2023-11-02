//
//  StartRegiView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct StartRegiView: View {
    @State var tag: Int? = nil
    var body: some View {
        ZStack {
            Color.white300.ignoresSafeArea()
            NavigationStack {
                VStack(spacing: 5) {
                    NavigationLink("", destination: MngRegiView(), tag: 3, selection: self.$tag)
                    Button(action: {
                        self.tag = 3
                    }, label: {
                        Rectangle()
                            .frame(width: 361, height: 70)
                            .cornerRadius(10)
                            .foregroundColor(Color.coral500)
                            .overlay {
                                Text("사회복지사 회원가입")
                                    .fontWeight(.bold)
                                    .font(.system(size: 17))
                                    .foregroundColor(.white)
                            }
                    })
                    NavigationLink("", destination: TargetRegiView(), tag: 4, selection: self.$tag)
                    Button(action: {
                        //누르면 이용자 회원가입으로 넘어가야함
                        self.tag = 4
                    }, label: {
                        Rectangle()
                            .frame(width: 361, height: 70)
                            .cornerRadius(10)
                            .foregroundColor(Color.coral500)
                            .overlay {
                                Text("이용자 회원가입")
                                    .fontWeight(.bold)
                                    .font(.system(size: 17))
                                    .foregroundColor(.white)
                            }
                    })
                    Spacer()
                    
                }
                    .navigationTitle("회원 가입")
                    .navigationBarBackButtonHidden()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){
                            BeforeSignInButton()
                        }
                    }
                
            }
        }

    }
}
struct BeforeSignInButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.coral500)
                Text("회원가입 취소")
                    .foregroundColor(.coral500)
            }
        }
    }
}

#Preview {
    StartRegiView()
}

