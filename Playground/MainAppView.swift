import SwiftUI

// Placeholder para a tela Resumo
struct SummaryView: View {
    var body: some View {
        Text("Tela Resumo")
            .font(.largeTitle)
    }
}

// Placeholder para a tela Trocas e Doações
struct TradesAndDonationsView: View {
    var body: some View {
        Text("Tela Trocas e Doações")
            .font(.largeTitle)
    }
}

// Placeholder para a tela Perfil
struct ProfileView: View {
    var body: some View {
        Text("Tela Perfil")
            .font(.largeTitle)
    }
}

// Barra de navegação inferior
struct MainAppView: View {
    @State private var selectedTab: Tab = .explore
    
    enum Tab {
        case summary
        case explore
        case tradesAndDonations
        case profile
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SummaryView()
                .tabItem {
                    Label("Resumo", systemImage: "house")
                }
                .tag(Tab.summary)
            
            ExploreView()
                .tabItem {
                    Label("Explorar", systemImage: "magnifyingglass")
                }
                .tag(Tab.explore)
            
            TradesAndDonationsView()
                .tabItem {
                    Label("Trocas e Doações", systemImage: "arrow.left.arrow.right")
                }
                .tag(Tab.tradesAndDonations)
            
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.circle")
                }
                .tag(Tab.profile)
        }
        .accentColor(.pink)
    }
}
