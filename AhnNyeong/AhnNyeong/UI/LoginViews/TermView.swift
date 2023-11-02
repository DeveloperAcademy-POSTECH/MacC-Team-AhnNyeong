//
//  TermView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct TermView: View {
    @State private var isRadioButton1Selected = false
    @State private var isRadioButton2Selected = false
    @State private var isButtonEnabled = false
    var body: some View {
        ZStack {
            Color.white300.ignoresSafeArea()
            NavigationStack {
                VStack {
                    VStack {
                        HStack {
                            Toggle("", isOn: $isRadioButton1Selected)
                                .padding()
                                .onChange(of: isRadioButton1Selected) { newValue in
                                    updateButtonStatus()
                                }
                            Text("개인 정보 수집 동의")
                            Spacer()
                        }
                        .border(.black)
                    }
                    VStack {
                        Text("서비스 이용약관")
                    }
                    Button(action: {
                        //some action is here.
                    }, label: {
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    })
                    .padding()
                    .disabled(!isButtonEnabled)
                }
                .navigationTitle("약관 동의")
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        GoToLogInViewButton()
                    }
                }
            }
        }
    }
    func updateButtonStatus() {
        isButtonEnabled = isRadioButton1Selected && isRadioButton2Selected
    }
}
struct GoToLogInViewButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.coral500)
                Text("뒤로")
                    .foregroundColor(.coral500)
            }
        }
    }
}

#Preview {
    TermView()
}
