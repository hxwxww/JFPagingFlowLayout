# JFPagingFlowLayout
A subclass of UICollectionViewFlowLayout with paging effect

## Screenshot

![image](https://github.com/hxwxww/JFPagingFlowLayout/raw/master/screenshot/screenshot.jpg)


## 用法

```
let layout = JFPagingFlowLayout()
collectionView.collectionViewLayout = layout

layout.pagingStyle = .leadingBoundary(spacing: LayoutSize.spacing / 2)
```

更具体的用法请下载 Demo 查看。
