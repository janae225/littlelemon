//
//  Menu.swift
//  Restaurant
//
//  Created by JaNae Strickland on 8/27/26.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    func getMenuData() {
        PersistenceController.shared.clear();
        
        let url = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        var request = URLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with:request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let menuItems = try? decoder.decode(MenuList.self, from: data)
                    if let menuItems = menuItems {
                        for menuItem in menuItems.menu {
                            let dish = Dish(context: viewContext)
                            dish.title = menuItem.title
                            dish.image = menuItem.image
                            dish.price = menuItem.price
                        }
                        
                        try? viewContext.save()
                    }
                }
            }
        }
        dataTask.resume()
        
        
    }
    
    @State var searchText:String = ""
    
    var body: some View {
        VStack {
            Text("Little Lemon Restaurant")
            Text("Chicago")
            Text("This a mobile app designed for ordering food from the Little Lemon restaurant in Chicago.")
            
            TextField("Search menu", text: $searchText)
                .padding(15)
            
            FetchedObjects(predicate: buildPredicate(searchString: searchText), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text("\(dish.title ?? "Title") $\(dish.price ?? "Price")\n\(dish.image ?? "Image")")
                            AsyncImage(url: URL(string:dish.image ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                                .frame(width: 75, height: 75)
                        }
                    }
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
}

func buildSortDescriptors () -> [NSSortDescriptor] {
    return [NSSortDescriptor(key: "title", ascending:true, selector: #selector(NSString.localizedStandardCompare))];
}

func buildPredicate (searchString:String) -> NSPredicate {
    return searchString.isEmpty ? NSPredicate(format: "TRUEPREDICATE") : NSPredicate(format: "title CONTAINS[cd] %a", searchString)
}


#Preview {
    Menu()
}
