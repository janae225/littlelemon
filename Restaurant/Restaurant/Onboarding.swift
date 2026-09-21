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
        NavigationStack {
            VStack {
                Image("Logo")
                
                Text("Create an account")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.vertical, 40)
                
                VStack {
                    HStack {
                        Text("First Name *")
                            .foregroundStyle(Color("Primary 2"))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    TextField("", text: $firstName)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                }
                .padding(.bottom, 20)
                
                VStack {
                    HStack {
                        Text("Last Name *")
                            .foregroundStyle(Color("Primary 2"))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    TextField("", text: $lastName)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                }
                .padding(.bottom, 20)
                
                VStack {
                    HStack {
                        Text("Email *")
                            .foregroundStyle(Color("Primary 2"))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    TextField("", text: $email)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                }
                .padding(.bottom, 40)
                
                Button(action: {
                    if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        
                        isLoggedIn = true
                        
                        
                    }
                    
                    
                }) { Text("Register")
                        .padding(15)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .background(Color("Primary 3"))
                    .clipShape(RoundedRectangle(cornerRadius: 15))}
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onAppear {
                if(UserDefaults.standard.bool(forKey: kIsLoggedIn)) {
                    isLoggedIn = true
                }
            }
            .padding(.horizontal, 15)
            .navigationDestination(isPresented: $isLoggedIn) { Home() }
        }
    }
}

#Preview {
    Onboarding()
}
