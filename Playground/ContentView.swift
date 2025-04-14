//
//  ContentView.swift
//  Playground
//
//  Created by Aluno 17 on 10/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = "" // declara a variavel para o email
    @State private var password: String = "" // declara a variavel para a senha
    @State private var rememberMe: Bool = false // declara a variavel para o lembrar a senha
    
    var body: some View { // corpo do codigo
        ScrollView { // tela main
            VStack(alignment: .leading, spacing: 24) { // alinha o titulo na parte superior (cabecalho)
                // Cabeçalho
                VStack(alignment: .leading, spacing: 8) { // alinha o titulo com o outro vstack
                    Text("Entrar") // titulo
                        .font(.largeTitle) // muda o tamanho da fonte
                        .fontWeight(.bold) // muda a font para bold
                    
                    Text("Preencha os campos para acessar sua conta") // text
                        .font(.subheadline) // muda o tamanho da fonte
                        .foregroundColor(.gray) // muda a cor do text
                }
                .padding(.top, 32) // alinha a fonte com padding
                
                Spacer() // da um espaço
                
                // campos de input
                VStack(alignment: .leading, spacing: 16) { // alinha o email
                    Text("Email") // subtitulo email
                        .font(.footnote) // muda a fonte
                        .foregroundColor(.gray) // muda a cor da fonte
                    
                    TextField("Digite seu email", text: $email) // email
                        .textFieldStyle(.roundedBorder) // coloca borda no textfield
                        .textInputAutocapitalization(.never) // coloca um capitalizer para o input
                    
                    Text("Senha") // titulo senha
                        .font(.footnote) // muda a fonte
                        .foregroundColor(.gray) // muda a cor da fonte
                    
                    SecureField("Digite sua senha", text: $password) // senha
                        .textFieldStyle(.roundedBorder) // coloca borda no textfield
                }
                
                // Lembrar senha + Esqueci senha
                HStack { // lembra a senha
                    Toggle(isOn: $rememberMe) { // habilita o toggle para a checkbox na variavel criada anteriormente
                        Text("Lembrar-me") // titulo lembrarsenha
                            .font(.footnote) // muda a fonte
                    }
                    .toggleStyle(CheckboxToggleStyle()) // funcao toggle checkbox
                    
                    Spacer() // da um espaco
                    
                    Button("Esqueceu a senha?") { // titulo esqueci senha
                        // Lógica para recuperar senha
                    }
                    .font(.footnote) // muda a fonte
                    .foregroundColor(.blue) // muda a cor da fonte
                }
                    
                Spacer(minLength: 120) // da um espaco
                    // Divisor
                    HStack { // hstack de divisoria
                        VStack { Divider() } // linha divisoria
                        Text("Conectar com") // texto divisoria
                            .font(.footnote) // muda a fonte
                            .foregroundColor(.gray) // muda a cor da fonte
                            .padding(.horizontal, 8) // da um espacamento
                        VStack { Divider() } // linha divisoria
                    }
                
                    
                    // botao logo apple
                    HStack(spacing: 16) { // da um espaco
                        Button(action: {}) { // faz o botao funcionar
                            HStack { // hstack do logo da apple
                                Image(systemName: "applelogo") // logo apple
                                Text("Apple") // text apple
                            }
                            .frame(maxWidth: .infinity) // direciona a largura como x
                            .padding() // da um espacamento
                            .background(Color.white) // muda a cor do botao
                            .foregroundColor(.black) // muda a cor do texto do botao
                            .cornerRadius(10) // muda a borda
                            .overlay( // da a cor pra borda
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
                            // Navegação para cadastro
                        }
                        .font(.footnote)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
                }
                .padding(.horizontal, 24)
                
                // Botão de login
                Button(action: {
                    // Lógica de login
                }) {
                    Text("Entrar")
                        .frame( maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 24)
                .padding(.horizontal, 24)
        }
    }
}

// Estilo personalizado para checkbox
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
