//
//  Model.swift
//  apiMusica
//
//  Created by Turma02-18 on 16/06/26.
//

struct Music: Codable, Hashable {
    let name: String?
    let duracao: String?
    let artista: String?
    let album: String?
}
