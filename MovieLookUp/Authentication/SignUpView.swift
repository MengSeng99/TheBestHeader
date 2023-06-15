//
//  SignUpView.swift
//  MovieLookUp
//
//  Created by student on 14/06/2023.
//

import SwiftUI

@MainActor
final class SignUpVM: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        try await AuthManager.shared.createUser(email: email, password: password)
    }
}


struct SignUpView: View {
    
    @StateObject private var viewModel = SignUpVM()
    @Binding var showSignUpView: Bool
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Image("logo")
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 300, height: 300)
               .padding(.bottom, 20)
        
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .padding()
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .padding()

            Spacer()
            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        showSignUpView = false
                        showAlert = true 
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Sign Up Successful"), message: Text("You can now sign in."), dismissButton: .default(Text("OK")))
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignUpView: .constant(false))
    }
}


