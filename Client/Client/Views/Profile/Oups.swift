//
//  Oups.swift
//  Client
//
//  Created by Emma Gaubert on 27/05/2023.
//

import SwiftUI

struct Oups: View {
    @State private var createAnAccount = false
    @State private var signIn = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Oups")
            Text("That's on us!")
            Text("Profiles are only accessible to logged in users")
            HStack {
                Button("Create an account") {
                    createAnAccount.toggle()
                }
                Button("Sign in") {
                    signIn.toggle()
                }
            }
            .sheet(isPresented: $createAnAccount) {
                CreateAccountView()
            }
            .sheet(isPresented: $signIn) {
                SignInView()
            }
        }
    }
}

struct Oups_Previews: PreviewProvider {
    static var previews: some View {
        Oups()
    }
}
