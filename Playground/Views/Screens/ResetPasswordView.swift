import SwiftUI

struct ResetPasswordView: View {
    @State private var username: String = ""
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var showCurrentPassword: Bool = false
    @State private var showNewPassword: Bool = false
    @State private var saveNewPassword: Bool = true // Checkbox para salvar a nova senha
    
    // Estado para controlar o alerta de erro
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    // Estado para apresentar a LoginView
    @State private var showLoginView = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Título
            VStack(alignment: .leading, spacing: 8) {
                Text("Redefinir Senha")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Preencha os campos abaixo para redefinir sua senha")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            // Campos do formulário
            VStack(spacing: 16) {
                // Nome de Usuário
                VStack(alignment: .leading, spacing: 4) {
                    Text("Email")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    TextField("Digite seu email", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                }
                
                // Senha Atual
                VStack(alignment: .leading, spacing: 4) {
                    Text("Senha Atual")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    HStack {
                        if showCurrentPassword {
                            TextField("Digite sua senha atual", text: $currentPassword)
                        } else {
                            SecureField("Digite sua senha atual", text: $currentPassword)
                        }
                        
                        Button(action: {
                            showCurrentPassword.toggle()
                        }) {
                            Image(systemName: showCurrentPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                
                // Nova Senha
                VStack(alignment: .leading, spacing: 4) {
                    Text("Nova Senha")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    HStack {
                        if showNewPassword {
                            TextField("Digite sua nova senha", text: $newPassword)
                        } else {
                            SecureField("Digite sua nova senha", text: $newPassword)
                        }
                        
                        Button(action: {
                            showNewPassword.toggle()
                        }) {
                            Image(systemName: showNewPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
            }
            
            // Checkbox para salvar nova senha
            HStack {
                Toggle(isOn: $saveNewPassword) {
                    Text("Salvar minha nova senha")
                        .font(.footnote)
                }
                .toggleStyle(CheckboxToggleStyle())
            }
            
            Spacer()
            
            // Botão de Redefinir Senha
            Button(action: {
                validateAndResetPassword()
            }) {
                Text("Redefinir Senha")
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
    
    // Função para validar e redefinir a senha
    private func validateAndResetPassword() {
        // Verificar se todos os campos estão preenchidos
        guard !username.isEmpty, !currentPassword.isEmpty, !newPassword.isEmpty else {
            errorMessage = "Todos os campos são obrigatórios."
            showAlert = true
            return
        }
        
        // Carregar os dados do Keychain usando o EMAIL como chave
        if let userData = KeychainHelper.load(key: username), // Altere aqui para usar o email
           var decodedUserData = try? JSONDecoder().decode([String: String].self, from: userData) {
            let storedPassword = decodedUserData["password"] ?? ""
            
            // Validar a senha atual
            guard currentPassword == storedPassword else {
                errorMessage = "Erro: A senha atual está incorreta."
                showAlert = true
                return
            }
            
            // Verificar se a nova senha é diferente da senha atual
            guard currentPassword != newPassword else {
                errorMessage = "Erro: A nova senha deve ser diferente da senha atual."
                showAlert = true
                return
            }
            
            // Atualizar a senha no Keychain
            decodedUserData["password"] = newPassword
            if let updatedUserData = try? JSONEncoder().encode(decodedUserData) {
                let success = KeychainHelper.save(key: username, data: updatedUserData) // Altere aqui para usar o email
                if success {
                    print("Senha redefinida com sucesso!")
                    
                    // Salvar a nova senha no AppStorage se a checkbox estiver marcada
                    if saveNewPassword {
                        UserDefaults.standard.set(newPassword, forKey: "savedPassword")
                        UserDefaults.standard.set(username, forKey: "savedEmail") // Altere aqui para usar o email
                    } else {
                        // Limpar os dados salvos se a checkbox estiver desmarcada
                        UserDefaults.standard.removeObject(forKey: "savedPassword")
                        UserDefaults.standard.removeObject(forKey: "savedEmail")
                    }
                    
                    // Limpar os campos após a redefinição
                    username = ""
                    currentPassword = ""
                    newPassword = ""
                    
                    // Redirecionar para a tela de login
                    showLoginView = true
                } else {
                    errorMessage = "Erro ao salvar a nova senha no Keychain."
                    showAlert = true
                }
            }
        } else {
            errorMessage = "Erro: Nome de usuário não encontrado no Keychain."
            showAlert = true
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
