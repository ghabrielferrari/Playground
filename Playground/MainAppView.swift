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
    
    // Estado de login persistente
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("userEmail") private var userEmail = ""
    
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
        .onAppear {
            if !isLoggedIn {
                print("Usuário não está logado. Redirecionando para LoginView.")
            }
            // Forçar logout temporário ao carregar a tela principal
            //logout()
        }
    }
    
    // Função para fazer logout
    private func logout() {
        print("Iniciando logout...")
        
        // Resetar o estado de login
        isLoggedIn = false
        
        // Limpar o email do usuário
        userEmail = ""
        
        print("Logout concluído.")
    }
}
