# weekend
a animation view like week app.Enjoy it!!!

----

##来源
该动效其实是仿照**weekend**点击菜单跳转。但是当前的动效没有完全实现了**weekend**的动画，还有一小部分，但是也是不难的。

##思路解析

工程中主要包含了两部分。

 * 一个是**自定义转场动画**。在**转场动画**中，只是简单地对视图的透明度以及位置做了一个简单的动画。
* 一个是**tableview滑动动画**。用了一个**imageView**在底部，一个**visualEffectView**(iOS8以上)，一个**tableView**在顶部。根据**tableView**的滑动位置分段式设置**tableView**的**contentSize** *、**imageView**的**frame**按比例放大，**visualEffectView**的**frame**按比例放大。

##最佳实践之处

 * 工程中最佳实践的地方就是在接收到滑动手势事件之后根据当前**tableView**的位置更改**tableView**最终的**停止位置**

**代码如下**:

	- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (self.yOffset > (-320.0 + 64)) {
        targetContentOffset->x = 0.0f;
        if (targetContentOffset->y >= (-400.0f+64) && targetContentOffset->y <= (-320.0 + 64)) {
            targetContentOffset->y = -320.0f + 64;
        }
    }
}

##总结
之前对这个APP没有进行足够的分析，导致走了一些弯路。但是在这个弯路过程只用也学习到了很多的知识点，太棒了~以后，需要“破解”一些复杂的图层动画的时候，可以先使用工具将其拆分之后再搞，这样可以避免通过肉眼分析不准确的问题。

---

![](https://github.com/zhaiyjgithub/weekend/raw/master/week.gif)  


	

