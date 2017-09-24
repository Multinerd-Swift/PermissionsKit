import AVFoundation

public final class PermissionKitCamera: PermissionKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionKitCamera: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitCamera"
    }

    public func status(completion: @escaping PermissionKitResponse) {

        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined: return completion(.notDetermined)
            case .restricted, .denied: return completion(.denied)
            case .authorized: return completion(.authorized)
        }
    }

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        AVCaptureDevice.requestAccess(for: .video) { (authorized) in

            if authorized {
                print("[PermissionKit.Camera] 📷 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionKit.Camera] 📷 permission denied by user ⛔️")
            return completion(.denied)
        }
    }

}
