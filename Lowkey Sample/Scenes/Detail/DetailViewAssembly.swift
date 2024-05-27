//
//  DetailViewAssembly.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import Swinject

final class DetailViewAssembly: Assembly {
    func assemble(container: Container) {
        configure(using: container)
    }

    func configure(using container: Container) {
        container.register(DetailViewModel.self) { resolver in
            return DetailViewModel()
        }
    }
}
