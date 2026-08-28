//
//  UserProfile.swift
//  Restaurant
//
//  Created by JaNae Strickland on 8/27/26.
//

import SwiftUI

struct UserProfile: View {
    @State private var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State private var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State private var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text(firstName)
                .foregroundStyle(.red)
            Text(lastName)
                .foregroundStyle(.red)
            Text(email)
                .foregroundStyle(.red)
            Button(action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }) { Text("Logout") }
            Spacer()
                
        }
    }
}

#Preview {
    UserProfile()
}
