import CoreBluetooth

public final class PermissionKitBluetooth: PermissionKitBase {

    let bluetooth = PermissionKitBluetoothDelegate()

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionKitBluetooth: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitBluetooth"
    }

    public func status(completion: @escaping PermissionKitResponse) {

        bluetooth.completion = completion

        switch CBPeripheralManager.authorizationStatus() {
            case .restricted, .denied: return completion(.denied)
            case .notDetermined, .authorized:
                switch bluetooth.bluetoothManager.state {
                    case .unauthorized: return completion(.denied)
                    case .unsupported, .poweredOff, .resetting: return completion(.notAvailable)
                    case .unknown: return completion(.notDetermined)
                    case .poweredOn: return completion(.authorized)
                }
        }
    }

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        bluetooth.completion = completion

        switch bluetooth.bluetoothManager.state {
            case .unauthorized:
                print("[PermissionKit.Bluetooth] bluetooth not authorized by the user ⛔️")
                return completion(.denied)

            case .unsupported, .poweredOff, .resetting:
                print("[PermissionKit.Bluetooth] bluetooth not available 🚫")
                return completion(.notAvailable)

            case .unknown:
                print("[PermissionKit.Bluetooth] bluetooth could not be determined 🤔")
                return completion(.notDetermined)

            case .poweredOn:
                bluetooth.bluetoothManager?.startAdvertising(nil)
                bluetooth.bluetoothManager?.stopAdvertising()
                break
        }
    }

}

class PermissionKitBluetoothDelegate: NSObject, CBPeripheralManagerDelegate {

    fileprivate var bluetoothManager: CBPeripheralManager!

    fileprivate var completion: PermissionKitResponse?

    public override init() {

        super.init()
        self.bluetoothManager = CBPeripheralManager(delegate: self, queue: nil, options: [ CBPeripheralManagerOptionShowPowerAlertKey: false ])
    }

    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {

        switch peripheral.state {
            case .unauthorized:
                print("[PermissionKit.Bluetooth] bluetooth permission denied by user ⛔️")
                if let completion = self.completion {
                    return completion(.denied)
                }

            case .unsupported, .poweredOff, .resetting:
                print("[PermissionKit.Bluetooth] bluetooth not available 🚫")
                if let completion = self.completion {
                    return completion(.notAvailable)
                }

            case .unknown:
                print("[PermissionKit.Bluetooth] bluetooth could not be determined 🤔")
                if let completion = self.completion {
                    return completion(.notDetermined)
                }

            case .poweredOn:
                print("[PermissionKit.Bluetooth] bluetooth permission authorized by user ✅")
                if let completion = self.completion {
                    return completion(.authorized)
                }
        }
    }

}
