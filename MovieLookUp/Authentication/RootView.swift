//
//  RootView.swift
//  MovieLookUp
//
//  Created by student on 14/06/2023.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationView {
                SettingsView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authuser = try? AuthManager.shared.getAuthUser()
            self.showSignInView = authuser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationView {
                AuthenticationView(showSignInView: $showSignInView, showSignUpView: .constant(false))
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
        .preferredColorScheme(.dark)
    }
}

