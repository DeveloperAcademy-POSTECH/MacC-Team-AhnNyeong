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
                Text("\(currentDate, style: .date)")
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
                ForEach(mensInfoStore.mensInfos, id: \.self) { item in
                    ManagerListView(item: item, mensInfoStore: mensInfoStore)
                }
            }
            .onAppear {
                mensInfoStore.listenToRealtimeDatabase()
            }
            .onDisappear {
                mensInfoStore.stopListening()
            }

        }
        .padding(.top, 20)
    }
}

struct ManagerListView: View {
    @State var item: MensInfo
    var mensInfoStore: MensInfoStore
    
    var body: some View {
        Rectangle()
            .frame(width: 362, height: 120)
            .foregroundColor(.gray)
            .cornerRadius(20)
            .overlay {
                HStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .overlay(
                            Text("생리통 \n\(item.mensSymp)")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            
                        )
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .overlay(Text("생리양 \n\(item.mensAmt)")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        )
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                        .overlay(Text("감정 \n\(item.emoLv)")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        )
                }
            }
    }
}
//#Preview {
//    ManagerViewForMVP()
//}

