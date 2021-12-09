//
//  APIClient.swift
//  SpaceNowApp
//
//  Created by sonam taya on 7/12/21.
//

import UIKit

var baseUrlString = "https://spacelaunchnow.me/api/3.5.0/"


final class APIClient {
    
    var baseUrl: URL = {
        return URL(string: baseUrlString)!
    }()

    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Network Call
    
    func fetch<T: Decodable>(with url: URL?, page: Int?, dataType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request: URL = baseUrl
        
        // If URL exists use it
        if let url = url { request = url }
      
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.request))
                }
                return
            }
           
            // Check if http response is successful and data is safe
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let safeData = data
                else {
                    DispatchQueue.main.async {
                        completion(.failure(.unknown))
                    }
                    return
            }
            switch statusCode {
            case 200...299:
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970

                    let decodedData = try decoder.decode(dataType, from: safeData)
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decoding))
                    }
                }
            default :
                DispatchQueue.main.async {
                    completion(.failure(.network))
                }
                return
            }
        }
        dataTask.resume()
    }
}
