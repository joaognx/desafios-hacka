import SwiftUI

struct CharacterView: View {
    let character: HaPo

    var body: some View {
        ZStack{
            Image("grifi")
                .resizable()
                .blur(radius:10)
                .ignoresSafeArea()

                VStack(spacing: 16) {
                    AsyncImage(url: URL(string: character.image!)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 220, height: 220)
                    .clipShape(Circle())
                    
                    VStack(alignment: .center, spacing: 10) {
                        InfoRow(title: "House", value: character.house!)
                        InfoRow(title: "Name", value: character.name!)
                        InfoRow(title: "Birth", value: character.dateOfBirth!)
                        InfoRow(title: "Eyes", value: character.eyeColour!)
                        }
                    .frame(maxWidth: 200, alignment: .leading)
                    .background(Color.wine)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Spacer()
            Text("\(title):")
                .bold()
                .foregroundColor(.white)
            Text(value)
                .foregroundColor(.white)
            Spacer()
        }
        
    }
}

