import CoreBluetooth

public final class PermissionsKitBluetooth: PermissionsKitBase {

    public var identifier: String = "PermissionsKitBluetooth"
    
    let bluetooth = PermissionsKitBluetoothDelegate()

    public init() {

        super.init(identifier: "PermissionsKitBluetooth")
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionsKitBluetooth: PermissionsKitProtocol {

    public func status(completion: @escaping PermissionsKitResponse) {

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

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        bluetooth.completion = completion

        switch bluetooth.bluetoothManager.state {
            case .unauthorized:
                print("[PermissionsKit.Bluetooth] bluetooth not authorized by the user ⛔️")
                return completion(.denied)

            case .unsupported, .poweredOff, .resetting:
                print("[PermissionsKit.Bluetooth] bluetooth not available 🚫")
                return completion(.notAvailable)

            case .unknown:
                print("[PermissionsKit.Bluetooth] bluetooth could not be determined 🤔")
                return completion(.notDetermined)

            case .poweredOn:
                bluetooth.bluetoothManager?.startAdvertising(nil)
                bluetooth.bluetoothManager?.stopAdvertising()
                break
        }
    }

}

class PermissionsKitBluetoothDelegate: NSObject, CBPeripheralManagerDelegate {

    fileprivate var bluetoothManager: CBPeripheralManager!

    fileprivate var completion: PermissionsKitResponse?

    public override init() {

        super.init()
        self.bluetoothManager = CBPeripheralManager(delegate: self, queue: nil, options: [ CBPeripheralManagerOptionShowPowerAlertKey: false ])
    }

    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {

        switch peripheral.state {
            case .unauthorized:
                print("[PermissionsKit.Bluetooth] bluetooth permission denied by user ⛔️")
                if let completion = self.completion {
                    return completion(.denied)
                }

            case .unsupported, .poweredOff, .resetting:
                print("[PermissionsKit.Bluetooth] bluetooth not available 🚫")
                if let completion = self.completion {
                    return completion(.notAvailable)
                }

            case .unknown:
                print("[PermissionsKit.Bluetooth] bluetooth could not be determined 🤔")
                if let completion = self.completion {
                    return completion(.notDetermined)
                }

            case .poweredOn:
                print("[PermissionsKit.Bluetooth] bluetooth permission authorized by user ✅")
                if let completion = self.completion {
                    return completion(.authorized)
                }
        }
    }

}
