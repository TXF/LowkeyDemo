//
//  DetailView.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    private var viewModel: DetailViewModel

    // MARK: Initializer:
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            KFImage(viewModel.imageModel?.src.originalImageUrl)
                .placeholder {
                        Image(systemName: "arrow.2.circlepath.circle")
                            .font(.largeTitle)
                            .opacity(0.3)
                    }
                .lowDataModeSource(.network(viewModel.imageModel!.src.mediumImageUrl!))
                .cacheOriginalImage()
                .fade(duration: 0.35)
                .resizable()
                .scaledToFit()
                .cornerRadius(10.0)
                .shadow(color: Color.black.opacity(0.5), radius: 2)
                .padding(.all, 15.0)
        }
        .navigationBarTitle("Image Detail")
    }
}
