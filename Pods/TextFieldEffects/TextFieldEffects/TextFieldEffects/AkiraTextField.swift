//
//  AkiraTextField.swift
//  TextFieldEffects
//
//  Created by Mihaela Miches on 5/31/15.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

/**
 An AkiraTextField is a subclass of the TextFieldEffects object, is a control that displays an UITextField with a customizable visual effect around the edges of the control.
 */
@IBDesignable open class AkiraTextField : TextFieldEffects {
    
    private let borderSize: (active: CGFloat, inactive: CGFloat) = (1, 1)
    private let borderLayer = CALayer()
    private let textFieldInsets = CGPoint(x: 6, y: 0)
    private let placeholderInsets = CGPoint(x: 6, y: 0)
    
    
    var colorchange = true
    /**
     The color of the border.
     
     This property applies a color to the bounds of the control. The default value for this property is a clear color.
    */
    @IBInspectable dynamic open var borderColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    /**
     The color of the placeholder text.
     
     This property applies a color to the complete placeholder string. The default value for this property is a black color.
     */
    @IBInspectable dynamic open var placeholderColor: UIColor = .black {
        didSet {
            updatePlaceholder()
        }
    }
    
    /**
     The scale of the placeholder font.
     
     This property determines the size of the placeholder label relative to the font size of the text field.
     */
    @IBInspectable dynamic open var placeholderFontScale: CGFloat = 0.3 {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            updateBorder()
        }
    }
    
    // MARK: TextFieldEffects
    
    override open func drawViewsForRect(_ rect: CGRect) {
        updateBorder()
        updatePlaceholder()
        
        addSubview(placeholderLabel)
        layer.addSublayer(borderLayer)
    }
    
    override open func animateViewsForTextEntry() {
        UIView.animate(withDuration: 0.3, animations: {
            self.updateBorder()
            self.updatePlaceholder()
            //self.updatePlaceholders()
        }, completion: { _ in
            self.animationCompletionHandler?(.textEntry)
        })
    }
    
    override open func animateViewsForTextDisplay() {
        UIView.animate(withDuration: 0.3, animations: {
            self.updateBorder()
            self.updatePlaceholder()
            //self.updatePlaceholders()
            
        }, completion: { _ in
            self.animationCompletionHandler?(.textDisplay)
        })
    }
    
    // MARK: Private
    
    private func updatePlaceholder() {
        placeholderLabel.frame = placeholderRect(forBounds: bounds)
        placeholderLabel.text = placeholder
       // placeholderLabel.font = placeholderFontFromFont(font!)
        placeholderLabel.font = (isFirstResponder || text!.isNotEmpty) ? UIFont.systemFont(ofSize: 12) : placeholderFontFromFont(font!)
        placeholderLabel.textColor = (isFirstResponder || text!.isNotEmpty) ? #colorLiteral(red: 0.5019607843, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1)
        placeholderLabel.textAlignment = textAlignment
        
        if isFirstResponder == true{
        
        placeholderLabel.textColor = #colorLiteral(red: 0.5019607843, green: 0, blue: 0, alpha: 1)
        }
        
        else {
        placeholderLabel.textColor = #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1)
        
        }
       
        
                
    }
    
    private func updatePlaceholders() {
        placeholderLabel.frame = placeholderRect(forBounds: bounds)
        placeholderLabel.text = placeholder
        placeholderLabel.textAlignment = textAlignment
        
       // placeholderLabel.textColor = #colorLiteral(red: 0.5529411765, green: 0.1254901961, blue: 0.1607843137, alpha: 1)
        
        
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
        
                    placeholderLabel.font = UIFont.systemFont(ofSize: 5)
                }
        
                else{
        
                    placeholderLabel.font = UIFont.systemFont(ofSize: 8)
                }
        
    }
    
    private func updateBorder() {
        borderLayer.frame = rectForBounds(bounds)
        borderLayer.borderWidth = (isFirstResponder || text!.isNotEmpty) ? borderSize.active : borderSize.inactive
        borderLayer.borderColor = borderColor?.cgColor
        borderLayer.cornerRadius = 4
    }
    
    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * placeholderFontScale)
        return smallerFont
    }
    
    private var placeholderHeight : CGFloat {
        return placeholderInsets.y + placeholderFontFromFont(font!).lineHeight
    }
    
    private func rectForBounds(_ bounds: CGRect) -> CGRect {
       
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            
            return CGRect(x: bounds.origin.x, y: bounds.origin.y + placeholderHeight, width: bounds.size.width, height: 32)
        }
            
        else{
            
            return CGRect(x: bounds.origin.x, y: bounds.origin.y + placeholderHeight, width: bounds.size.width, height: 42)
        }
        
//        return CGRect(x: bounds.origin.x, y: bounds.origin.y + placeholderHeight, width: bounds.size.width, height: bounds.size.height - placeholderHeight)
        
    }
    
    // MARK: - Overrides
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if isFirstResponder || text!.isNotEmpty {
            return CGRect(x: placeholderInsets.x, y: placeholderInsets.y, width: bounds.width, height: placeholderHeight)
        } else {
            return textRect(forBounds: bounds)
        }
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y + placeholderHeight/3.5)
    }
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

