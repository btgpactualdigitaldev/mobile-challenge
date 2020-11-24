//
//  BtgTextField.swift
//  Btg
//
//  Created by Paulo Roberto Cremonine Junior on 26/12/19.
//  Copyright © 2019 Btg. All rights reserved.
//

import UIKit

@IBDesignable
open class BtgTextField: UITextField {
    @objc open var isLTRLanguage: Bool = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight {
        didSet {
           updateTextAligment()
        }
    }

    fileprivate func updateTextAligment() {
        if isLTRLanguage {
            textAlignment = .left
            titleLabel.textAlignment = .left
        } else {
            textAlignment = .right
            titleLabel.textAlignment = .right
        }
    }

    // MARK: Animation timing
    @objc dynamic open var titleFadeInDuration: TimeInterval = 0.2
    @objc dynamic open var titleFadeOutDuration: TimeInterval = 0.3

    // MARK: Format
    open var imputType: ImputType = .normal {
        didSet {
            createOutLineView()
        }
    }

    open var isVisibilityIconButtonEnabled: Bool = false {
        didSet {
            if(self.isVisibilityIconButtonEnabled){
                createVisibilityIconButtonIcon()
            }
        }
    }
    open var requiredMessage: String? = nil {
        didSet{
            updatePlaceholder()
        }
    }

    open var imputMask: ImputMask = .none {
        didSet {
            switch imputMask {
            case .email:
                self.keyboardType = .emailAddress
            case .date:
                self.keyboardType = .numberPad
            case .celPhone:
                self.keyboardType = .numberPad
            case .cpf:
                self.keyboardType = .numberPad
            case .money:
                self.keyboardType = .numberPad
            default:
                self.keyboardType = .default
            }
        }
    }

    
    
    // MARK: Colors
    fileprivate var cachedTextColor: UIColor?
    
    @IBInspectable
    override dynamic open var textColor: UIColor? {
        set {
            cachedTextColor = newValue
            updateControl(false)
        }
        get {
            return cachedTextColor
        }
    }

    @IBInspectable dynamic open var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            updatePlaceholder()
        }
    }

    @objc dynamic open var placeholderFont: UIFont? {
        didSet {
            updatePlaceholder()
        }
    }

    fileprivate func updatePlaceholder() {
        
        guard let placeholder = requiredMessage != nil ? placeholder! + "*" : placeholder, let font = placeholderFont ?? font else {
            return
        }
         
        let color = isEnabled ? placeholderColor : disabledColor
        
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        
        #if swift(>=4.2)
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font,
                    NSAttributedString.Key.paragraphStyle: centeredParagraphStyle]
            )
        #elseif swift(>=4.0)
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font
                ]
            )
        #else
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: font]
            )
        #endif
    }

    @objc dynamic open var titleFont: UIFont = .systemFont(ofSize: 13) {
        didSet {
            updateTitleLabel()
        }
    }

    @IBInspectable dynamic open var titleColor: UIColor = .gray {
        didSet {
            updateTitleColor()
        }
    }

    @IBInspectable dynamic open var lineColor: UIColor = .lightGray {
        didSet {
            updateLineView()
        }
    }

    @IBInspectable dynamic open var errorColor: UIColor = .red {
        didSet {
            updateColors()
        }
    }

    @IBInspectable dynamic open var lineErrorColor: UIColor? {
        didSet {
            updateColors()
        }
    }

    @IBInspectable dynamic open var textErrorColor: UIColor? {
        didSet {
            updateColors()
        }
    }

    @IBInspectable dynamic open var titleErrorColor: UIColor? {
        didSet {
            updateColors()
        }
    }

    @IBInspectable dynamic open var disabledColor: UIColor = UIColor(white: 0.88, alpha: 1.0) {
        didSet {
            updateControl()
            updatePlaceholder()
        }
    }

    @IBInspectable dynamic open var selectedTitleColor: UIColor = .blue {
        didSet {
            updateTitleColor()
        }
    }

    @IBInspectable dynamic open var selectedLineColor: UIColor = .black {
        didSet {
            updateLineView()
        }
    }

    // MARK: Line height
    @IBInspectable dynamic open var lineHeight: CGFloat = 0.5 {
        didSet {
            updateLineView()
            setNeedsDisplay()
        }
    }

    @IBInspectable dynamic open var selectedLineHeight: CGFloat = 1.0 {
        didSet {
            updateLineView()
            setNeedsDisplay()
        }
    }

    // MARK: View components
    open var lineView: UIView!
    open var outlineView: UIView!
    open var titleLabel: UILabel!

    // MARK: Properties
    open var titleFormatter: ((String) -> String) = { (text: String) -> String in
        /*if #available(iOS 9.0, *) {
            return text.localizedUppercase
        } else {
            return text.uppercased()
        }*/
        return text
    }

    override open var isSecureTextEntry: Bool {
        set {
            super.isSecureTextEntry = newValue
            fixCaretPosition()
        }
        get {
            return super.isSecureTextEntry
        }
    }

    @IBInspectable
    open var errorMessage: String? {
        didSet {
            updateControl(true)
        }
    }

    fileprivate var _highlighted: Bool = false

    override open var isHighlighted: Bool {
        get {
            return _highlighted
        }
        set {
            _highlighted = newValue
            updateTitleColor()
            updateLineView()
        }
    }

    open var editingOrSelected: Bool {
        return super.isEditing || isSelected
    }

    open var hasErrorMessage: Bool {
        return errorMessage != nil && errorMessage != ""
    }

    fileprivate var _renderingInInterfaceBuilder: Bool = false

   

    @IBInspectable
    override open var placeholder: String? {
        didSet {
            setNeedsDisplay()
            updatePlaceholder()
            updateTitleLabel()
        }
    }

    @IBInspectable open var selectedTitle: String? {
        didSet {
            updateControl()
        }
    }

    @IBInspectable open var title: String? {
        didSet {
            updateControl()
        }
    }

    open override var isSelected: Bool {
        didSet {
            updateControl(true)
        }
    }

    // MARK: - Initializers
    public init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 0.0, height: 45))
        init_BtgTextField()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        init_BtgTextField()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        init_BtgTextField()
    }

    fileprivate final func init_BtgTextField() {
        borderStyle = .none
        self.delegate = self

        createTitleLabel()
        createLineView()
        updateColors()
        addEditingChangedObserver()
        updateTextAligment()
        createOutLineView()
    }

    fileprivate func addEditingChangedObserver() {
        self.addTarget(self, action: #selector(BtgTextField.editingChanged), for: .editingChanged)
    }

    @objc open func editingChanged() {
        updateControl(true)
        updateTitleLabel(true)
        createMaskText()
    }

    // MARK: create components
    fileprivate func createTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleLabel.font = titleFont
        titleLabel.alpha = 0.0
        titleLabel.textColor = titleColor

        addSubview(titleLabel)
        self.titleLabel = titleLabel
    }
    
    fileprivate func createOutLineView(){
        let outlineView = UIView()
        outlineView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        outlineView.isUserInteractionEnabled = false
        outlineView.backgroundColor = .white
        outlineView.layer.cornerRadius = 10
        
        insertSubview(outlineView, at: 0)
        self.outlineView = outlineView
        
        updateOutlineView()
    }
    
    fileprivate func createMaskText(){
        var maskText: String = ""
                
        let textValue = self.text ?? ""
        if(textValue.count == 0){
            return
        }
        if(imputMask == .date){
            let currentText = textValue.onlyNumbers()
            if(currentText.count <= 2){
                maskText = currentText.getPosition(start: 0, end: 0)!
            }
            if(currentText.count == 3){
                maskText = "\(currentText.getPosition(start: 0, end: -1)!)/\(currentText.getPosition(start: 2, end: 0)!)"
            }
            if(currentText.count == 4){
                maskText = "\(currentText.getPosition(start: 0, end: -2)!)/\(currentText.getPosition(start: 2, end: 0)!)"
            }
            if(currentText.count >= 5){
                maskText = "\(currentText.getPosition(start: 0, end: (currentText.count - 2) * -1)!)/\(currentText.getPosition(start: 2, end: (currentText.count - 4) * -1)!)/\(currentText.getPosition(start: 4, end: 0)!)"
            }
            self.text = maskText
        }
        else if(imputMask == .email){
            self.text = textValue.lowercased()
        }
        if(imputMask == .celPhone){
            let currentText = textValue.onlyNumbers()
            if(currentText.count <= 2){
                maskText = currentText.getPosition(start: 0, end: 0)!
            }
            if(currentText.count > 2 && currentText.count <= 7){
                maskText = "(\(currentText.getPosition(start: 0, end: (currentText.count - 2) * -1)!)) \(currentText.getPosition(start: 2, end: 0)!)"
            }
            if(currentText.count >= 8){
                maskText = "(\(currentText.getPosition(start: 0, end: (currentText.count - 2) * -1)!)) \(currentText.getPosition(start: 2, end: (currentText.count - 7) * -1)!)-\(currentText.getPosition(start: 7, end: 0)!)"
            }
            self.text = maskText
        }
        if(imputMask == .cpf){
            let currentText = textValue.onlyNumbers()
            if(currentText.count <= 3){
                maskText = currentText.getPosition(start: 0, end: 0)!
            }
            if(currentText.count > 3 && currentText.count <= 6){
                maskText = "\(currentText.getPosition(start: 0, end: (currentText.count - 3) * -1)!).\(currentText.getPosition(start: 3, end: 0)!)"
            }
            if(currentText.count > 6 && currentText.count <= 9){
                maskText = "\(currentText.getPosition(start: 0, end: (currentText.count - 3) * -1)!).\(currentText.getPosition(start: 3, end: (currentText.count - 6) * -1)!).\(currentText.getPosition(start: 6, end: 0)!)"
            }
            if(currentText.count > 9){
                maskText = "\(currentText.getPosition(start: 0, end: (currentText.count - 3) * -1)!).\(currentText.getPosition(start: 3, end: (currentText.count - 6) * -1)!).\(currentText.getPosition(start: 6, end: (currentText.count - 9) * -1)!)-\(currentText.getPosition(start: 9, end: 0)!)"
            }
            self.text = maskText
        }
        if(imputMask == .money){
            if let amountString = self.text?.currencyInputFormatting() {
                self.text = amountString
            }
        }
    }
    
    fileprivate func createLineView() {
        if lineView == nil {
            let lineView = UIView()
            lineView.isUserInteractionEnabled = false
            self.lineView = lineView
            configureDefaultLineHeight()
        }

        lineView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        addSubview(lineView)
    }
    
    fileprivate func createVisibilityIconButtonIcon(){
        self.setRevealIcon()
    }

    fileprivate func configureDefaultLineHeight() {
        let onePixel: CGFloat = 1.0 / UIScreen.main.scale
        lineHeight = 2.0 * onePixel
        selectedLineHeight = 2.0 * self.lineHeight
    }

    // MARK: Responder handling
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        updateControl(true)
        return result
    }

    @discardableResult
    override open func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        updateControl(true)
        return result
    }

    override open var isEnabled: Bool {
        didSet {
            updateControl()
            updatePlaceholder()
        }
    }

    // MARK: - View updates
    fileprivate func updateControl(_ animated: Bool = false) {
        updateColors()
        updateLineView()
        updateTitleLabel(animated)
        updateOutlineView()
    }

    fileprivate func updateLineView() {
        guard let lineView = lineView else {
            return
        }

        lineView.frame = lineViewRectForBounds(bounds, editing: editingOrSelected)
        updateLineColor()
    }
    
    // MARK: - Color updates
    open func updateColors() {
        updateLineColor()
        updateTitleColor()
        updateTextColor()
    }

    fileprivate func updateLineColor() {
        guard let lineView = lineView else {
            return
        }

        if !isEnabled {
            lineView.backgroundColor = disabledColor
        } else if hasErrorMessage {
            lineView.backgroundColor = lineErrorColor ?? errorColor
        } else {
            lineView.backgroundColor = editingOrSelected ? selectedLineColor : lineColor
        }
    }

    fileprivate func updateTitleColor() {
        guard let titleLabel = titleLabel else {
            return
        }

        if !isEnabled {
            titleLabel.textColor = disabledColor
        } else if hasErrorMessage {
            titleLabel.textColor = titleErrorColor ?? errorColor
        } else {
            if editingOrSelected || isHighlighted {
                titleLabel.textColor = selectedTitleColor
            } else {
                titleLabel.textColor = titleColor
            }
        }
    }

    fileprivate func updateTextColor() {
        if !isEnabled {
            super.textColor = disabledColor
        } else if hasErrorMessage {
            super.textColor = textErrorColor ?? errorColor
        } else {
            super.textColor = cachedTextColor
        }
    }

    // MARK: - Title handling
    fileprivate func updateTitleLabel(_ animated: Bool = false) {
        guard let titleLabel = titleLabel else {
            return
        }

        var titleText: String?
        if hasErrorMessage {
            titleText = titleFormatter(errorMessage!)
        } else {
            if editingOrSelected {
                titleText = selectedTitleOrTitlePlaceholder()
                if titleText == nil {
                    titleText = titleOrPlaceholder()
                }
            } else {
                titleText = titleOrPlaceholder()
            }
        }
        titleLabel.text = titleText
        titleLabel.font = titleFont
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.init(red: 29/255, green: 35/255, blue: 67/255, alpha: 1.0)
        updateTitleVisibility(animated)
    }
    
    fileprivate func updateOutlineView(){
        updateOutLineVisibility()
    }

    fileprivate var _titleVisible: Bool = false

    open func setTitleVisible(_ titleVisible: Bool, animated: Bool = false, animationCompletion: ((_ completed: Bool) -> Void)? = nil) {
        if _titleVisible == titleVisible {
            return
        }
        _titleVisible = titleVisible
        updateTitleColor()
        updateTitleVisibility(animated, completion: animationCompletion)
    }

    open func isTitleVisible() -> Bool {
        return hasText || hasErrorMessage || _titleVisible
    }

    fileprivate func updateTitleVisibility(_ animated: Bool = false, completion: ((_ completed: Bool) -> Void)? = nil) {
        let alpha: CGFloat = isTitleVisible() ? 1.0 : 0.0
        let frame: CGRect = titleLabelRectForBounds(bounds, editing: isTitleVisible())
        let updateBlock = { () -> Void in
            self.titleLabel.alpha = alpha
            self.titleLabel.frame = frame
        }
        if animated {
            #if swift(>=4.2)
                let animationOptions: UIView.AnimationOptions = .curveEaseOut
            #else
                let animationOptions: UIViewAnimationOptions = .curveEaseOut
            #endif
            let duration = isTitleVisible() ? titleFadeInDuration : titleFadeOutDuration
            UIView.animate(withDuration: duration, delay: 0, options: animationOptions, animations: { () -> Void in updateBlock()}, completion: completion)
        } else {
            updateBlock()
            completion?(true)
        }
    }
    
    fileprivate func updateOutLineVisibility(){
        let frame: CGRect = outLineRectForBounds(bounds)

        self.outlineView.alpha = self.imputType == .outLine ? 1.0 : 0.0
        self.outlineView.frame = frame
    }

    // MARK: - UITextField text/placeholder positioning overrides
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        let titleHeight = self.titleHeight()
        let rect = CGRect(x: superRect.origin.x,y: titleHeight,width: superRect.size.width,height: superRect.size.height - titleHeight - selectedLineHeight)
        
        return rect
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        let titleHeight = self.titleHeight()
        let rect = CGRect(x: superRect.origin.x, y: titleHeight, width: superRect.size.width, height: superRect.size.height - titleHeight - selectedLineHeight)
        
        return rect
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect(x: 0, y: titleHeight(), width: bounds.size.width, height: bounds.size.height - titleHeight() - selectedLineHeight)
        
        return rect
    }

    // MARK: - Positioning Overrides
    open func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: 0, y: 0, width: bounds.size.width, height: titleHeight())
        }
        return CGRect(x: 0, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }

    open func outLineRectForBounds(_ bounds: CGRect) -> CGRect {
        return CGRect(x: -10, y: -10, width: bounds.size.width + 10, height: bounds.size.height + 10)
    }
    
    open func lineViewRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        let height = editing ? selectedLineHeight : lineHeight
        
        return CGRect(x: 0, y: bounds.size.height - height, width: bounds.size.width, height: height)
    }

    open func titleHeight() -> CGFloat {
        if let titleLabel = titleLabel,
            let font = titleLabel.font {
            return font.lineHeight
        }
        return 15.0
    }

    open func textHeight() -> CGFloat {
        guard let font = self.font else {
            return 0.0
        }

        return font.lineHeight + 7.0
    }

    // MARK: - Layout
    override open func prepareForInterfaceBuilder() {
        if #available(iOS 8.0, *) {
            super.prepareForInterfaceBuilder()
        }

        borderStyle = .none

        isSelected = true
        _renderingInInterfaceBuilder = true
        updateControl(false)
        invalidateIntrinsicContentSize()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.frame = titleLabelRectForBounds(bounds, editing: isTitleVisible() || _renderingInInterfaceBuilder)
        lineView.frame = lineViewRectForBounds(bounds, editing: editingOrSelected || _renderingInInterfaceBuilder)
    }

    override open var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.size.width, height: titleHeight() + textHeight())
    }

    // MARK: - Helpers
    fileprivate func titleOrPlaceholder() -> String? {
        guard let title = title ?? placeholder else {
            return nil
        }
        return titleFormatter(title)
    }

    fileprivate func selectedTitleOrTitlePlaceholder() -> String? {
        guard let title = selectedTitle ?? title ?? placeholder else {
            return nil
        }
        return titleFormatter(title)
    }
}

extension UITextField {
    var iconShow: UIView {
        let viewPadding = UIView(frame: CGRect(x: 0, y: 0, width: 25 , height: Int(self.frame.size.height - 5)))
        viewPadding.backgroundColor = .clear

        let imageView = UIImageView (frame:CGRect(x: 0, y: 10, width: 20 , height: 20))
        imageView.image = UIImage(named: "SF_eye")?.resize(toWidth: 20)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.isUserInteractionEnabled = true
        imageView.tintColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        imageView.backgroundColor = .clear

        viewPadding.addSubview(imageView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didReveal(tapGestureRecognizer:)))
        imageView.addGestureRecognizer(tapGestureRecognizer)

        return viewPadding
    }
    var iconHide: UIView {
        let viewPadding = UIView(frame: CGRect(x: 0, y: 0, width: 25 , height: Int(self.frame.size.height - 5)))
        viewPadding.backgroundColor = .clear

        let imageView = UIImageView (frame:CGRect(x: 0, y: 10, width: 20 , height: 20))
        imageView.image = UIImage(named: "SF_eye_fill")?.resize(toWidth: 20)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.isUserInteractionEnabled = true
        imageView.tintColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        imageView.backgroundColor = .clear

        viewPadding.addSubview(imageView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didReveal(tapGestureRecognizer:)))
        imageView.addGestureRecognizer(tapGestureRecognizer)

        return viewPadding
    }
    
    @objc func didReveal(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.isSecureTextEntry = !self.isSecureTextEntry
        self.rightView =  self.isSecureTextEntry ? iconHide : iconShow
    }
    
    func setRevealIcon() {
        self.rightView = iconHide
        self.rightViewMode = .always
    }
}

extension String{
    func getPosition(start: Int , end: Int) -> String?{
        return String(self[self.index(self.startIndex, offsetBy: start)..<self.index(self.endIndex, offsetBy: end)])
    }
    var isValidDate: Bool {
        guard !self.isEmpty else { return true }
        
        if(self.count == 10){
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd/MM/yyyy"
            return (dateFormatterGet.date(from: self) != nil)
        }
        else{
            return false
        }
    }
    var isValidEmail: Bool {
        guard !self.isEmpty else { return true }
        
        return NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: self)
    }
    var isValidCelPhone: Bool {
        guard !self.isEmpty else { return true }
        
        return self.count != 15 || !["(11)","(12)","(13)","(14)","(15)","(16)","(17)","(18)","(19)","(21)","(22)","(24)","(27)","(28)","(31)","(32)","(33)","(34)","(35)","(37)","(38)","(41)","(42)","(43)","(44)","(45)","(46)","(47)","(48)","(49)","(51)","(53)","(54)","(55)","(61)","(62)","(63)","(64)","(65)","(66)","(67)","(68)","(69)","(71)","(73)","(74)","(75)","(77)","(79)","(81)","(82)","(83)","(84)","(85)","(86)","(87)","(88)","(89)","(91)","(92)","(93)","(94)","(95)","(96)","(97)","(98)","(99)"].contains(where: self.contains) ? false : true
        
    }
    var isValidCpf: Bool {
        guard !self.isEmpty else { return true }
        
        let cpf = self.onlyNumbers()
        guard cpf.count == 11 else { return false }
        
        let i1 = cpf.index(cpf.startIndex, offsetBy: 9)
        let i2 = cpf.index(cpf.startIndex, offsetBy: 10)
        let i3 = cpf.index(cpf.startIndex, offsetBy: 11)
        let d1 = Int(cpf[i1..<i2])
        let d2 = Int(cpf[i2..<i3])
        
        var temp1 = 0, temp2 = 0
        
        for i in 0...8 {
            let start = cpf.index(cpf.startIndex, offsetBy: i)
            let end = cpf.index(cpf.startIndex, offsetBy: i+1)
            let char = Int(cpf[start..<end])
            
            temp1 += char! * (10 - i)
            temp2 += char! * (11 - i)
        }
        
        temp1 %= 11
        temp1 = temp1 < 2 ? 0 : 11-temp1
        
        temp2 += temp1 * 2
        temp2 %= 11
        temp2 = temp2 < 2 ? 0 : 11-temp2
        
        return temp1 == d1 && temp2 == d2
        
        
    }
    
    func onlyNumbers() -> String {
        guard !isEmpty else { return "" }
        return replacingOccurrences(of: "\\D",
                                    with: "",
                                    options: .regularExpression,
                                    range: startIndex..<endIndex)
    }
    
    func setUrlString() -> String {
        guard !isEmpty else { return "" }
        return replacingOccurrences(of: " ",
                                    with: "%20",
                                    options: .regularExpression,
                                    range: startIndex..<endIndex)
    }
    
    func toDateSmallFormat(format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        let endposition = self.count - format.count
        
        let date: Date? = dateFormatter.date(from: self.getPosition(start: 0, end: endposition * -1)!)
        return date
    }
    
    func toDateLongFormat() -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy HH:mm"
        
        let endposition = (self.count - dateFormatterGet.dateFormat.count) + 2
        let strDate = self.getPosition(start: 0, end: endposition * -1)!
        
        let date: Date? = dateFormatterGet.date(from: strDate)
        let dateReturn = dateFormatterPrint.string(from: date!)
        
        return dateReturn
    }
    
    func toCpf() -> String {
        var maskText: String = ""
        let currentText = self.onlyNumbers()
        if(currentText.count <= 3){
            maskText = currentText.getPosition(start: 0, end: 0)!
        }
        if(currentText.count > 3 && currentText.count <= 6){
            maskText = "\(currentText.getPosition(start: 0, end: (currentText.count - 3) * -1)!).\(currentText.getPosition(start: 3, end: 0)!)"
        }
        if(currentText.count > 6 && currentText.count <= 9){
            maskText = "\(currentText.getPosition(start: 0, end: (currentText.count - 3) * -1)!).\(currentText.getPosition(start: 3, end: (currentText.count - 6) * -1)!).\(currentText.getPosition(start: 6, end: 0)!)"
        }
        if(currentText.count > 9){
            maskText = "\(currentText.getPosition(start: 0, end: (currentText.count - 3) * -1)!).\(currentText.getPosition(start: 3, end: (currentText.count - 6) * -1)!).\(currentText.getPosition(start: 6, end: (currentText.count - 9) * -1)!)-\(currentText.getPosition(start: 9, end: 0)!)"
        }
        return maskText
    }
    
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    func changeValueAmount() -> Double {
        guard !self.isEmpty else {
            return 0
        }
        let vs = self.getPosition(start: 0, end: -2)! + "." + self.getPosition(start: self.count - 2, end: 0)!
        return Double(vs)!
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

