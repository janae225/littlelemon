//
//  UserProfile.swift
//  Restaurant
//
//  Created by JaNae Strickland on 8/27/26.
//

import SwiftUI

struct UserProfile: View {
    @State private var firstName:String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State private var lastName:String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State private var email:String = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @State private var showAlert = false
    
    @Environment(\.presentationMode) var presentation
    
    
    var body: some View {
        VStack() {
            HStack {
                Text("Personal Information")
                    .font(.system(size: 24, weight: .bold))
                Spacer()
            }
            
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("Avatar")
                        .fontWeight(.semibold)
                    Image("profile-image-placeholder")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                    .padding(.trailing, 10)
                Button(action: {
                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                    UserDefaults.standard.set(lastName, forKey: kLastName)
                    UserDefaults.standard.set(email, forKey: kEmail)
                    
                    showAlert = true
                    
                    
                }) {
                    Text("Change")
                        .padding(15)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .background(Color("Primary 2"))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                }
                .padding(.trailing, 15)
                    
                Button(action: {}) {
                    Text("Remove")
                        .padding(15)
                        .foregroundColor(Color("Primary 2"))
                        .fontWeight(.bold)
                        .border(Color("Primary 2"), width: 2)
                }
                Spacer()
            }
            .padding(.bottom, 20)
            
            
            VStack {
                HStack {
                    Text("First Name")
                        .foregroundStyle(Color("Primary 2"))
                        .fontWeight(.semibold)
                    Spacer()
                }
                TextField("", text: $firstName)
                    .padding(15)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
            }
            .padding(.bottom, 20)
            
            VStack {
                HStack {
                    Text("Last Name")
                        .foregroundStyle(Color("Primary 2"))
                        .fontWeight(.semibold)
                    Spacer()
                }
                TextField("", text: $lastName)
                    .padding(15)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
            }
            .padding(.bottom, 20)
            
            VStack {
                HStack {
                    Text("Email")
                        .foregroundStyle(Color("Primary 2"))
                        .fontWeight(.semibold)
                    Spacer()
                }
                TextField("", text: $email)
                    .padding(15)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
            }
            .padding(.bottom, 20)
            
            Spacer()
            
            Button(action: {
                firstName = ""
                lastName = ""
                email = ""
                
                UserDefaults.standard.set("", forKey: kFirstName)
                UserDefaults.standard.set("", forKey: kLastName)
                UserDefaults.standard.set("", forKey: kEmail)
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
            }) { Text("Log out")
                    .padding(15)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .background(Color("Primary 3"))
                    .clipShape(RoundedRectangle(cornerRadius: 15))}
            
            Spacer()
                
        }
            .padding(.horizontal, 15)
            .alert("Information saved!", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    self.presentation.wrappedValue.dismiss()
                }
            }
            .onAppear {
                firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
                email = UserDefaults.standard.string(forKey: kEmail) ?? ""
            }
    }
}

#Preview {
    UserProfile()
}
