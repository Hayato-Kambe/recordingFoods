//
//  MenuView.swift
//  recordingFoods
//
//  Created by 神戸颯斗 on 2024/07/29.
//

import SwiftUI
import FirebaseFirestore

struct MenuView: View {
    @State var MenuisPresented = false
    @State var isChecked = false
    @State var answerArray = [false,false,false,false,false,false,false,false,false,false]
    @State var questionArray = ["肉","魚","卵","大豆製品","乳製品","いも類","色の濃い野菜","生野菜","果物","海藻"]
    @State var date = Date()
    @ObservedObject var firestoreModel = FirestoreModel()
    @State var titleText = ""
    let kindArray1 = ["肉","魚","卵","豆類","乳製品","いも類"]
    let kindArray2 = ["色の濃い野菜","生野菜","果物","海藻"]
    let dateFormatter = DateFormatter()
    @State var selection = 1
    @State var components = Calendar.current.dateComponents([.weekOfYear], from: Date())
    init() {
        dateFormatter.dateFormat = "YYYY/MM/dd H:mm"
        dateFormatter.locale = Locale(identifier: "ja_jp")
    }
    var body: some View {
        TabView(selection: $selection) {
            NavigationView{
                ZStack{
                    List(firestoreModel.foodRow.sorted { $0.date ?? Date() > $1.date ?? Date()}) {  index in
                        VStack{
                            HStack{
                                Text("\(dateFormatter.string(from: index.date))")
                                Spacer()
                            }
                            VStack{
                                HStack{
                                    Text("\(index.title)")
                                    Spacer()
                                }
                                HStack{
                                    ForEach(0..<6) { item in
                                        Text(kindArray1[item])
                                            .padding(5)
                                            .foregroundColor(.white)
                                            .background(index.QuestionBoolArray[item] ? Color.red : Color.gray)
                                            .cornerRadius(10)
                                    }
                                }
                                HStack{
                                    ForEach(0..<4) { item in
                                        Text(kindArray2[item])
                                            .padding(5)
                                            .foregroundColor(.white)
                                            .background(index.QuestionBoolArray[item + 6] ? Color.red : Color.gray)
                                            .cornerRadius(10)
                                    }
                                }
                            }.padding()
                        }
                    }
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Button{
                                MenuisPresented = true
                            }label: {
                                Image(systemName: "plus")
                                    .frame(width: 60, height: 60)
                                    .imageScale(.large)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .padding()
                            }
                        }
                    }
                    .sheet(isPresented: $MenuisPresented){
                        VStack{
                            HStack{
                                Button{
                                    MenuisPresented = false
                                }label: {
                                    Text("キャンセル")
                                        .padding()
                                }
                                Spacer()
                                Button{
                                    MenuisPresented = false
                                    date = Date()
                                    components = Calendar.current.dateComponents([.weekOfYear], from: date)
                                    Firestore.firestore().collection("foodRow").document(UUID().uuidString).setData(["Question1": answerArray[0],"Question2": answerArray[1],"Question3": answerArray[2],"Question4": answerArray[3],"Question5": answerArray[4],"Question6": answerArray[5],"Question7": answerArray[6],"Question8": answerArray[7],"Question9": answerArray[8],"Question10": answerArray[9],"date": date,"title": titleText,"weekOfYear": components.weekOfYear])
                                }label: {
                                    Text("登録")
                                        .padding()
                                }
                            }
                            TextField(
                                "タイトル",
                                text: $titleText
                            ).padding()
                            List {
                                ForEach(0..<10) {index in
                                    HStack{
                                        Text("\(questionArray[index])")
                                        Toggle(isOn: $answerArray[index]) {
                                        }
                                    }
                                }
                            }.listStyle(.grouped)
                            
                        }
                    }
                }
            }
            .navigationBarTitle("foodRecord")
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(1)
            LogView()
                .tabItem {
                    Label("Log", systemImage: "chart.xyaxis.line")
                }
        }
    }
}

#Preview {
    MenuView()
}
