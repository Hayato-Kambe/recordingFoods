//
//  FirestoreModel.swift
//  recordingFoods
//
//  Created by 神戸颯斗 on 2024/08/01.
//

import Foundation
import FirebaseFirestore

struct FoodRow: Identifiable{
    var id: String = UUID().uuidString
    var title: String
    var date: Date
    var Question1: Bool
    var Question2: Bool
    var Question3: Bool
    var Question4: Bool
    var Question5: Bool
    var Question6: Bool
    var Question7: Bool
    var Question8: Bool
    var Question9: Bool
    var Question10: Bool
    var QuestionBoolArray: [Bool]
    var weekNumber: Int
}

class FirestoreModel: ObservableObject {
    @Published var foodRow = [FoodRow]()
    let components = Calendar.current.dateComponents([.weekOfYear], from: Date())
    
    init(){
        fetchData()
    }
    
    private var db = Firestore.firestore()
    @objc func fetchData() {
        db.collection("foodRow").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.foodRow = documents.map { (queryDocumentSnapshot) -> FoodRow in
                let data = queryDocumentSnapshot.data()
                let title = data["title"] as? String ?? ""
                let Question1 = data["Question1"] as? Bool ?? false
                let Question2 = data["Question2"] as? Bool ?? false
                let Question3 = data["Question3"] as? Bool ?? false
                let Question4 = data["Question4"] as? Bool ?? false
                let Question5 = data["Question5"] as? Bool ?? false
                let Question6 = data["Question6"] as? Bool ?? false
                let Question7 = data["Question7"] as? Bool ?? false
                let Question8 = data["Question8"] as? Bool ?? false
                let Question9 = data["Question9"] as? Bool ?? false
                let Question10 = data["Question10"] as? Bool ?? false
                let date1 = data["date"] as! Timestamp
                let date = date1.dateValue()
                let weekNumber = data["weekOfYear"] as? Int ?? 0
                let QuestionBoolArray = [Question1,Question2,Question3,Question4,Question5,Question6,Question7,Question8,Question9,Question10]
                return FoodRow(title: title, date: date, Question1: Question1, Question2: Question2, Question3: Question3, Question4: Question4, Question5: Question5, Question6: Question6, Question7: Question7, Question8: Question8, Question9: Question9, Question10: Question10, QuestionBoolArray: QuestionBoolArray, weekNumber: weekNumber)
            }
        }
    }
}

