enum ShipDetailType {
    case name
    case type
    case year
    case weight
    case homePort
    case roles
    
    var labelText: String {
        switch self {
        case .name: "Ship name:"
        case .type: "Ship type:"
        case .year: "Built year:"
        case .weight: "Weight:"
        case .homePort: "Home port:"
        case .roles: "Roles:"
        }
    }
}
