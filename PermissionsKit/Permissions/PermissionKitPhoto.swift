import Photos

public final class PermissionKitPhoto: PermissionKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionKitPhoto: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitPhoto"
    }

    public func status(completion: @escaping PermissionKitResponse) {

        switch PHPhotoLibrary.authorizationStatus() {
            case .notDetermined: return completion(.notDetermined)
            case .restricted, .denied: return completion(.denied)
            case .authorized: return completion(.authorized)
        }
    }

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        PHPhotoLibrary.requestAuthorization { (status) in

            switch status {
                case .notDetermined:
                    print("[PermissionKit.Photos] 🌅 permission not determined 🤔")
                    return completion(.notDetermined)

                case .restricted, .denied:
                    print("[PermissionKit.Photos] 🌅 permission denied by user ⛔️")
                    return completion(.denied)

                case .authorized:
                    print("[PermissionKit.Photos] 🌅 permission authorized by user ✅")
                    return completion(.authorized)
            }
        }
    }

}
