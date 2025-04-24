import SwiftUI
import AuthenticationServices

struct SignInWithApple: UIViewRepresentable {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(context.coordinator, action: #selector(Coordinator.handleSignIn), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isLoggedIn: $isLoggedIn)
    }
    
    class Coordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
        @Binding var isLoggedIn: Bool
        
        init(isLoggedIn: Binding<Bool>) {
            self._isLoggedIn = isLoggedIn
        }
        
        // Retorna a janela atual do app
        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                fatalError("Não foi possível encontrar uma janela ativa.")
            }
            return window
        }
        
        @objc func handleSignIn() {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
        
        // Trata a resposta de sucesso
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            switch authorization.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                let userIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                let email = appleIDCredential.email
                
                print("User ID: \(userIdentifier)")
                print("Full Name: \(String(describing: fullName))")
                print("Email: \(String(describing: email))")
                
                // Salva o User Identifier no Keychain
                if let userIDData = userIdentifier.data(using: .utf8) {
                    let success = KeychainHelper.save(key: "userIdentifier", data: userIDData)
                    if !success {
                        print("Erro ao salvar o ID do usuário no Keychain.")
                    } else {
                        print("ID do usuário salvo com sucesso no Keychain.")
                    }
                }
                
                // Atualiza o estado de login
                isLoggedIn = true
                
            default:
                break
            }
        }
        
        // Trata erros
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print("Erro ao autenticar com Apple: \(error.localizedDescription)")
        }
    }
}
