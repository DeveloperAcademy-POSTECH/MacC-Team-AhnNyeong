//
//  ManagerTargetInputView.swift
//  AhnNyeong
//
//  Created by qwd on 10/27/23.
//

import SwiftUI

struct PhoneNumberTextField: View {
    @Binding var phoneNumber: String

    var body: some View {
        HStack {
            TextField("전화번호를 입력하세요", text: $phoneNumber)
                .keyboardType(.numberPad)
                .onChange(of: phoneNumber) { newValue in
                    // "-" 기호를 모두 제거
                    phoneNumber = phoneNumber.replacingOccurrences(of: "-", with: "")
                    // 사용자가 입력한 번호 사이에 자동으로 "-" 추가
                    if phoneNumber.count > 3 && phoneNumber.count <= 8 {
                        phoneNumber.insert("-", at: phoneNumber.index(phoneNumber.startIndex, offsetBy: 3))
                    } else if phoneNumber.count > 8 {
                        phoneNumber.insert("-", at: phoneNumber.index(phoneNumber.startIndex, offsetBy: 3))
                        phoneNumber.insert("-", at: phoneNumber.index(phoneNumber.startIndex, offsetBy: 8))
                    }
                }
        }
    }
}

struct ManagerTargetInputView: View {
    @State var name: String = ""
    @State var phoneNumb: String = ""
    
    var body: some View {
        //최상단에 navigationStack 들어가면 되겠다~ (원래는 chevron 있음)
        HStack {
            VStack(alignment: .leading, content: {
                Text("대상자 연결하기")
                    .fontWeight(.bold)
                    .font(.title)
                Text("관리할 대상자의 기본 정보를 입력해주세요.")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("관리할 대상자의 카드를 만들고 연동합니다.")
                    .font(.caption)
                    .foregroundColor(.gray)
            })
            .padding(.trailing, 140)
        }
        .padding(.top,70)
        .padding(.bottom, 100)
        VStack {
            TextField("이름을 입력하세요.", text: $name)
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 2)
                }
                .padding(.vertical,20)
            PhoneNumberTextField(phoneNumber: $phoneNumb)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 2)
                }
        }
        .padding(.horizontal, 20)
        Spacer()

        Button {
            //some action is here
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .padding(.horizontal, 20)
                .frame(height: 60)
                .foregroundColor(.black)
                .overlay{
                    Text("초대하기")
                        .foregroundColor(.white)
                }
        }
    }
}



#Preview {
    ManagerTargetInputView()
}
