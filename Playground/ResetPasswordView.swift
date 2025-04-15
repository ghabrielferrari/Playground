import SwiftUI

struct ResetPasswordView: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var showCurrentPassword: Bool = false
    @State private var showNewPassword: Bool = false
    @State private var saveNewPassword: Bool = true
    
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
                resetPassword()
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
    }
    
    private func resetPassword() {
        print("Tentativa de redefinição de senha:")
        print("Senha atual: \(currentPassword)")
        print("Nova senha: \(newPassword)")
        print("Salvar nova senha: \(saveNewPassword ? "Sim" : "Não")")
        
        // Validações adicionais podem ser incluídas aqui
        if currentPassword == newPassword {
            print("Erro: A nova senha deve ser diferente da senha atual")
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
