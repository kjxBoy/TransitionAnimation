## 解决问题
以前时候在iOS界面上会出现一些弹出窗口的问题，弹出框往往会和弹出控制器耦合，或者实现复杂，iOS8引入新的转场动画，本例使用转场动画解决相关耦合、实现成本高等问题

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
