import CoreLocation

public final class PermissionsKitLocationWhenInUse: PermissionsKitLocationBase {

    override public init() {

        let identifier = "PermissionsKitLocationWhenInUse"
        super.init(identifier: identifier)

        self.identifier = identifier
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)

        self.identifier = "PermissionsKitLocationWhenInUse"
    }

    override public func askForPermission(completion: @escaping PermissionsKitResponse) {

        self.completion = completion
        self.requestWhenInUseAuthorization()
    }
}
