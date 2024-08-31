//
//  FirebaseModel.swift
//  recordingFoods
//
//  Created by 神戸颯斗 on 2024/08/27.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class FirebaseModel: ObservableObject{
    @Published var isAuthenticated = false
    @Published var signedEmail = ""
    
    private var db = Firestore.firestore()
    
    init(){
        observeAuthChanges()
    }
    private func observeAuthChanges(){ //Firebase Authの状態が変更されると走る
        Auth.auth().addStateDidChangeListener { [weak self] _, user in //[weak self]は弱参照、参照しながらメモリ領域を解放
            DispatchQueue.main.async{
                self?.isAuthenticated = user != nil
            }
        }
    }
    func signIn(email: String, password: String){ //サインイン設定
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async{
                if result != nil, error == nil{ //成功したらisAuthenticatedをtrueに
                    self?.isAuthenticated = true
                    self?.signedEmail = email
                }
            }
        }
    }
    func signUp(email: String, password: String){ //新たにサインアップする設定
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async{
                if result != nil, error == nil{ //成功したらisAuthenticatedをtrueに
                    self?.isAuthenticated = true
                }
            }
        }
    }
    func resetPassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            if let error = error{
                print("Error in sending password reset: \(error)")
            }
        }
    }
    func signOut(){
        do{
            try Auth.auth().signOut()
            isAuthenticated = false //signOutしてisAuthenticatedをfalseに
        }catch let signOutError as NSError{
            print("Error signing out", signOutError)
        }
    }
}

class foodRowData: NSObject {
    var uid: String?
    var date: Date?
    var Question1: Bool?
    var Question2: Bool?
    var Question3: Bool?
    var Question4: Bool?
    var Question5: Bool?
    var Question6: Bool?
    var Question7: Bool?
    var Question8: Bool?
    var Question9: Bool?
    var Question10: Bool?
    
    init(document: QueryDocumentSnapshot) {
        self.uid = document.documentID
        let Dic = document.data()
        self.date = Dic["date"] as? Date
        self.Question1 = Dic["Question1"] as? Bool
        self.Question2 = Dic["Question2"] as? Bool
        self.Question3 = Dic["Question3"] as? Bool
        self.Question4 = Dic["Question4"] as? Bool
        self.Question5 = Dic["Question5"] as? Bool
        self.Question6 = Dic["Question6"] as? Bool
        self.Question7 = Dic["Question7"] as? Bool
        self.Question8 = Dic["Question8"] as? Bool
        self.Question9 = Dic["Question9"] as? Bool
        self.Question10 = Dic["Question10"] as? Bool
    }
}
