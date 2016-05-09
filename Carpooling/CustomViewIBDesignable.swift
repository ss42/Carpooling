import UIKit

@IBDesignable class DesignableImageView: UIImageView{}

@IBDesignable class DesignableButton: UIButton{}

@IBDesignable class DesignableTextView: UITextField{
	
	@IBInspectable
	var placeholderTextColor: UIColor = UIColor.lightGrayColor(){
	didSet{
	guard let placeholder = placeholder else{
	return
	}
	attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
	[NSForegroundColorAttributeName : placeholderTextColor])
	}
	}
}


class UnderlinedLabel: UILabel {
    
    override var text: String! {
        
        didSet {
            // swift < 2. : let textRange = NSMakeRange(0, count(text))
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSUnderlineStyleAttributeName , value:NSUnderlineStyle.StyleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            
            self.attributedText = attributedText
        }
    }
}
extension UIView {
	

	@IBInspectable
	var borderWidth: CGFloat{
	get {
	return layer.borderWidth
	}
	set(newBoarderWidth){
	layer.borderWidth = newBoarderWidth
	}
	}

	@IBInspectable
	var borderColor: UIColor?{
	get {
	return layer.borderColor != nil ? UIColor(CGColor: layer.borderColor!) : nil
	}
	set {
	layer.borderColor = newValue?.CGColor
	}
	}
	@IBInspectable
	var cornerRadius: CGFloat{
	get{
	return layer.cornerRadius
	}
	set{
	layer.cornerRadius = newValue
	layer.masksToBounds = newValue != 0
	}
	}

	@IBInspectable
	var makeCircular: Bool?{
	get {
	return nil
	}
	set {
	if let makeCircular = newValue where makeCircular{
	cornerRadius = min(bounds.width, bounds.height)/2.0
	}
        }
    }
}