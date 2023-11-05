//
//  AdminMngView.swift
//  AhnNyeong
//
//  Created by qwd on 11/1/23.
//

import SwiftUI

struct AdminMngView: View {
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.coral300)
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .semibold)], for: .normal)
    }
    @State private var selectedSide: ConnectController = .connected
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    Text("개별 상세 정보를 열람, 수정할 수 있습니다.")
                        .medium14Black500()
                        .padding(.trailing, 120)
                    VStack {
                        Picker("Choose a Side", selection: $selectedSide) {
                            ForEach(ConnectController.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        Spacer()
                        ChosenHereView(selectedSide: selectedSide)
                        Spacer()
                    }
                    .navigationTitle("이용자 리스트")
                }
            }
            .background(Color.white300)
        }
    }
}

// MARK: - SegmentedControl Code
enum ConnectController: String, CaseIterable {
    case connected = "연결됨"
    case waiting = "연결 대기중"
}
struct ChosenHereView: View {
    var selectedSide: ConnectController
    var body: some View {
        switch selectedSide {
        case .connected:
            ConnectedView()
        case .waiting:
            WaitingView()
        }
    }
}
struct ConnectedView: View {
    var body: some View {
        TargetFrameView()
    }
}
struct WaitingView: View {
    var body: some View {
        Text("대기중")
    }
}

// MARK: - TargetFrame Layout
struct TargetFrameView: View {
//    var TargetName: String
//    var TargetAge: String
    var body: some View {
        Image("TargetFrame")
            .overlay {
                VStack {
                   Rectangle()
                        .frame(width: 150, height: 29)
                        .cornerRadius(40)
                        .foregroundColor(.coral100)
                        .overlay {
                            Text("김생리A")
                                .semiBold18Black500()
                        }
                    Text("만 33세")
                        .regular18Black75()
//                    Text("만 \(TargetAge)세")
                }
            }
    }
}


#Preview {
    AdminMngView()
}

