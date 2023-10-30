//
//  MngCalendarView.swift
//  AhnNyeong
//
//  Created by OhSuhyun on 2023.10.30.
//

import SwiftUI

struct MngCalendarView: View {
    @Binding var notiCnt: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "bell")
                    .overlay {
                        Capsule()
                            .fill(notiCnt == 0 ? .clear : .red)
                            .frame(width: 18 * widthMultplier(), height: 18, alignment: .topTrailing)
                            .overlay {
                                if hasTwoOrLessDigits() {
                                    Text("\(notiCnt)")
                                        .foregroundColor(notiCnt == 0 ? .clear : .white)
                                      .font(Font.caption)
                                  } else {
                                    Text("99+")
                                          .foregroundColor(.white)
                                      .font(Font.caption)
                                      .frame(width: 15 * widthMultplier(), height: 15, alignment: .center)
                                  }
                            }
                            .padding(.bottom, 24)
                            .padding(.leading, 32)
                    }
                Spacer()
                Image(systemName: "square")
            }
            .foregroundColor(.gray)
            .font(.system(size: 32))
            .padding(.horizontal, 16)
        }
        .padding(.horizontal, 8)
        
        Spacer()
    }
    
    func hasTwoOrLessDigits() -> Bool {
        return notiCnt < 100
    }
    
    func widthMultplier() -> Double {
        if notiCnt < 10 {   // 한자리수
          return 1.0
        } else if notiCnt < 100 {   // 두자리수
          // two digits
          return 1.5
        } else {    // 세자리수 이사
          return 2.0
        }
      }
}

#Preview {
    MngCalendarView(notiCnt: .constant(5))
}
