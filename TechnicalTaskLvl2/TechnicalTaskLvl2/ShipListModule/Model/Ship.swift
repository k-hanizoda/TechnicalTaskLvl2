import Foundation

struct Ship: Decodable {
    let image: URL?
    let name: String
    let type: String
    let builtYear: Int?
    let weight: Int?
    let homePort: String?
    let roles: [String]?
    
    enum CodingKeys: String, CodingKey {
        case image
        case name
        case type
        case builtYear = "year_built"
        case weight = "mass_kg"
        case homePort = "home_port"
        case roles
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        image = try container.decodeIfPresent(URL.self, forKey: .image)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        builtYear = try container.decodeIfPresent(Int.self, forKey: .builtYear)
        weight = try container.decodeIfPresent(Int.self, forKey: .weight)
        homePort = try container.decodeIfPresent(String.self, forKey: .homePort)
        roles = try container.decodeIfPresent([String].self, forKey: .roles)
    }
}
