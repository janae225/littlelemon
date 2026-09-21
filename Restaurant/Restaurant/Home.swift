//
//  Home.swift
//  Restaurant
//
//  Created by JaNae Strickland on 8/27/26.
//

import SwiftUI

struct Home: View {
//    let persistence = PersistenceController()
    
    var body: some View {
        Menu()
//            .environment(\.managedObjectContext, persistence.container.viewContext)
            .navigationBarBackButtonHidden(true)
            
    }
}

#Preview {
    Home()
}
