//
//  MngRegiView.swift
//  AhnNyeong
//
//  Created by qwd on 11/2/23.
//
import SwiftUI

struct MngRegiView: View {
    @State var tag: Int? = nil
    @State var instcode: String = ""
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("소속 기관 코드")
                            .fontWeight(.semibold)
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width:361, height: 55)
                            .cornerRadius(10)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .overlay {
                                TextField("abcedfg", text: $instcode)
                                    .padding()
                            }
                            .padding(.vertical,20)
                            .frame(width: 361, height: 55)
                            .cornerRadius(10)
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text("이름")
                            .fontWeight(.semibold)
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width:361, height: 55)
                            .cornerRadius(10)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .overlay {
                                TextField("박보검", text: $name)
                                    .padding()
                            }
                            .padding(.vertical,20)
                            .frame(width: 361, height: 55)
                            .cornerRadius(10)
                    }
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

                    Spacer()
                    VStack(alignment:.center, spacing :20){
                        NavigationLink("", destination: TermView(), tag: 5, selection: $tag)
                        Button {
                            //some action is here
                            self.tag = 5
                        } label: {
                            Rectangle()
                                .frame(width: 361, height: 58)
                                .cornerRadius(61)
                                .foregroundColor(Color.coral300)
                                .overlay{
                                    Text("다음")
                                        .foregroundColor(.white)
                                }
                        }
                        VStack{
                            HStack(spacing:0){
                                Text("로그인 함으로, ")
                                    .font(.system(size: 12))
                                Text("마이모미")
                                    .foregroundColor(.pink)
                                    .font(.system(size: 12))
                                Text(" 서비스의")
                                    .font(.system(size: 12))
                            }
                            HStack(spacing:0){
                                Text("Terms & Conditions")
                                    .foregroundColor(.pink)
                                    .font(.system(size: 12))
                                Text(" 그리고 Policies에 동의하는 것으로 간주됩니다.")
                                    .font(.system(size: 12))
                            }
                        }
                    }
                }
                .padding(.vertical, 20)
            }
            .background(Color.white300)
            .navigationTitle("사회복지사 회원가입")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                GoToStartRegiButtonForMng()
//                BeforeLogInButton()
            }
        }
    }
}

struct GoToStartRegiButtonForMng: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.coral500)
                Text("이전 화면")
                    .foregroundColor(.coral500)
            }
        }
    }
}

//struct MngRegiTitle: View {
//    var body: some View {
//        HStack {
//            Text("사회복지사")
//                .foregroundColor(Color.coral500)
//            Text(" 회원 가입")
//        }
//    }
//}

#Preview {
    MngRegiView()
}
