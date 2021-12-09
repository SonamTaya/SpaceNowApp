//
//  AstronautsViewModel.swift
//  SpaceNowApp
//
//  Created by sonam taya on 7/12/21.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func fetchDidSucceed()
    func fetchDidFail(with title: String, description: String)
}

final class AstronautsViewModel {
    private weak var delegate: ViewModelDelegate?
    
    init(delegate: ViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Variables and Properties
    
    var apiClient = APIClient()
    var astronautData: [Astronaut]? = []
    var astronautDetail: AstronautDetail?
    
    // MARK: - Fetch Data
    
    func fetchAstronauts(with url: URL) {
        apiClient.fetch(with: url, page: nil, dataType: Astronauts.self) { result in
            switch result {
            case .failure(let error):
                // Perform on main thread to update UI
                DispatchQueue.main.async {
                    self.delegate?.fetchDidFail(with: error.reason, description: error.localizedDescription)
                }
            case .success(let response):
                // Perform on main thread to update UI
                print(response)
                DispatchQueue.main.async {
                    self.astronautData = response.results
                    self.delegate?.fetchDidSucceed()
                }
            }
        }
    }
    
    func fetchAstronautDetail(with url: URL) {
        apiClient.fetch(with: url, page: nil, dataType: AstronautDetail.self) { result in
            switch result {
            case .failure(let error):
                // Perform on main thread to update UI
                DispatchQueue.main.async {
                    self.delegate?.fetchDidFail(with: error.reason, description: error.localizedDescription)
                }
            case .success(let response):
                // Perform on main thread to update UI
                print(response)
                DispatchQueue.main.async {
                    self.astronautDetail = response
                    self.delegate?.fetchDidSucceed()
                }
            }
        }
    }
    
}
