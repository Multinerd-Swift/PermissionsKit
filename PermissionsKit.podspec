Pod::Spec.new do |s|
    
    s.name    = 'PermissionsKit'
    s.version = '1.0.1'
    s.summary = 'PermissionsKit is a wrapper to handle the various iOS permissions.'
    
    s.homepage = 'https://github.com/Multinerd-Swift/PermissionsKit'
    s.license  = { :type => 'MIT', :file => 'LICENSE' }
    s.author   = { 'Multinerd' => 'multinerd@users.noreply.github.com' }
    s.source   = { :git => 'https://github.com/Multinerd-Swift/PermissionsKit.git', :tag => s.version.to_s }
    
    s.frameworks = 'UIKit'
    s.ios.deployment_target = '10.0'
    
    s.source_files = 'PermissionsKit/**/*.swift',
                     'PermissionsKit/Core/**/*.swift',
                     'PermissionsKit/Permissions/**/*.swift'
    
    s.subspec 'Core' do |ss|
        ss.source_files = 'PermissionsKit/Core/**/*.swift'
    end
    
    s.subspec 'Bluetooth' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitBluetooth.swift'
        ss.frameworks   = 'CoreBluetooth'
    end
    
    s.subspec 'Camera' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitCamera.swift'
        ss.frameworks   = 'AVFoundation'
    end
    
    s.subspec 'CloudKit' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitCloudKit.swift'
        ss.frameworks   = 'CloudKit'
    end
    
    s.subspec 'Contacts' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitContacts.swift'
        ss.frameworks   = 'AddressBook'
    end
    
    s.subspec 'Events' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitEvents.swift'
        ss.frameworks   = 'EventKit'
    end
    
    s.subspec 'Health' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitHealth.swift'
        ss.frameworks   = 'HealthKit'
    end
    
    s.subspec 'Location' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/Location/*.swift'
        ss.frameworks   = 'CoreLocation'
    end
    
    s.subspec 'MediaLibrary' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitMediaLibrary.swift'
        ss.frameworks   = 'MediaPlayer'
    end
    
    s.subspec 'Microphone' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitMicrophone.swift'
        ss.frameworks   = 'AVFoundation'
    end
    
    s.subspec 'Motion' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitMotion.swift'
        ss.frameworks   = 'CoreMotion'
    end
    
    s.subspec 'Notifications' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitNotifications.swift'
    end
    
    s.subspec 'Photos' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitPhoto.swift'
        ss.frameworks   = 'AssetsLibrary'
    end
    
    s.subspec 'Reminders' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitReminders.swift'
        ss.frameworks   = 'EventKit'
    end
    
    s.subspec 'SpeechRecognizer' do |ss|
        ss.dependency 'PermissionsKit/Core'
        ss.source_files = 'PermissionsKit/Permissions/PermissionsKitSpeechRecognizer.swift'
        ss.frameworks   = 'Speech'
    end
end
