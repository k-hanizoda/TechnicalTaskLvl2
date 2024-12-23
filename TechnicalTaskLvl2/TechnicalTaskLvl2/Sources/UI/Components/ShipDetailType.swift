enum ShipDetailType {
    case name
    case type
    case year
    case weight
    case homePort
    case roles
    
    var labelText: String {
        switch self {
        case .name: Localizable.shipNameTitle
        case .type: Localizable.shipTypeTitle
        case .year: Localizable.builtYearTitle
        case .weight: Localizable.shipWeightTitle
        case .homePort: Localizable.homePortTitle
        case .roles: Localizable.rolesTitle
        }
    }
}
