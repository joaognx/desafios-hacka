import Foundation
import Combine

class ViewModel: ObservableObject {
    
    @Published var musicas: [Music] = []
    
    private let service = Service()
    private var cancellables = Set<AnyCancellable>()
    
    func fetch() {
        guard let urlget = URL(string: "http://127.0.0.1:1880/getufpi") else {
            return
        }
        
        service.fetchMusic(url: urlget)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .finished:
                    print("GET finalizado")
                    
                case .failure(let error):
                    print("Erro no GET:", error.localizedDescription)
                }
                
            }, receiveValue: { musicasRecebidas in
                self.musicas = musicasRecebidas
            })
            .store(in: &cancellables)
    }
    
    
    func post(musica: Music) {
        guard let urlpost = URL(string: "http://127.0.0.1:1880/postufpi") else {
            return
        }
        
        service.postMusic(url: urlpost, music: musica) { sucesso in
            DispatchQueue.main.async {
                if sucesso {
                    print("Música enviada como JSON único")
                    self.fetch()
                } else {
                    print("Erro ao enviar música")
                }
            }
        }
    }
}
