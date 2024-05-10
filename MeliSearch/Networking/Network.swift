import Foundation

enum NetworkError: Error {
    case invalidURL,
         invalidResponse,
         noData,
         decodingError(description: String)
}

protocol NetworkProtocol {
    func execute<T: Decodable>(with request: Request, completion: @escaping (Result<T, Error>) -> Void)
}

final class Network: NetworkProtocol {
    func execute<T: Decodable>(with request: Request, completion: @escaping (Result<T, Error>) -> Void) {
        var components = URLComponents(string: API.baseURL + request.endpoint)
        
        components?.queryItems = request.parameters.map {
            URLQueryItem(name: $0.name, value: $0.value)
        }
        
        guard let url = components?.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                return completion(.failure(NetworkError.noData))
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(NetworkError.decodingError(description: error.localizedDescription)))
            }
        }
        dataTask.resume()
    }
}
