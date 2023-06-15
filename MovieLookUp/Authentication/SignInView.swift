//
//  SignInView.swift
//  MovieLookUp
//
//  Created by student on 14/06/2023.
//

import SwiftUI

@MainActor
final class SignInVM: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        try await AuthManager.shared.signInUser(email: email, password: password)
    }
}


struct SignInView: View {
    
    @StateObject private var viewModel = SignInVM()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding(.bottom, 20)
            
            TextField("Email",text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .padding()
            
            SecureField("Password", text:  $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .padding()
            
            Button{
                Task {

                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                } catch {
                    print(error)
                }
            }
            }label: {
                Text("Sign In")
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
        .navigationTitle("Sign In")
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(showSignInView: .constant(false))
    }
}

