import SwiftUI

struct LoginView: View {
    // MARK: - Variáveis
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var showPassword: Bool = false
    @State private var showResetPassword = false
    @State private var showRegisterView = false
    
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
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "applelogo")
                                Text("Apple")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        }
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
                        // Lógica de login
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
        }
    }
}

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
