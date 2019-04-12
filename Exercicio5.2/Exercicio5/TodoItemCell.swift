//
//  TodoItemCell.swift
//  Exercicio5
//
//  Created by user151694 on 4/4/19.
//  Copyright © 2019 PUC. All rights reserved.
//

import UIKit

class TodoItemCell: UITableViewCell {
    var isCompleted: Bool = false {
        didSet {
            guard let currentText = textLabel?.text else { return }
            
            let strikeStyle = isCompleted
                ? NSNumber(value: NSUnderlineStyle.single.rawValue)
                : NSNumber(value: 0)
            let strokeEffect: [NSAttributedString.Key : Any] = [.strikethroughStyle: strikeStyle,
                                                                .strikethroughColor: UIColor.black]
            
            textLabel?.attributedText = NSAttributedString(string: currentText,
                                                           attributes: strokeEffect)
        }
    }
}


