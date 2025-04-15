import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var saveLoginDetails: Bool = true
    
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
                // Lógica de registro
                registerUser()
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
    }
    
    private func registerUser() {
        // Lógica de registro
        print("Registrando usuário:")
        print("Username: \(username)")
        print("Email: \(email)")
        print("Password: \(password)")
        print("Confirm Password: \(confirmPassword)")
        print("Save Login Details: \(saveLoginDetails)")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
