//
//  LogView.swift
//  recordingFoods
//
//  Created by 神戸颯斗 on 2024/08/01.
//

import SwiftUI
import FirebaseFirestore

struct LogView: View {
    @State var countText = ""
    @ObservedObject var firestoreModel = FirestoreModel()
    @State var weekOfYearNum = 0
    @State var currentDate = Date()
    @State var components = Calendar.current.dateComponents([.weekOfYear], from: Date())
    @State var countArray = [0,0,0,0,0,0,0,0,0,0]
    @State var pointArray = [0,0,0,0,0,0,0,0,0,0]
    @State var questionArray = ["肉","魚","卵","大豆製品","乳製品","いも類","色の濃い野菜","生野菜","果物","海藻"]
    let questionforCountArray = ["Question1","Question2","Question3","Question4","Question5","Question6","Question7","Question8","Question9","Question10"]
    var body: some View {
        VStack{
            HStack{
                Button{
                    weekOfYearNum -= 1
                    Task {
                        await pointCount()
                    }
                }label: {
                    Text("前週へ")
                        .padding()
                }
                Spacer()
                Button{
                    components = Calendar.current.dateComponents([.weekOfYear], from: currentDate)
                    weekOfYearNum = components.weekOfYear ?? 0
                    Task {
                        await pointCount()
                    }
                }label: {
                    Text("今週")
                        .padding()
                }
                Spacer()
                Button{
                    weekOfYearNum += 1
                    Task {
                        await pointCount()
                    }
                }label: {
                    Text("次週へ")
                        .padding()
                }
            }
            List {
                ForEach(0..<10) {index in
                    HStack{
                        Text("\(questionArray[index])")
                            .font(.title3)
                        Spacer()
                        Text("\(countArray[index])")
                            .font(.title3)
                        Text("回/週")
                        Text("\(pointArray[index])")
                            .font(.title3)
                        Text("点")
                    }
                }
            }
            Text("総合得点: \(pointArray.reduce(0, +)) /100")
                .font(.title)
                .padding()
        }
    }
    func pointCount() async {
        for item in 0 ..< 10{
            var countQuestion = try! await Firestore.firestore().collection("foodRow").whereField(questionforCountArray[item], isEqualTo: true).whereField("weekOfYear", isEqualTo: weekOfYearNum).count.getAggregation(source: .server)
            countArray[item] = Int(countQuestion.count)
            if countArray[item] > 4{
                pointArray[item] = 10
            }else if countArray[item] > 1 {
                pointArray[item] = 5
            }else{
                pointArray[item] = 0
            }
        }
    }
}

#Preview {
    LogView()
}
