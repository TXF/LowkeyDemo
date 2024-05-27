//
//  DIAssembler.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import Swinject

final class DIAssembler {
    lazy var assembler: Assembler = {
        var assemblies = UI().assemblies + Services().assemblies
        return Assembler(assemblies)
    }()

    var resolver: Resolver {
        assembler.resolver
    }
    
    private struct UI {
        var assemblies: [Assembly] = [FeedAssembly(), DetailViewAssembly()]
    }

    private struct Services {
        var assemblies: [Assembly] = [NetworkServiceAssembly()]
    }
}

internal enum DIManager {
    private static var assembler = DIAssembler()

    static var resolver: Resolver {
        assembler.resolver
    }
}
