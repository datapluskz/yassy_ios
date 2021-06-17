
import UIKit
class SomeAwesomeView: UIView {
 
 override init(frame: CGRect) {
  super.init(frame: frame)
  commonInit()
 }
 
 required init?(coder: NSCoder) {
  fatalError("init(coder:) has not been implemented")
 }
 
 override func layoutSubviews() {
  super.layoutSubviews()
 }
 
 func createAnimation() {
  
  let someLayer = CALayer()
  
  layer.addSublayer(someLayer)
  someLayer.backgroundColor = UIColor.white.cgColor
  someLayer.anchorPoint = .init(x: 0.5, y: 0.5)
  someLayer.isGeometryFlipped = true
  someLayer.frame = .init(x: frame.width / 2, y: frame.height / 2, width: 0, height: 0)
  let newFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
  let newOpacity: Float = 0
  
  let items: [AnimationInfo] = [
   .init(
    key: #keyPath(CAShapeLayer.opacity),
    fromValue: 1,
    toValue: newOpacity)
   ,
   .init(
    key: #keyPath(CAShapeLayer.cornerRadius),
    fromValue: 0,
    toValue: frame.width / 2)
   ,
   .init(
    key: #keyPath(CAShapeLayer.bounds),
    fromValue: NSValue(cgRect: someLayer.bounds),
    toValue: NSValue(cgRect: newFrame)
   )
  ]
  
  someLayer.perfrormAnimation(items: items, timing: .default, duration: 2, fillMode: .forwards) {
   someLayer.opacity = newOpacity
   someLayer.bounds = newFrame
   someLayer.cornerRadius = frame.width / 2
  }  completion: {
   someLayer.removeFromSuperlayer()
  }
 }
 
 var timer: Timer?
 
 func createTimer() {
  self.timer?.invalidate()
    let timer = Timer.scheduledTimer(withTimeInterval: 1.1, repeats: true) {  [weak self] _ in
   self?.createAnimation()
  }
  
  self.timer = timer
 }
 
 func commonInit() {
  createTimer()
  
  
  
  
 }
}


extension CALayer {
 
 func perfrormAnimation(items: [AnimationInfo], timing: CAMediaTimingFunctionName, duration: TimeInterval, fillMode: CAMediaTimingFillMode, changeValuesClosure: () -> (), completion: (() -> ())? = nil) {
  let keys = items.map { $0.key }.joined(separator: "-")
  let group = CAAnimationGroup()
  group.animations = []
  group.timingFunction = CAMediaTimingFunction(name: timing)
  group.duration = duration
  group.fillMode = fillMode
  
  for animation in items {
   let selector = Selector(animation.key)
   if responds(to: selector) {
    let newAnimation = CABasicAnimation(keyPath: animation.key)
    newAnimation.fromValue = animation.fromValue
    newAnimation.toValue = animation.toValue
    group.animations?.append(newAnimation)
   }
  }
  
  changeValuesClosure()
  
  CATransaction.begin()
  CATransaction.setCompletionBlock(completion)
  add(group, forKey: keys)
  CATransaction.commit()
 }
}


struct AnimationInfo {
 let key: String
 let fromValue: Any?
 let toValue: Any?
}
