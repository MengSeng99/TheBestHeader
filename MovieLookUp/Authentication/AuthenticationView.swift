//
//  AuthenticationView.swift
//  MovieLookUp
//
//  Created by student on 14/06/2023.
//

import SwiftUI

struct AuthenticationView: View{
    
    @Binding var showSignInView: Bool
    @Binding var showSignUpView: Bool
    
    var body: some View {
        VStack {
            Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding(.bottom, 20)
            
            NavigationLink(destination: SignInView(showSignInView: $showSignInView)) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }

            NavigationLink(destination: SignUpView(showSignUpView: $showSignUpView)) {
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
        .navigationTitle("Welcome to NetMov!")
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AuthenticationView(showSignInView: .constant(false), showSignUpView: .constant(false))
        }
    }
}


