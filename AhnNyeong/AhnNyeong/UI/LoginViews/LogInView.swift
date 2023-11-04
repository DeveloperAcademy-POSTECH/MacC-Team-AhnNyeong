//
//  LogInView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct LoginView: View {
    @State var tag: Int? = nil
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
//                Color.white300.ignoresSafeArea()
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("이메일")
                            .fontWeight(.semibold)
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width:361, height: 55)
                            .cornerRadius(10)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .overlay {
                                TextField("MyMomiigmail.com", text: $email)
                                    .padding()
                            }
                            .padding(.vertical,20)
                            .frame(width: 361, height: 55)
                            .cornerRadius(10)
                    }
                    .padding(20)
                    VStack(alignment: .leading) {
                        Text("비밀번호")
                            .fontWeight(.semibold)
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width:361, height: 55)
                            .cornerRadius(10)
                            .overlay {
                                TextField("영문, 특수문자를 조합하여 최소 6자리 이상", text: $password)
                                    .padding()
                            }
                            .padding(.vertical,20)
                            .frame(width: 361, height: 55)
                            .cornerRadius(10)
                    }
                    .padding(20)
                    HStack {
                        Image("radioButton")
//                        Picker(selection: $order. ){
//
//                        }.pickerStyle(RadioGroupPickerStyle())
                        //여기 라디오 버튼 들어가야댐
                        Text("로그인 상태 유지")
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                            .padding(.trailing,210)
                    }
                    Spacer()
                    VStack(alignment:.center, spacing :20){
                        HStack {
                            Text("계정이 없으신가요? ")
                                .font(.system(size:12))
                            NavigationLink("", destination: StartRegiView(), tag: 2, selection: self.$tag)
                            Button {
                                self.tag = 2
                            } label: {
                                Text("회원가입하기")
                                    .underline(true, color: Color.pink)
                                    .font(.system(size: 12))
                                    .foregroundColor(.pink)
                            }

                        }
                        Button {
                            //여긴 아무것도 없음. 
                        } label: {
                            Rectangle()
                                .frame(width: 361, height: 58)
                                .cornerRadius(61)
                                .foregroundColor(Color.coral300)
                                .overlay{
                                    Text("시작하기")
                                        .foregroundColor(.white)
                                }
                        }
                        VStack {
                            HStack(spacing:0){
                                Text("로그인 함으로, ")
                                    .font(.system(size: 12))
                                Text("마이모미")
                                    .foregroundColor(.pink)
                                    .font(.system(size: 12))
                                Text(" 서비스의")
                                    .font(.system(size: 12))
                            }
                            HStack(spacing:0) {
                                Text("Terms & Conditions")
                                    .font(.system(size: 12))
                                    .foregroundColor(.pink)
                                Text(" 그리고 Policies에 동의하는 것으로 간주됩니다.")
                                    .font(.system(size: 12))
                            }
                        }

                    }
                }
                .padding(.vertical, 20)
            }
            .navigationTitle("로그인")
            .navigationBarTitleDisplayMode(.large)
            .background(Color.white300)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                BeforeLogInButton()
            }
        }
    }
}

struct BeforeLogInButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.coral500)
                Text("로그인 취소")
                    .foregroundColor(.coral500)
            }
        }
    }
}



#Preview {
    LoginView()
}
