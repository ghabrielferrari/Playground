import SwiftUI
import AuthenticationServices

struct LoginView: View {
    // MARK: - Variáveis
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var showPassword: Bool = false
    @State private var showResetPassword = false
    @State private var showRegisterView = false
    
    // Estado de login persistente
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    // Armazenamento persistente para "Lembrar-me"
    @AppStorage("savedEmail") private var savedEmail: String = ""
    @AppStorage("savedPassword") private var savedPassword: String = ""
    
    // Estado para controlar o alerta de erro
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Cabeçalho
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Entrar")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Preencha os campos para acessar sua conta")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, -30)
                    
                    Spacer(minLength: 60)
                    
                    // Campos de Entrada
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Email")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                        TextField("Digite seu email", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Senha")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                            ZStack(alignment: .trailing) {
                                if showPassword {
                                    TextField("Digite sua senha", text: $password)
                                } else {
                                    SecureField("Digite sua senha", text: $password)
                                }
                                
                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                        }
                    }
                    
                    // Opções de Login
                    HStack {
                        Toggle(isOn: $rememberMe) {
                            Text("Lembrar-me")
                                .font(.footnote)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        
                        Spacer()
                        
                        Button("Esqueceu a senha?") {
                            showResetPassword = true
                        }
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .background(
                            NavigationLink(
                                destination: ResetPasswordView(),
                                isActive: $showResetPassword,
                                label: { EmptyView() }
                            )
                        )
                    }
                    
                    Spacer(minLength: 120)
                    
                    // Divisor
                    HStack {
                        VStack { Divider() }
                        Text("Conectar com")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 8)
                        VStack { Divider() }
                    }
                    
                    // Login com Apple
                    HStack(spacing: 16) {
                        SignInWithApple()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    
                    // Rodapé
                    HStack {
                        Text("Não tem uma conta?")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                        Button("Criar uma nova conta") {
                            showRegisterView = true
                        }
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .background(
                            NavigationLink(
                                destination: RegisterView(),
                                isActive: $showRegisterView,
                                label: { EmptyView() }
                            )
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
                    
                    // Botão de Login
                    Button(action: {
                        validateAndLogin()
                    }) {
                        Text("Entrar")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert(errorMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .onAppear {
                // Carregar os dados salvos se a opção "Lembrar-me" estiver ativada
                if !savedEmail.isEmpty, !savedPassword.isEmpty {
                    email = savedEmail
                    password = savedPassword
                    rememberMe = true
                }
            }
        }
    }
    
    // Método para validar e autenticar o usuário
    private func validateAndLogin() {
        // Verificar se os campos estão vazios
        guard !email.isEmpty, !password.isEmpty else {
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

        // Carregar dados do Keychain
        if let userData = KeychainHelper.load(key: email),
           let decodedUserData = try? JSONDecoder().decode([String: String].self, from: userData) {
            let storedPassword = decodedUserData["password"] ?? ""

            // Verificar se a senha corresponde
            if password == storedPassword {
                print("Login bem-sucedido!")

                // Salvar os dados se "Lembrar-me" estiver ativado
                if rememberMe {
                    savedEmail = email
                    savedPassword = password
                } else {
                    // Limpar os dados salvos se "Lembrar-me" estiver desativado
                    savedEmail = ""
                    savedPassword = ""
                }

                // Atualiza o estado de login
                isLoggedIn = true

                // Forçar a atualização da interface (opcional)
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                }
            } else {
                errorMessage = "Senha incorreta."
                showAlert = true
            }
        } else {
            errorMessage = "Email não encontrado."
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

// Estilo personalizado para o toggle (checkbox)
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
