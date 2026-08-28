//
//  Home.swift
//  Restaurant
//
//  Created by JaNae Strickland on 8/27/26.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController()
    
    var body: some View {
        TabView {
            Tab() {
                Menu()
                    .environment(\.managedObjectContext, persistence.container.viewContext)
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
            }
            Tab() {
                UserProfile().tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
            }
        }
            .navigationBarBackButtonHidden(true)
    }        
}

#Preview {
    Home()
}
