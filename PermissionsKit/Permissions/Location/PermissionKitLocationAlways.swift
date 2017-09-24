import CoreLocation

public final class PermissionKitLocationAlways: PermissionKitLocationBase {

    override public init() {

        let identifier = "PermissionKitLocationAlways"
        super.init(identifier: identifier)

        self.identifier = identifier
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)

        self.identifier = "PermissionKitLocationAlways"
    }

    override public func askForPermission(completion: @escaping PermissionKitResponse) {

        self.completion = completion
        self.requestAlwaysAuthorization()
    }
}
