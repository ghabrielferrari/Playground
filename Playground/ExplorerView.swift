import SwiftUI

struct ExploreView: View {
    // Mock data for books and reviews
    let recommendedBooks = [
        Book(title: "O Outro Lado do Ponto da Virada", author: "Malcolm Gladwell"),
        Book(title: "Entre Fogo e Espinhos", author: "Elizabeth Heiten"),
        Book(title: "Uma Vida para a Ciência", author: "Stephen Jay Gould"),
        Book(title: "Sapiens", author: "Yuval Noah Harari")
    ]
    
    let highlightedBooks = [
        Book(title: "O Alquimista", author: "Paulo Coelho"),
        Book(title: "Phantasm", author: "Kylie Smith"),
        Book(title: "O Nome da Rosa", author: "Umberto Eco"),
        Book(title: "O Código Da Vinci", author: "Dan Brown")
    ]
    
    let popularReviews = [
        Review(username: "@maria_dorineves", text: "Esse final acabou comigo 😭 Alguém mais aí precisando de terapia depois dessa leitura?"),
        Review(username: "@peter.alvarez", text: "Um manual essencial para qualquer pessoa interessada em ciência.")
    ]
    
    let factBasedBooks = [
        Book(title: "Lance Livre", author: "Eduardo Guardia"),
        Book(title: "Estado, Economia e Reformas Estruturais no Brasil", author: "Jamie Hamrow"),
        Book(title: "9 Kind of Magic", author: "Mark Haddon"),
        Book(title: "O Elmo do Pensador", author: "Edward de Bono")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Barra de Pesquisa
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(8)
                        
                        TextField("Pesquisar", text: .constant(""))
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        Button(action: {}) {
                            Image(systemName: "mic.fill")
                                .foregroundColor(.gray)
                                .padding(8)
                        }
                    }
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // Seção "Para você"
                    Text("Para você")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(recommendedBooks, id: \.title) { book in
                                BookCard(book: book)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Seção "Destaques da galera"
                    Text("Destaques da galera")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(highlightedBooks, id: \.title) { book in
                                BookCard(book: book)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Seção "Resenhas mais relevantes"
                    Text("Resenhas mais relevantes")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(popularReviews, id: \.username) { review in
                            ReviewCard(review: review)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Seção "Baseados em fatos"
                    Text("Baseados em fatos")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(factBasedBooks, id: \.title) { book in
                                BookCard(book: book)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 24)
            }
            .navigationTitle("Explorar")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "bell")
            }
        }
        .tabItem {
            Label("Explorar", systemImage: "magnifyingglass")
        }
    }
}

// Struct para representar um livro
struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
}

// Visualização do cartão de livro
struct BookCard: View {
    let book: Book
    
    var body: some View {
        VStack {
            Image(book.title) // Substituir pela imagem real do livro
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 180)
                .cornerRadius(10)
            
            Text(book.title)
                .font(.headline)
                .lineLimit(2)
                .padding(.top, 8)
            
            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

// Struct para representar uma resenha
struct Review: Identifiable {
    let id = UUID()
    let username: String
    let text: String
}

// Visualização do cartão de resenha
struct ReviewCard: View {
    let review: Review
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(Color.gray)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(review.username)
                    .font(.headline)
                
                Text(review.text)
                    .font(.body)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .frame(height: 120)
         .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemPink).opacity(0.2))
        .cornerRadius(10)
    }
}

// Preview
struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
