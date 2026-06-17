import Foundation
import Combine

struct Service {
    
    func fetchMusic(url: URL) -> AnyPublisher<[Music], Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Music].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func postMusic(
        url: URL,
        music: Music,
        completion: @escaping (Bool) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(music)
        } catch {
            print("Erro ao converter: ", error.localizedDescription)
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Erro no POST:", error.localizedDescription)
                completion(false)
                return
            }
            
            completion(true)
            
        }.resume()
    }
}
