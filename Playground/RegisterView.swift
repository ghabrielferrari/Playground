import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var saveLoginDetails: Bool = true
    
    // Estado para controlar o alerta de erro
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    // Estado para apresentar a LoginView
    @State private var showLoginView = false
    
    // Armazenamento persistente para os dados de entrada
    @AppStorage("savedEmail") private var savedEmail: String = ""
    @AppStorage("savedPassword") private var savedPassword: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Título
            VStack(alignment: .leading, spacing: 8) {
                Text("Registrar-se")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Preencha os campos para criar sua conta")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            // Campos do formulário
            VStack(spacing: 16) {
                // Username
                VStack(alignment: .leading, spacing: 4) {
                    Text("Nome de usuário")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    TextField("Digite seu nome de usuário", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                }
                
                // Email
                VStack(alignment: .leading, spacing: 4) {
                    Text("Email")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    TextField("Digite seu email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                // Password
                VStack(alignment: .leading, spacing: 4) {
                    Text("Senha")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    SecureField("Digite sua senha", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Confirm Password
                VStack(alignment: .leading, spacing: 4) {
                    Text("Confirmar Senha")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    SecureField("Confirme sua senha", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
            // Checkbox para salvar detalhes
            HStack {
                Toggle(isOn: $saveLoginDetails) {
                    Text("Salvar meus dados de entrada")
                        .font(.footnote)
                }
                .toggleStyle(CheckboxToggleStyle())
            }
            
            Spacer()
            
            // Botão de Sign Up
            Button(action: {
                validateAndRegister()
            }) {
                Text("Registrar")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 32)
        .alert(errorMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
        .fullScreenCover(isPresented: $showLoginView) {
            LoginView()
        }
    }
    
    // Função para validar e registrar o usuário
    private func validateAndRegister() {
        // Verificar se todos os campos estão preenchidos
        guard !username.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Todos os campos são obrigatórios."
            showAlert = true
            return
        }
        
        // Validar o formato do email
        guard isValidEmail(email) else {
            errorMessage = "O email inserido é inválido."
            showAlert = true
            return
        }
        
        // Verificar se as senhas coincidem
        guard password == confirmPassword else {
            errorMessage = "As senhas não coincidem."
            showAlert = true
            return
        }
        
        // Salvar no Keychain
        let userData: [String: String] = ["username": username, "password": password]
        if let userDataEncoded = try? JSONEncoder().encode(userData) {
            let success = KeychainHelper.save(key: email, data: userDataEncoded)
            if success {
                print("Usuário registrado com sucesso!")
                
                // Salvar os dados de entrada se a checkbox estiver marcada
                if saveLoginDetails {
                    savedEmail = email
                    savedPassword = password
                } else {
                    // Limpar os dados salvos se a checkbox estiver desmarcada
                    savedEmail = ""
                    savedPassword = ""
                }
                
                // Limpar os campos após o registro
                username = ""
                email = ""
                password = ""
                confirmPassword = ""
                
                // Apresentar a tela de login
                showLoginView = true
            } else {
                errorMessage = "Erro ao salvar os dados do usuário."
                showAlert = true
            }
        } else {
            errorMessage = "Erro ao processar os dados do usuário."
            showAlert = true
        }
    }
    
    // Função para validar o formato do email
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
