//
//  ImageRow.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import SwiftUI
import Kingfisher

struct ImageRow: View {
    let image: ImageModel
    @State private var isAnimating = true

    var body: some View {
        let tileWidth = UIScreen.main.bounds.width - 20.0

        ZStack {
            KFImage(image.src.largeImageURL)
                .placeholder {
                    Image(systemName: "arrow.2.circlepath.circle")
                        .font(.largeTitle)
                        .opacity(0.3)
                }
                .lowDataModeSource(.network(image.src.mediumImageUrl!))
                .retry(maxCount: 3, interval: .seconds(5))
                .fade(duration: 0.35)
                .onSuccess { _ in
                    isAnimating = false
                }
                .resizable()
                .cancelOnDisappear(true)
                .scaledToFill()
                .overlay(alignment: .center) {
                    ProgressView().isHidden(!isAnimating)
                }

            buildAuthorTitleView(with: image.author)
        }
        .frame(width: tileWidth, height: 250.0)
        .padding(.vertical, 5)
        .background(Color.black)
        .cornerRadius(10.0)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 0)
    }

    @ViewBuilder private func buildAuthorTitleView(with name: String) -> some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    Text(name)
                        .font(.system(size: 15.0))
                        .foregroundColor(Color.white)
                        .padding(.all, 5.0)
                }
                .background(Color.black)
                .cornerRadius(10.0)
                .opacity(0.75)
                .padding(.horizontal, 10.0)
            }
            Spacer()
        } .frame( height: 250.0)
    }
}

#if DEBUG
struct ImageRow_Previews: PreviewProvider {
    static var previews: some View {
        ImageRow(image: ImageModel(
            id: 1,
            src: PhotoSource(originalImageUrl: URL(string:"https://example.com/image1.jpg")),
            author: "John Doe"
        ))
        .preferredColorScheme(.dark)
    }
}
#endif

