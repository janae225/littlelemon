//
//  Onboarding.swift
//  Restaurant
//
//  Created by JaNae Strickland on 8/27/26.
//
let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "logged in key"

import SwiftUI

struct Onboarding: View {
    @State private var firstName:String = ""
    @State private var lastName:String = ""
    @State private var email:String = ""
    @State var isLoggedIn = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) { EmptyView() }
                TextField("First Name", text: $firstName)
                    .padding(10)
                TextField("Last Name", text: $lastName)
                    .padding(10)
                TextField("Email", text: $email)
                    .padding(10)
                Button(action: {
                    if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        
                        isLoggedIn = true
                        
                        
                    }
                    
                    
                }) {
                    Text("Register")
                }
            }.onAppear {
                if(UserDefaults.standard.bool(forKey: kIsLoggedIn)) {
                    isLoggedIn = true
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
