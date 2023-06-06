import SwiftUI

struct ContentView: View {
    var body: some View {
     
            TabView {
                NavigationView {
                    MovieListView()
                    
                }
                .tabItem{
                    NavigationLink(destination: MovieListView()){
                        Image(systemName: "house")
                    }
                }
                NavigationView {
                    CartView()
                }
                .tabItem {
                    NavigationLink(destination:  CartView()){
                        Image(systemName: "cart")
                    }
                }
                NavigationView{
                    ProfileView()
                }
                .tabItem {
                    NavigationLink(destination: ProfileView()){
                        Image(systemName: "person.crop.circle")
                    }
                }
            }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
