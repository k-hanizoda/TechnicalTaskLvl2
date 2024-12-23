extension Optional where Wrapped == Int {
    func toString(defaultValue: String = Localizable.notAssigned) -> String {
        guard let value = self else { return defaultValue }
        return String(value)
    }
}
