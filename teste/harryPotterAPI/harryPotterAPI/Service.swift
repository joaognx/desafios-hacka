//
//  Service.swift
//  harryPotterAPI
//
//  Created by Turma02-18 on 03/06/26.
//

import Foundation
import Combine

struct Service {
    func fetchHaPo(url: URL) -> AnyPublisher<[HaPo], Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [HaPo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
