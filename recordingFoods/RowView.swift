//
//  RowView.swift
//  recordingFoods
//
//  Created by 神戸颯斗 on 2024/08/29.
//

import SwiftUI

struct RowView: View {
    @ObservedObject var viewModel = FirebaseModel()
    let dateFormatter = DateFormatter()
    init() {
        dateFormatter.dateFormat = "YYYY/MM/dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ja_jp")
    }
    let kindArray1 = ["肉","魚","卵","豆類","乳製品","いも類"]
    var body: some View {
        VStack{
            HStack{
                Text("\(dateFormatter.string(from: Date()))")
                    .padding()
                Spacer()
            }
            HStack{
                ForEach(kindArray1, id: \.self) { item in
                    Text(item)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            HStack{
                Text("色の濃い野菜")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10)
                Text("生野菜")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10)
                Text("果物")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10)
                Text("海藻")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    RowView()
}
