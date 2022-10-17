//
//  RouteVC.swift
//  TextureVOUI
//
//  Created by Jefferson Setiawan on 13/09/21.
//

import CryptoKit
import UIKit

class MyClass {}

struct AModel: Codable {
    var id: Int
    var name: String
}

struct BModel {
    var id: Int
    weak var cl: MyClass?
}

func getData() throws -> Data  {
    let str = """
    {
        "id": "1",
        "name": "Jeff"
    }
    """
    return str.data(using: .utf8)!
}

public final class RouteVC: UITableViewController {
    private enum Route: String, CaseIterable {
        case texture3RxIssue = "Texture 3 RxIssue onComplete"
        case collectionViewSection = "UICollectionView with Section"
        case collectionNodeSection = "ASCollectionNode with Section"
        case dynamicFontUikit = "Dynamic font UIKit"
        case dynamicFontTexture = "Dynamic font Texture"
        case wrappingUsingControlNode = "Using ASControlNode to Wrap Layout"
        case voiceOverActivationPoint = "Voice Over Activation Point"
        case uiTestRoute = "UITest Accessibility Cases Example"
        case textureIssue = "⚠️ Texture Issue"
    }

    private let routes: [Route] = Route.allCases

    public init() {
        super.init(style: .insetGrouped)

        title = "Texture UITest Issue"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let aView = MyView()
        aView.layoutIfNeeded()
        aView.sizeToFit()
        aView.translatesAutoresizingMaskIntoConstraints = false
        
//        navigationItem.titleView?.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.titleView = aView
        
        
//        do {
//            let data = try getData()
//            do {
//                let success = try JSONDecoder().decode(AModel.self, from: data)
//
//                print(success)
//            } catch {
//                print("<<< inner error", error.localizedDescription)
//                print("<<< inner error", String(describing: error), String(data: data, encoding: .utf8) ?? "JSON can't be read")
//                throw error
//            }
//        } catch {
//            print("<<< JEFF outer", String(describing: error))
//        }
//        secureEnclave()
    }
    
    private func secureEnclave() {
        guard SecureEnclave.isAvailable else { return }
        var protocolSalt = "Hello, playground".data(using: .utf8)!
        let keys = try! SecureEnclave.P256.KeyAgreement.PrivateKey()
        let bKeys = try! SecureEnclave.P256.KeyAgreement.PrivateKey()
        let sharedSecret = try! keys.sharedSecretFromKeyAgreement(with: bKeys.publicKey)
        let symKey = sharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self, salt: protocolSalt, sharedInfo: Data(), outputByteCount: 32)
        let plainText = "Hello Indonesia"
        let sealed = try! AES.GCM.seal(plainText.data(using: .utf8)!, using: symKey)
        let encryptedText = sealed.combined!
        let sealedBox = try! AES.GCM.SealedBox(combined: encryptedText)
        let text = try! AES.GCM.open(sealedBox, using: symKey)
        print("<<< ", String(data: keys.dataRepresentation, encoding: .utf8))
        print(String(data: encryptedText, encoding: .utf8))
    }

    override public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedRoute = routes[indexPath.row]
        switch selectedRoute {
        case .dynamicFontUikit:
            navigationController?.pushViewController(DynamicFontUIKitVC(), animated: true)
        case .dynamicFontTexture:
            navigationController?.pushViewController(DynamicFontTextureVC(), animated: true)
        case .wrappingUsingControlNode:
            navigationController?.pushViewController(FailureIdentifier1VC(), animated: true)
        case .voiceOverActivationPoint:
            navigationController?.pushViewController(ActivationPointVC(), animated: true)
        case .uiTestRoute:
            navigationController?.pushViewController(AccessibilityIdentifierCasesViewController(), animated: true)
        case .textureIssue:
            navigationController?.pushViewController(TextureIssueRouteVC(), animated: true)
        case .collectionViewSection:
            navigationController?.pushViewController(CollectionWithSectionVC(), animated: true)
        case .collectionNodeSection:
            navigationController?.pushViewController(CollectionWithSectionNodeVC(), animated: true)
        case .texture3RxIssue:
            navigationController?.pushViewController(Texture3SubjectCompleteVC(), animated: true)
        }
    }

    override public func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int {
        return routes.count
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = routes[indexPath.row].rawValue
        return cell
    }

    internal required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MyView: UIView {
    init() {
        super.init(frame: .zero)
        frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContiguousBytes {
    /// A Data instance created safely from the contiguous bytes without making any copies.
    public var dataRepresentation: Data {
        return withUnsafeBytes { bytes in
            let cfdata = CFDataCreateWithBytesNoCopy(nil, bytes.baseAddress?.assumingMemoryBound(to: UInt8.self), bytes.count, kCFAllocatorNull)
            return ((cfdata as NSData?) as Data?) ?? Data()
        }
    }
}
