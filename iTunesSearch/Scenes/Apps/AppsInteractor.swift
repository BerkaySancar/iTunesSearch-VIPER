//
//  AppsInteractor.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol AppsInteractorProtocol: AnyObject {
    
    var delegate: AppsInteractorOutputs? { get set }
    
}

final class AppsInteractor: AppsInteractorProtocol {
    
    weak var delegate: AppsInteractorOutputs?
}
