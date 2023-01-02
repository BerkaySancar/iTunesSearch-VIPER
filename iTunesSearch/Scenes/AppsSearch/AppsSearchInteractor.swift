//
//  AppsSearchInteractor.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol AppsSearchInteractorProtocol: AnyObject {
    
    var delegate: AppsSearchInteractorOutputs? { get set }
}

final class AppsSearchInteractor: AppsSearchInteractorProtocol {
    
    weak var delegate: AppsSearchInteractorOutputs?
}
