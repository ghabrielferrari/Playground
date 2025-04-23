import SwiftUI

@main
struct PlaygroundApp: App {
    // Estado de login persistente
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainAppView()
            } else {
                LoginView()
            }
        }
    }
}
