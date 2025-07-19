//
//  ToggleCheckBox.swift
//  CoreFramework
//
//  Created by milet on 12/07/25.
//

import Foundation
import UIKit

public class ToggleCheckbox: UIButton {
    public var isChecked: Bool = false
    private let checkedImage = UIImage(named: "checkedCheckbox")
    private let uncheckedImage = UIImage(named: "uncheckedCheckbox")
    
    public init() {
        super.init(frame: .zero)
        self.setImage(uncheckedImage, for: .normal)
        self.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func toggle() {
        isChecked.toggle()
        
        self.setImage(isChecked ? checkedImage : uncheckedImage, for: .normal)
    }
    
    public func getIsCheckedState() -> Bool {
        return isChecked
    }
}
