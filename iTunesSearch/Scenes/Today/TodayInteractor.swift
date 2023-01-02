//
//  TodayInteractor.swift
//  iTunesSearch
//
//  Created by Berkay Sancar on 2.01.2023.
//

import Foundation

protocol TodayInteractorProtocol: AnyObject {
    var delegate: TodayInteractorOutputs? { get set }
}

final class TodayInteractor: TodayInteractorProtocol {
    
    weak var delegate: TodayInteractorOutputs?
}
