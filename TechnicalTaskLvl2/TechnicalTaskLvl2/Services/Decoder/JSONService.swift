import Foundation

final class JSONService {
    private var jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()){
        self.jsonDecoder = jsonDecoder
    }
    
    func decode<T: Decodable>(data: Data) throws -> T {
        try jsonDecoder.decode(T.self, from: data)
    }
}
