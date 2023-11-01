//
//  ManagerMemoInputView.swift
//  AhnNyeong
//
//  Created by qwd on 10/30/23.
//

import SwiftUI

struct ManagerMemoInputView: View {
    var body: some View {
        //navigationStack 들어가면 되겠다~ (원래는 chevron 있음)
        Text("개인 증상 태그 ")
            .fontWeight(.bold)
            .font(.title)
            .padding(.trailing, 150)
        VStack(alignment:. leading) {
            TagRectangleGray()
                .overlay {
                    Text("불규칙한 생리 주기")
                        .fontWeight(.regular)
                        .font(.system(size: 18))
                }
            HStack {
                TagRectangleWhite()
                    .overlay {
                        Text("도전적 행동 주의")
                            .fontWeight(.regular)
                            .font(.system(size: 18))
                    }
                TagRectangleGray()
                    .overlay {
                        Text("과다 월경")
                            .fontWeight(.regular)
                            .font(.system(size: 18))
                    }
            }
            TagRectangleWhite()
                .overlay {
                    Text("불규칙한 생리 주기")
                        .fontWeight(.regular)
                        .font(.system(size: 18))
                }
            TagRectangleGray()
                .overlay {
                    Text("커스텀 작성하기")
                        .fontWeight(.regular)
                        .font(.system(size: 18))
                }
            }.padding(.vertical,10)
        MemoView()
    }
}

struct TagRectangleGray: View {
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
            .frame(width: 160, height: 40)
            .foregroundColor(.secondary)
    }
}

struct TagRectangleWhite: View {
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
            .stroke(Color.black, lineWidth: 1)
            .frame(width: 160, height: 40)
            .foregroundColor(.white)

    }
}

struct MemoView: View {
    @State private var memoText: String = ""

    var body: some View {
        VStack {
            TextField("기타 메모 작성", text: $memoText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 350, height: 50)
                .foregroundColor(.pink)
                .padding()
            Button {
                //some action is here
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .padding(.horizontal, 20)
                    .frame(height: 60)
                    .foregroundColor(.black)
                    .overlay {
                        Text("저장하기")
                            .fontWeight(.semibold)
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    }
            }

        }
        .padding(.horizontal ,10)
    }
}



#Preview {
    ManagerMemoInputView()
}
