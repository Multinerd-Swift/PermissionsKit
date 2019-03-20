import AVFoundation

public final class PermissionsKitCamera: PermissionsKitBase {

    public var identifier: String = "PermissionsKitCamera"
    
    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionsKitCamera: PermissionsKitProtocol {

    public func status(completion: @escaping PermissionsKitResponse) {

        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined: return completion(.notDetermined)
            case .restricted, .denied: return completion(.denied)
            case .authorized: return completion(.authorized)
        }
    }

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        AVCaptureDevice.requestAccess(for: .video) { (authorized) in

            if authorized {
                print("[PermissionsKit.Camera] 📷 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionsKit.Camera] 📷 permission denied by user ⛔️")
            return completion(.denied)
        }
    }

}
