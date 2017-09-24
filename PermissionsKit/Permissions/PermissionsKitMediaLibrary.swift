import MediaPlayer

public final class PermissionsKitMediaLibrary: PermissionsKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionsKitMediaLibrary: PermissionsKitProtocol {

    public var identifier: String {
        return "PermissionsKitMediaLibrary"
    }

    public func status(completion: @escaping PermissionsKitResponse) {

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

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        if #available(iOS 9.3, *) {
            MPMediaLibrary.requestAuthorization { status in
                switch status {
                    case .authorized:
                        print("[PermissionsKit.MediaLibrary] 💽 permission authorized by user ✅")
                        return completion(.authorized)

                    case .restricted, .denied:
                        print("[PermissionsKit.MediaLibrary] 💽 permission denied by user ⛔️")
                        return completion(.denied)

                    case .notDetermined:
                        print("[PermissionsKit.MediaLibrary] 💽 permission not determined 🤔")
                        return completion(.notDetermined)
                }
            }
        }

        print("[PermissionsKit.MediaLibrary] 💽 permission denied by iOS ⛔️")
        return completion(.notAvailable)
    }

}
