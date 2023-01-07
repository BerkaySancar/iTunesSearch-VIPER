//
//  MusicInteractor.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 6.01.2023.
//

import Foundation

protocol MusicInteractorProtocol: AnyObject {
    var delegate: MusicInteractorOutputs? { get set }
}

final class MusicInteractor: MusicInteractorProtocol {
    
    weak var delegate: MusicInteractorOutputs?
}

