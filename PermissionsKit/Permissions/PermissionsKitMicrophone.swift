import AVFoundation

public final class PermissionsKitMicrophone: PermissionsKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionsKitMicrophone: PermissionsKitProtocol {

    public var identifier: String {
        return "PermissionsKitMicrophone"
    }

    public func status(completion: @escaping PermissionsKitResponse) {

        switch AVAudioSession.sharedInstance().recordPermission() {
            case .undetermined: return completion(.notDetermined)
            case .granted: return completion(.authorized)
            case .denied: return completion(.denied)
        }
    }

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in

            if granted {
                print("[PermissionsKit.Microphone] 🎤 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionsKit.Microphone] 🎤 permission denied by user ⛔️")
            return completion(.denied)
        }
    }

}
