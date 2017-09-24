import Foundation
import CoreLocation

public class PermissionKitLocationBase: PermissionKitBase, PermissionKitProtocol {

    public var identifier: String = "PermissionKitLocationBase"

    var completion: PermissionKitResponse? {
        willSet {
            locationDelegate = PermissionKitLocationBaseDelegate(permission: self, completion: newValue!)
        }
    }

    private var locationDelegate: PermissionKitLocationBaseDelegate?

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(identifier: String) {

        super.init(identifier: identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

    public func status(completion: @escaping PermissionKitResponse) {

        guard CLLocationManager.locationServicesEnabled() else {
            return completion(.notDetermined)
        }

        switch CLLocationManager.authorizationStatus() {
            case .notDetermined: return completion(.notDetermined)
            case .restricted, .denied: return completion(.denied)
            case .authorizedAlways, .authorizedWhenInUse: return completion(.authorized)
        }
    }

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        fatalError("askForPermission(configuration) has not been implemented. Use `requestAlwaysAuthorization` or `requestWhenInUseAuthorization` instead.")
    }

    func requestAlwaysAuthorization() {

        if let delegate = self.locationDelegate {
            delegate.locationManager.requestAlwaysAuthorization()
        }
    }

    func requestWhenInUseAuthorization() {

        if let delegate = self.locationDelegate {
            delegate.locationManager.requestWhenInUseAuthorization()
        }
    }
}

public class PermissionKitLocationBaseDelegate: NSObject, CLLocationManagerDelegate {

    var locationManager: CLLocationManager = CLLocationManager()

    var completion: PermissionKitResponse?

    weak var permission: PermissionKitProtocol?

    public init(permission: PermissionKitProtocol, completion: @escaping PermissionKitResponse) {

        super.init()
        self.completion = completion
        self.permission = permission
        self.locationManager.delegate = self
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        if let permission = self.permission {
            permission.status(completion: { (status) in
                if let completion = self.completion {
                    completion(status)
                }
            })
        }
    }

}

