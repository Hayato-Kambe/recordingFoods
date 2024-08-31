//
//  ContentView.swift
//  recordingFoods
//
//  Created by 神戸颯斗 on 2024/08/27.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = FirebaseModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @AppStorage("isPresented") var isPresented: Bool = true
    @State private var isPresented2: Bool = false
    @State private var newEmail: String = ""
    @State private var newPassword: String = ""
    @State private var isPresented3: Bool = false
    @State private var resetEmail: String = ""
    var body: some View {
        NavigationView{
            Button("Sign in/Sign up"){
                isPresented = true
            }
            .padding()
        }.sheet(isPresented: $isPresented){
            VStack{
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button{
                    viewModel.signIn(email: email, password: password)
                    if viewModel.isAuthenticated{
                        isPresented = false
                    }
                }label: {
                    Text("サインインする")
                        .padding()
                }
                Button("新規アカウント作成"){
                    isPresented2 = true
                }
                .padding()
                .sheet(isPresented: $isPresented2){
                    VStack{
                        TextField("Email", text: $newEmail)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        SecureField("password", text: $newPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Button{
                            viewModel.signUp(email: newEmail, password: newPassword)
                            if viewModel.isAuthenticated{
                                isPresented2 = false
                                isPresented = false
                            }
                        }label: {
                            Text("新規アカウント作成")
                                .padding()
                        }
                    }
                }
                Button("パスワードをリセット"){
                    isPresented3 = true
                }.padding()
                    .sheet(isPresented: $isPresented3){
                        VStack{
                            TextField("Email", text: $resetEmail)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            Button{
                                viewModel.resetPassword(email: resetEmail)
                                if viewModel.isAuthenticated{
                                    isPresented3 = false
                                }
                            }label: {
                                Text("パスワードをリセット")
                                    .padding()
                            }
                        }
                    }
            }
        }.interactiveDismissDisabled()
    }
}

#Preview {
    ContentView()
}
