//
//  ManagerViewForMVP.swift
//  AhnNyeong
//
//  Created by qwd on 10/22/23.
//
//
import SwiftUI

//struct ManagerViewForMVP: View {
//    @Binding var selectedUserType: ContentView.LoginType
//    @StateObject var mensInfoStore: MensInfoStore = MensInfoStore()
//    @State var isClicked = false
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(mensInfoStore.mensInfos.reversed(), id: \.self) { mensInfo in
//                    ManagerListView(mensInfo: mensInfo, mensInfoStore: mensInfoStore)
//                }
//            }
//
//            .onAppear {
//                mensInfoStore.listenToRealtimeDatabase()
//            }
//            .onDisappear {
//                mensInfoStore.stopListening()
//            }
//        }
//        .navigationBarTitle("김머쪄님의 생리 정보")
//        .navigationBarItems(leading:
//            Button(action: {
//                // 뒤로 돌아가게
//                selectedUserType = .notyet
//            }, label: {
//                Image(systemName: "chevron.left")
//            }))
//    }
//}
//
//struct ManagerListView: View {
//    @State var mensInfo: MensInfo
//    var mensInfoStore: MensInfoStore
//    var body: some View {
//        Section(mensInfo.regDe) {
//            HStack {
//                Text("생리통")
//                Spacer()
//                Text(mensInfo.mensSymp)
//            }
//            HStack {
//                Text("생리 양")
//                Spacer()
//                Text(mensInfo.mensAmt)
//            }
//            HStack {
//                Text("감정 상태")
//                Spacer()
//                Text(mensInfo.emoLv)
//            }
//        }
//    }
//}

//#Preview {
//    ManagerViewForMVP()
//}

