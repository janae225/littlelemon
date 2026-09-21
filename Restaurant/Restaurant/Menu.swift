//
//  Menu.swift
//  Restaurant
//
//  Created by JaNae Strickland on 8/27/26.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//            sortDescriptors: [NSSortDescriptor(keyPath: \Dish.title, ascending: true)],
//            animation: .default
//        ) private var dishes: FetchedResults<Dish>
    
    @State private var isUserProfileActive = false
    @State var searchText:String = ""
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let url = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let request = URLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Issue arose fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let menuItems = try decoder.decode(MenuList.self, from: data)
                
                // Perform Core Data modifications on the context's correct queue
                viewContext.perform {
                    for menuItem in menuItems.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        dish.category = menuItem.category
                        dish.descr = menuItem.descr
                    }
                    
                    do {
                        try viewContext.save()
                        print("Successfully saved \(menuItems.menu.count) items to Core Data")
                    } catch {
                        print("Failed to save to database: \(error)")
                    }
                }
            } catch {
                print("JSON decoding failed: \(error)")
            }
        }
        dataTask.resume()
    }
    
    
    
    var HeaderView: some View {
        VStack {
            HStack() {
                Spacer()
                Image("Logo")
                    .padding(.trailing, 20)
                NavigationLink {
                    UserProfile()
                } label: {  Image("profile-image-placeholder")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 30)
                }
            }
        }
    }
    
    var HeroView: some View {
        VStack {
            HStack {
                Text("Little Lemon")
                Spacer()
            }
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(Color("Primary 3"))
                .padding(.leading, 20)
                .padding(.top, 20)
            HStack() {
                Text("Chicago")
                Spacer()
            }
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
                .padding(.leading, 20)
                .padding(.bottom, 10)
            HStack(alignment: .top) {
                Text("This a mobile app designed for ordering food from the Little Lemon restaurant in Chicago.")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .frame(height: 200)
                Image("Bruschetta")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding(.horizontal, 15)
            
            HStack {
                Image(systemName: "magnifyingglass.circle.fill")
                    .foregroundColor(Color("Primary 2"))
                TextField("Search menu...", text: $searchText)

            }
            .padding(10)
            .background(Color.white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding(15)
                
        }
        .background(Color("Primary 1"))
    }
    
    var MenuBreakdownView: some View {
        VStack {
            HStack {
                Text("ORDER FOR DELIVERY!")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
            }
            .padding(.bottom, 20)
            
            ScrollView(.horizontal) {
                HStack {
                    Button(action: {}) {
                        Text("Starters")
                            .padding(15)
                            .foregroundColor(Color("Primary 2"))
                            .fontWeight(.bold)
                            .background(Color("Primary 1").opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.trailing, 15)
                    Button(action: {}) {
                        Text("Mains")
                            .padding(15)
                            .foregroundColor(Color("Primary 2"))
                            .fontWeight(.bold)
                            .background(Color("Primary 1").opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.trailing, 15)
                    Button(action: {}) {
                        Text("Desserts")
                            .padding(15)
                            .foregroundColor(Color("Primary 2"))
                            .fontWeight(.bold)
                            .background(Color("Primary 1").opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.trailing, 15)
                    Button(action: {}) {
                        Text("Drinks")
                            .padding(15)
                            .foregroundColor(Color("Primary 2"))
                            .fontWeight(.bold)
                            .background(Color("Primary 1").opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.trailing, 15)
                }
            }
        }
        .padding(20)
    }
    
    var body: some View {
        
        HeaderView
        ScrollView {
            HeroView
            MenuBreakdownView
            
            FetchedObjects(
                predicate: buildPredicate(searchString: searchText),
                sortDescriptors: buildSortDescriptors()) {
                    (dishes: [Dish]) in
                        LazyVStack {
                            ForEach(dishes) { dish in
                                VStack {
                                    MenuItemCard(dish: dish)
                                    Divider()
                                        .frame(height: 1)
                                        .background(.gray.opacity(0.5))
                                }
                                
                            }
                            
                        }
                        .padding(.horizontal, 15)
            }
        }
        .scrollIndicators(.hidden)
        .onAppear {
            getMenuData()
        }
    }
    
}

struct MenuItemCard: View {
    var dish:Dish
    var dishPrice: Double
        
    init(dish: Dish) {
        self.dish = dish
        self.dishPrice = Double(dish.price ?? "0.00") ?? 0.00
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dish.title ?? "--Title--")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                Text(dish.descr ?? "--Description--")
                    .font(.system(size: 20))
                    .foregroundColor(Color("Primary 2"))
                    .padding(.top, 5)
                Text(dishPrice, format: .currency(code: "USD"))
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(Color("Primary 2"))
                    .padding(.top, 5)
            }
            
            Spacer()

            AsyncImage(url: URL(string:dish.image ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
                .frame(width: 75, height: 75)
        }
        
    }
}

func buildSortDescriptors () -> [NSSortDescriptor] {
    return [NSSortDescriptor(key: "title", ascending:true, selector: #selector(NSString.localizedStandardCompare))];
}

func buildPredicate (searchString:String) -> NSPredicate {    
    return searchString.isEmpty ? NSPredicate(format: "TRUEPREDICATE") : NSPredicate(format: "title CONTAINS[cd] %@", searchString)
}


#Preview {
    Menu()
}
