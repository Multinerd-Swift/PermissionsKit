import MediaPlayer

public final class PermissionKitMediaLibrary: PermissionKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionKitMediaLibrary: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitMediaLibrary"
    }

    public func status(completion: @escaping PermissionKitResponse) {

        if #available(iOS 9.3, *) {
            let status = MPMediaLibrary.authorizationStatus()
            switch status {
                case .authorized: return completion(.authorized)
                case .restricted, .denied: return completion(.denied)
                case .notDetermined: return completion(.notDetermined)
            }
        }

        return completion(.notAvailable)
    }

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        if #available(iOS 9.3, *) {
            MPMediaLibrary.requestAuthorization { status in
                switch status {
                    case .authorized:
                        print("[PermissionKit.MediaLibrary] 💽 permission authorized by user ✅")
                        return completion(.authorized)

                    case .restricted, .denied:
                        print("[PermissionKit.MediaLibrary] 💽 permission denied by user ⛔️")
                        return completion(.denied)

                    case .notDetermined:
                        print("[PermissionKit.MediaLibrary] 💽 permission not determined 🤔")
                        return completion(.notDetermined)
                }
            }
        }

        print("[PermissionKit.MediaLibrary] 💽 permission denied by iOS ⛔️")
        return completion(.notAvailable)
    }

}
