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
        VStack(alignment: .center, spacing: 10) {
            Text("Oups")
                .font(.largeTitle)
                .fontWeight(.heavy)
            Text("That's on us!")
                .font(.title2)
            Text("Profiles are only accessible to logged in users")
                .font(.callout)
            VStack(alignment: .center, spacing: 10) {
                Button {
                    createAnAccount.toggle()
                } label: {
                    Spacer()
                    Text("create an accout".uppercased())
                        .font(.system(.title2, design: .rounded ))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue))
                Button {
                    signIn.toggle()
                } label: {
                    Spacer()
                    Text("Sign in".uppercased())
                        .font(.system(.title2, design: .rounded ))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.red))
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
