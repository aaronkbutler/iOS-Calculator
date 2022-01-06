//
//  ABDigitUIButton.swift
//  Calculator
//
//  Created by Aaron Butler on 1/6/22.
//

import UIKit

class ABDigitUIButton: UIButton {

    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }


    func setup() {
        self.configuration?.baseBackgroundColor = .red
        
        
    }

}
