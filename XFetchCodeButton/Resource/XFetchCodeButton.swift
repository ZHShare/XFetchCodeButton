//
//  XFetchCodeButton
//  XFetchCodeButton
//
//  Created by 王雄皓 on 2017/4/19.
//  Copyright © 2017年 王雄皓. All rights reserved.
//
import UIKit


public class XFetchCodeButton: UIView {
    
    static let countDownDefault: Int = 10 // 倒计时时间

    fileprivate var timer: Timer? // 定时器
    fileprivate var codeBtn: UIButton? // 倒计时按钮
    fileprivate var doneSendBlock: (() -> Void)? // 回调块

    fileprivate lazy var timerCount: Int = countDownDefault
    fileprivate lazy var countDown: String = "秒后重发" // 默认后缀
    
    var disabledColor: UIColor = UIColor.gray { //默认不可用状态颜色
        
        didSet {
            
            guard let btn = codeBtn else { return }
            btn.setTitleColor(disabledColor, for: .disabled)
        }
    }
    
    var fontSize: CGFloat = 10 {// 默认字体大小
        
        didSet {
            
            guard let btn = codeBtn else { return }
            btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    var normalTintColor: UIColor = UIColor.blue { // 默认字体颜色
        
        didSet {
            setTitleColor(normalTintColor)
        }
    }
    
    public var normalTitle: String = "获取验证码" { // 默认normal显示文字
       
        didSet {
            setTitle(normalTitle)
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        codeBtn = {
            let button = UIButton(type: .custom)
            button.setTitle(normalTitle, for: .normal)
            button.setTitleColor(normalTintColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
            button.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
            button.setTitleColor(disabledColor, for: .disabled)
            button.backgroundColor = .clear
            button.addTarget(self, action: #selector(codeSend), for: .touchUpInside)
            return button
        }()
        self.backgroundColor = .clear
        addSubview(codeBtn!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() { // 重写codebtn的frame
        super.layoutSubviews()
        codeBtn!.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    /// target 添加
    public func addTarget(target: Any?, action: Selector, forEvents: UIControlEvents) {
        
        guard let btn = codeBtn else { return }
        btn.addTarget(target, action: action, for: forEvents)
    }

    /// 点击回调
    public func doneSend(_ callBack: @escaping () -> Void) {
        
        doneSendBlock = callBack
    }
    
}
fileprivate extension XFetchCodeButton {
    
    /// 设置未点击文字颜色
    func setTitleColor(_ forNormal: UIColor) {
        
        guard let btn = codeBtn else { return }
        btn.setTitleColor(forNormal, for: .normal)
    }
    
    /// 设置未点击文字
    func setTitle(_ forNormal: String) {
        
        guard let btn = codeBtn else { return }
        btn.setTitle(forNormal, for: .normal)
    }
    
    @objc func codeSend() {
        
        guard let btn = codeBtn else { return }
        
        if let block = doneSendBlock {
            block()
        }
        
        btn.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(self.start(_:)), userInfo: nil, repeats: true)
    }
    
    
    func stop() {
        
        if let ti = timer {
            ti.invalidate()
            timer = nil
            timerCount = XFetchCodeButton.countDownDefault
        }
    }
    
    @objc func start(_ time: Timer) {
        
        if timerCount == 1 {
            
            if let ti = timer {
                ti.invalidate()
                timer = nil
            }
            
            timerCount = XFetchCodeButton.countDownDefault
            DispatchQueue.main.async {
                if let button = self.codeBtn {
                    button.isEnabled = true
                    button.setTitle(self.normalTitle, for: .normal)
                }
            }
            return
        }
        
        timerCount -= 1
        DispatchQueue.main.async {
            if let button = self.codeBtn {
                button.setTitle(String(self.timerCount) + self.countDown, for: .normal)
            }
        }
    }
    
}
