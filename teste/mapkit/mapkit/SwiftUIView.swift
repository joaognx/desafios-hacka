import SwiftUI

struct SwiftUIView: View {
    let local: Location
    
    var body: some View {
        VStack(spacing: 20) {
            
            AsyncImage(url: URL(string: local.foto)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(width: 220, height: 150)
            .clipped()
            .border(Color.black)
            
            Text(local.nome)
                .font(.title)
                .bold()
            
            Text(local.descricao)
                .font(.body)
                .padding()
                .background(Color.brown.opacity(0.4))
                .cornerRadius(8)
            
            Spacer()
        }
        .padding()
        .background(Color.yellow.opacity(0.3))
    }
}
