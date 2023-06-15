//
//  SettingsView.swift
//  MovieLookUp
//
//  Created by student on 14/06/2023.
//

import SwiftUI

@MainActor
final class SettingsVM: ObservableObject {
    
    func signOut() throws{
        try AuthManager.shared.signOut()
    }
    
    func resetPassword() async throws{
        let authUser = try AuthManager.shared.getAuthUser()
        
        guard let email = authUser.email else{
            throw URLError(.fileDoesNotExist)
        }
        try await AuthManager.shared.resetPassword(email: email)
    }
}

struct SettingsView: View {
    @StateObject private var viewModel = SettingsVM()
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationView {
            TabbedContentView(showSignInView: $showSignInView)
                .navigationBarHidden(true)
        }
        .fullScreenCover(isPresented: $showSignInView) {
            AuthenticationView(showSignInView: $showSignInView, showSignUpView: .constant(false))
        }
    }
}

struct TabbedContentView: View {
    @Binding var showSignInView: Bool
    
    var body: some View {
        TabView {
            DiscoverView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            SettingsContentView(showSignInView: $showSignInView)
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
    }
}

struct SettingsContentView: View {
    @Binding var showSignInView: Bool
    @StateObject private var viewModel = SettingsVM()
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
            
            List {
                emailSection
                
                Button("Log Out") {
                    Task {
                        do {
                            try viewModel.signOut()
                            showSignInView = true
                        } catch {
                            print(error)
                        }
                    }
                }
                .foregroundColor(.red)
            }
        }
    }
    
    private var emailSection: some View {
        Section(header: Text("Email Function")) {
            Button("Reset Password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password Reset")
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}




struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView(showSignInView: .constant(false))
        }
        .preferredColorScheme(.dark) 
    }
}


extension SettingsView {
    private var emailSection: some View {
        Section(header: Text("Email Function")) {
            Button("Reset Password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password Reset")
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

        

