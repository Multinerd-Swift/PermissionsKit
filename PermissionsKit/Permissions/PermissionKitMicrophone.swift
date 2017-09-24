import AVFoundation

public final class PermissionKitMicrophone: PermissionKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionKitMicrophone: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitMicrophone"
    }

    public func status(completion: @escaping PermissionKitResponse) {

        switch AVAudioSession.sharedInstance().recordPermission() {
            case .undetermined: return completion(.notDetermined)
            case .granted: return completion(.authorized)
            case .denied: return completion(.denied)
        }
    }

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in

            if granted {
                print("[PermissionKit.Microphone] 🎤 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionKit.Microphone] 🎤 permission denied by user ⛔️")
            return completion(.denied)
        }
    }

}
