import Foundation
import CoreLocation

public class PermissionsKitLocationBase: PermissionsKitBase, PermissionsKitProtocol {

    public var identifier: String = "PermissionsKitLocationBase"

    var completion: PermissionsKitResponse? {
        willSet {
            locationDelegate = PermissionsKitLocationBaseDelegate(permission: self, completion: newValue!)
        }
    }

    private var locationDelegate: PermissionsKitLocationBaseDelegate?

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(identifier: String) {

        super.init(identifier: identifier)
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

    public func status(completion: @escaping PermissionsKitResponse) {

        guard CLLocationManager.locationServicesEnabled() else {
            return completion(.notDetermined)
        }

        switch CLLocationManager.authorizationStatus() {
            case .notDetermined: return completion(.notDetermined)
            case .restricted, .denied: return completion(.denied)
            case .authorizedAlways, .authorizedWhenInUse: return completion(.authorized)
        }
    }

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

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

public class PermissionsKitLocationBaseDelegate: NSObject, CLLocationManagerDelegate {

    var locationManager: CLLocationManager = CLLocationManager()

    var completion: PermissionsKitResponse?

    weak var permission: PermissionsKitProtocol?

    public init(permission: PermissionsKitProtocol, completion: @escaping PermissionsKitResponse) {

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

