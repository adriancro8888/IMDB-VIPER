//
//  MockRouter.swift
//  ViperFinalWorkTests
//
//  Created by emre usul on 4.05.2022.
//

import Foundation
@testable import ViperFinalWork

final class MockRouter: HomeRouterProtocol {
    var isInvokedNavigate = false
    
    func navigate(_ route: HomeRoutes) {
        isInvokedNavigate = true
    }
    
}





