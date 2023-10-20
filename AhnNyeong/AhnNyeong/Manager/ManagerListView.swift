
//  ManagerTargetView.swift
//  backUpMacC
//
//  Created by qwd on 10/14/23.

import SwiftUI

//대상자에 들어갈 정보
struct UserInfo: Identifiable {
    var id = UUID()
    var name: String
    var age: String
}


struct ManagerListView: View {
    @State private var isShowingNameInput = false
    @State private var userName = ""
    @State private var userInfos: [UserInfo] = []

    var body: some View {
        NavigationView {
            VStack(alignment: .trailing) {
                Button(action: {
                    isShowingNameInput = true
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.gray)
                }
        
                .navigationBarItems(trailing:
                    NavigationLink(
                        destination: NameInputView(userName: $userName, userInfos: $userInfos, isShowingNameInput: $isShowingNameInput),
                        isActive: $isShowingNameInput
                    ) {
                        EmptyView()
                    }
                )

                // 저장된 유저 정보를 카드뷰로 표시
                
//                ScrollView(.vertical, showsIndicators: false) {
//                    ForEach(userInfos, id: \.id) { userInfo in
//                        CardView(title: "\(userInfo.name)", description: "나이: \(userInfo.age)")
//                            .padding()
//                    }
//                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 50, maximum: 50)),
                        GridItem(.flexible(minimum: 50, maximum: 50)),
                    ], spacing: 10) {
                        ForEach(userInfos, id: \.id) { userInfo in
                            CardView(title: "\(userInfo.name)", description: "나이: \(userInfo.age)")
                                .padding()
                        }
                    }
                }
            }
        }
        .navigationBarTitle("대상자 정보 입력란")
    }
}


struct NameInputView: View {
    @Binding var userName: String
    @Binding var userInfos: [UserInfo]
    @Binding var isShowingNameInput: Bool
    @State private var targetName = ""
    @State private var targetAge = ""

    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Text("관리 카드 생성")
                    .font(.largeTitle)
                Text("관리할 대상자의 기본정보를 입력해주세요.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .border(.green)
            .padding(40)
            
            TextField("이름을 입력하세요", text: $targetName)
                .padding()
                .border(Color.red)
            TextField("나이를 입력하세요", text: $targetAge)
                .padding()
                .border(Color.black)

            Button(action: {
                let userInfo = UserInfo(name: targetName, age: targetAge)
                userInfos.append(userInfo) // 입력된 정보 저장
                targetName = ""
                targetName.precomposedStringWithCanonicalMapping
                //MARK: - 한글 자소 분리 해결
//                lblTitle.text = targetName.precomposedStringWithCanonicalMapping // 한글 자소분리 해결
                targetAge = ""
                isShowingNameInput = false // 저장 후 현재 뷰 닫기
            }) {
                Text("저장")
                    .font(.title)
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .navigationBarTitle("대상자 정보 입력")
    }
}

struct CardView: View {
    var title: String
    var description: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .padding()
            Text(description)
                .font(.body)
                .padding()
        }
        .frame(width: 300)
        .frame(height: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


#Preview {
    ManagerListView()
}
