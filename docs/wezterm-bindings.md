# WezTerm 快捷键查询手册

本手册根据 `config/bindings.lua` 生成，按功能分组。不同平台修饰键含义如下：

- macOS: `SUPER` = Command，`SUPER_REV` = Command + Control
- Windows/Linux: `SUPER` = Alt，`SUPER_REV` = Alt + Control
- Leader: `Space` + `SUPER_REV`

## 杂项/常用
| 快捷键 | 说明 |
| --- | --- |
| F1 | 进入复制模式 |
| F2 | 打开命令面板 |
| F3 | 打开启动器 |
| F4 | 打开启动器（仅标签，模糊搜索） |
| F5 | 打开启动器（仅工作区，模糊搜索） |
| F11 | 切换全屏 |
| F12 | 打开调试信息 |
| SUPER + f | 搜索（区分大小写关闭） |
| SUPER_REV + u | 快速选择并打开 URL |

## 光标移动
| 快捷键 | 说明 |
| --- | --- |
| SUPER + 左方向键 | 发送 Home |
| SUPER + 右方向键 | 发送 End |
| SUPER + Backspace | 删除到行首 |

## 复制/粘贴
| 快捷键 | 说明 |
| --- | --- |
| Ctrl + Shift + c | 复制到剪贴板 |
| Ctrl + Shift + v | 从剪贴板粘贴 |

## 标签页
### 创建/关闭
| 快捷键 | 说明 |
| --- | --- |
| SUPER + t | 新建标签页（默认域） |
| SUPER_REV + t | 新建标签页（wsl:ubuntu-bash） |
| SUPER_REV + w | 关闭当前标签页（不确认） |

### 导航/移动
| 快捷键 | 说明 |
| --- | --- |
| SUPER + [ | 切换到左侧标签页 |
| SUPER + ] | 切换到右侧标签页 |
| SUPER_REV + [ | 向左移动当前标签页 |
| SUPER_REV + ] | 向右移动当前标签页 |

### 标题
| 快捷键 | 说明 |
| --- | --- |
| SUPER + 0 | 手动更新标签页标题 |
| SUPER_REV + 0 | 重置标签页标题 |

### 标签栏
| 快捷键 | 说明 |
| --- | --- |
| SUPER + 9 | 显示/隐藏标签栏 |

## 窗口
### 新建/缩放
| 快捷键 | 说明 |
| --- | --- |
| SUPER + n | 新建窗口 |
| SUPER + - | 缩小窗口（宽高各 -50px） |
| SUPER + = | 放大窗口（宽高各 +50px） |
| SUPER_REV + Enter | 最大化窗口 |

## 背景控制
| 快捷键 | 说明 |
| --- | --- |
| SUPER + / | 随机背景 |
| SUPER + , | 切换到上一张背景 |
| SUPER + . | 切换到下一张背景 |
| SUPER_REV + / | 选择背景（列表/模糊搜索） |
| SUPER + b | 切换背景聚焦效果 |

## 分屏（Pane）
### 拆分/关闭/缩放
| 快捷键 | 说明 |
| --- | --- |
| SUPER + \ | 垂直分屏 |
| SUPER_REV + \ | 水平分屏 |
| SUPER + Enter | 缩放当前分屏 |
| SUPER + w | 关闭当前分屏（不确认） |

### 切换/选择
| 快捷键 | 说明 |
| --- | --- |
| SUPER_REV + k | 切换到上方分屏 |
| SUPER_REV + j | 切换到下方分屏 |
| SUPER_REV + h | 切换到左侧分屏 |
| SUPER_REV + l | 切换到右侧分屏 |
| SUPER_REV + p | 分屏选择（1-0）并交换 |

### 滚动
| 快捷键 | 说明 |
| --- | --- |
| SUPER + u | 上滚 5 行 |
| SUPER + d | 下滚 5 行 |
| PageUp | 上滚 0.75 页 |
| PageDown | 下滚 0.75 页 |

## Leader 键表
### 调整字体（Leader + f）
| 按键 | 说明 |
| --- | --- |
| k | 增大字体 |
| j | 减小字体 |
| r | 重置字体 |
| Escape / q | 退出键表 |

### 调整分屏大小（Leader + p）
| 按键 | 说明 |
| --- | --- |
| k | 向上调整 1 单位 |
| j | 向下调整 1 单位 |
| h | 向左调整 1 单位 |
| l | 向右调整 1 单位 |
| Escape / q | 退出键表 |

## 鼠标
| 操作 | 说明 |
| --- | --- |
| Ctrl + 左键单击 | 打开鼠标下的链接 |
