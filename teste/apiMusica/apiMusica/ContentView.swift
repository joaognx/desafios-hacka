import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    @State private var nome = ""
    @State private var artista = ""
    @State private var album = ""
    @State private var duracao = ""
    
    @State private var musicaSelecionada: Music?
    @State private var mostrarSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.red
                    .ignoresSafeArea()
                
                VStack(spacing: 10) {
                    
                    Image("grifii")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 140)
                    
                    TextField("Nome", text: $nome)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    TextField("Artista", text: $artista)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    TextField("Álbum", text: $album)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    TextField("Duração", text: $duracao)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    Button("Cadastrar Música") {
                        let novaMusica = Music(
                            name: nome,
                            duracao: duracao,
                            artista: artista,
                            album: album
                        )
                        
                        viewModel.post(musica: novaMusica)
                        
                        nome = ""
                        artista = ""
                        album = ""
                        duracao = ""
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Text("Músicas cadastradas")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 8)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(
                                viewModel.musicas.filter {
                                    !($0.name?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
                                },
                                id: \.self
                            ) { musica in
                                Button {
                                    musicaSelecionada = musica
                                    mostrarSheet = true
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(musica.name ?? "")
                                                .font(.headline)
                                                .foregroundColor(.black)
                                            
                                            Text(musica.artista ?? "")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "music.note")
                                            .foregroundColor(.red)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetch()
            }
            .sheet(isPresented: $mostrarSheet) {
                if let musica = musicaSelecionada {
                    MusicaSheetView(musica: musica)
                }
            }
        }
    }
}

struct MusicaSheetView: View {
    
    let musica: Music
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image(systemName: "music.note.list")
                .font(.system(size: 70))
                .foregroundColor(.red)
            
            Text(musica.name ?? "Sem música cadastrada")
                .font(.largeTitle)
                .bold()
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Artista: \(musica.artista ?? "Não informado")")
                Text("Álbum: \(musica.album ?? "Não informado")")
                Text("Duração: \(musica.duracao ?? "Não informado")")
            }
            .font(.title3)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
