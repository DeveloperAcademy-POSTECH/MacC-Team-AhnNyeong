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
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont()], for: .normal)
       }
    @State private var selectedSide: ConnectController = .connected
    var body: some View {
        NavigationStack {
            VStack {
                Text("개별 상세 정보를 열람, 수정할 수 있습니다.")
                    .medium14Black500()
                    .padding(.trailing,120)
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
            .background(Color.white300)
        }
    }
}

//MARK: - SegmentedControl Code
enum ConnectController: String, CaseIterable {
    //CaseIterable protocol: 안에 있는 값들을 배열처럼 사용 가능
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
    //연결됐을 때 나오는 뷰
    var body: some View {
        Text("연결완료")
    }
}
struct WaitingView: View {
    //대기중일 때 나오는 뷰
    var body: some View {
        Text("대기중")
    }
}


#Preview {
    AdminMngView()
}
