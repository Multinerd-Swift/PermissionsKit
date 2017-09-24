import Speech

public final class PermissionsKitSpeechRecognizer: PermissionsKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

@available(iOS 10.0, *)
extension PermissionsKitSpeechRecognizer: PermissionsKitProtocol {

    public var identifier: String {
        return "PermissionsKitSpeechRecognizer"
    }

    public func status(completion: @escaping PermissionsKitResponse) {

        let status = SFSpeechRecognizer.authorizationStatus()
        switch status {
            case .authorized: return completion(.authorized)
            case .restricted, .denied: return completion(.denied)
            case .notDetermined: return completion(.notDetermined)
        }

    }

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        SFSpeechRecognizer.requestAuthorization { status in
            switch status {
                case .authorized:
                    print("[PermissionsKit.SpeechRecognizer] 🗣 permission authorized by user ✅")
                    return completion(.authorized)

                case .restricted, .denied:
                    print("[PermissionsKit.SpeechRecognizer] 🗣 permission denied by user ⛔️")
                    return completion(.denied)

                case .notDetermined:
                    print("[PermissionsKit.SpeechRecognizer] 🗣 permission not determined 🤔")
                    return completion(.notDetermined)
            }
        }

        print("[PermissionsKit.SpeechRecognizer] 🗣 permission only available from iOS 10 ⛔️")
        return completion(.notAvailable)
    }

}
