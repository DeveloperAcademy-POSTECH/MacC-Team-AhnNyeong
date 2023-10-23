//
//  ManagerViewForMVP.swift
//  AhnNyeong
//
//  Created by qwd on 10/22/23.
//

import SwiftUI

struct ManagerViewForMVP: View {
    @Binding var selectedUserType: ContentView.LoginType
    let currentDate = Date()
    @StateObject var mensInfoStore: MensInfoStore = MensInfoStore()
    @State var isClicked = false
    var body: some View {
        VStack {
            HStack(spacing: 100){
                Text("김머쪄 님의 생리 정보")
                    .font(.title)
                    .fontWeight(.semibold)
                NavigationLink(destination: LoginTypeView(selectedUserType: $selectedUserType), label: {
                    Button(action: {
                        selectedUserType = .notyet
                    }, label: {
                        Image(systemName: "arrow.uturn.backward")
                            .resizable()
                            .frame(width:30, height: 30)
                            .foregroundColor(.pink)
                    })
                })
            }
            ScrollView(showsIndicators: false) {
                ForEach(mensInfoStore.mensInfos, id: \.self) { mensInfo in
                    ManagerListView(mensInfo: mensInfo, mensInfoStore: mensInfoStore)
                }
            }
            .onAppear {
                mensInfoStore.listenToRealtimeDatabase()
            }
            .onDisappear {
                mensInfoStore.stopListening()
            }
        }
        .padding(.top, 10)
    }
}

struct ManagerListView: View {
    @State var mensInfo: MensInfo
    var mensInfoStore: MensInfoStore
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(mensInfo.regDe)
                .font(.title3)
                .fontWeight(.semibold)
            Rectangle()
                .frame(width: 362, height: 120)
                .foregroundColor(.teal)
                .cornerRadius(20)
                .overlay {
                    HStack {
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .overlay(
                                Text("생리통 \n\(mensInfo.mensSymp)")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .overlay(Text("생리양 \n\(mensInfo.mensAmt)")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                            )
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .overlay(Text("감정 \n\(mensInfo.emoLv)")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                            )
                    }
                }
        }.padding()

    }
}
//#Preview {
//    ManagerViewForMVP()
//}
