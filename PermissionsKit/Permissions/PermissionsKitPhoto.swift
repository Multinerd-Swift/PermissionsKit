import Photos

public final class PermissionsKitPhoto: PermissionsKitBase {

    public var identifier: String = "PermissionsKitPhoto"
    
    public init() {

        super.init(identifier: "PermissionsKitPhoto")
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionsKitPhoto: PermissionsKitProtocol {

    public func status(completion: @escaping PermissionsKitResponse) {

        switch PHPhotoLibrary.authorizationStatus() {
            case .notDetermined: return completion(.notDetermined)
            case .restricted, .denied: return completion(.denied)
            case .authorized: return completion(.authorized)
        }
    }

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        PHPhotoLibrary.requestAuthorization { (status) in

            switch status {
                case .notDetermined:
                    print("[PermissionsKit.Photos] 🌅 permission not determined 🤔")
                    return completion(.notDetermined)

                case .restricted, .denied:
                    print("[PermissionsKit.Photos] 🌅 permission denied by user ⛔️")
                    return completion(.denied)

                case .authorized:
                    print("[PermissionsKit.Photos] 🌅 permission authorized by user ✅")
                    return completion(.authorized)
            }
        }
    }

}
