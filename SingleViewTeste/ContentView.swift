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
                TicketsView()
            }
            .tabItem {
                NavigationLink(destination:  TicketsView()){
                    Image(systemName: "ticket")
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
