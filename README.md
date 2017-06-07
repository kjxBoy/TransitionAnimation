# TransitionAnimation
iOS8转场动画的实现

### 要实现自定义Modal转场
   1. 设置转场代理(返回UIPresentationController ，由该控制器负责 Modal 界面的处理)
   ```
     func setup() {
        // init
         self.modalPresentationStyle = UIModalPresentationStyle.custom
        //transition 转场，转成代理
         self.transitioningDelegate = newDelegate
    }
   ```
   2. 设置Modal的展现方式是自定义
### 使用
继承`ModelViewController`，自己写上相应的UI即可
