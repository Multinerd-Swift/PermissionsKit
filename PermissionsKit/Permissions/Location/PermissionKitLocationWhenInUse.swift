import CoreLocation

public final class PermissionKitLocationWhenInUse: PermissionKitLocationBase {

    override public init() {

        let identifier = "PermissionKitLocationWhenInUse"
        super.init(identifier: identifier)

        self.identifier = identifier
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)

        self.identifier = "PermissionKitLocationWhenInUse"
    }

    override public func askForPermission(completion: @escaping PermissionKitResponse) {

        self.completion = completion
        self.requestWhenInUseAuthorization()
    }
}
