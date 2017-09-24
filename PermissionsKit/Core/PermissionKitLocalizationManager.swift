struct PermissionKitLocalizationManager {

    var initialTitle: String = ""
    var initialMessage: String = ""
    var initialAllowButtonTitle: String = ""
    var initialDenyButtonTitle: String = ""

    var reEnableTitle: String = ""
    var reEnableMessage: String = ""
    var reEnableAllowButtonTitle: String = ""
    var reEnableDenyButtonTitle: String = ""

    init(permission: String) {

        self.initialTitle = "Requesting \(permission) permissions"
        self.initialMessage = "\(permission) is required to use this feature."
        self.initialAllowButtonTitle = "Allow"
        self.initialDenyButtonTitle = "Deny"

        self.reEnableTitle = "\(permission) permissions has been disabled."
        self.reEnableMessage = "\(permission) is required to use this feature."
        self.reEnableAllowButtonTitle = "Enable"
        self.reEnableDenyButtonTitle = "Cancel"

    }
}
