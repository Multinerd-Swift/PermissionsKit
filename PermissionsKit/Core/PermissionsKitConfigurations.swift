public struct PermissionsKitConfigurations {

    /// How frequently should we prompt the user to re-enable permission.
    var frequency: PermissionsKitFrequency = .onceADay

    /// Determines whether we should show an alert to prevent burning the only ios request. Defaults to true.
    var presentInitialPopup: Bool = true

    /// Determines whether we should show an alert to re-enable a permission.
    var presentReEnablePopup: Bool = true

    private let week = 60.0 * 60.0 * 24.0 * 7.0
    private let hour = 60.0 * 60.0

    public init(frequency: PermissionsKitFrequency, presentInitialPopup: Bool, presentReEnablePopup: Bool) {

        self.frequency = frequency
        self.presentInitialPopup = presentInitialPopup
        self.presentReEnablePopup = presentReEnablePopup
    }

    func reEnablePopupPresented(permission: PermissionsKitProtocol) {

        UserDefaults.standard.set(Date(), forKey: permission.identifier)
        UserDefaults.standard.synchronize()
    }

    func canPresentReEnablePopup(permission: PermissionsKitProtocol) -> Bool {

        if !self.presentReEnablePopup {
            return false
        }

        switch self.frequency {
            case .onceADay:
                guard let lastDate = self.lastDateForPermission(identifier: permission.identifier) else {
                    return false
                }
                return !Calendar.current.isDateInToday(lastDate)

            case .everyHour:
                guard let lastDate = self.lastDateForPermission(identifier: permission.identifier) else {
                    return false
                }
                return Calendar.current.compare(lastDate, to: Date(), toGranularity: .hour) == ComparisonResult.orderedDescending

            case .justOnce:
                return self.lastDateForPermission(identifier: permission.identifier) == nil

            case .onceAWeek:
                guard let lastDate = self.lastDateForPermission(identifier: permission.identifier) else {
                    return false
                }
                let ti = TimeInterval(week)
                let lastDateInAWeek = lastDate.addingTimeInterval(ti)
                return Calendar.current.compare(lastDateInAWeek, to: Date(), toGranularity: .day) == ComparisonResult.orderedDescending

            case .always:
                return true
        }
    }

    private func lastDateForPermission(identifier: String) -> Date? {

        return UserDefaults.standard.object(forKey: identifier) as? Date
    }
}
