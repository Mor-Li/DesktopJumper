# DesktopJumper 设置指南

## 🎯 快捷键配置

本项目已为您配置了以下7个桌面切换快捷键：

- **Ctrl + K** → 第1个桌面（主桌面：聊天软件和日程安排）
- **Option + Space** → 第2个桌面（ChatGPT应用）
- **Ctrl + T** → 第3个桌面（本地Cursor）
- **Ctrl + P** → 第4个桌面（Zotero/Paper）
- **Ctrl + X** → 第5个桌面（音乐应用）
- **Ctrl + V** → 第6个桌面（VS Code）
- **Ctrl + E** → 第7个桌面（浏览器）

## ✅ 安装状态

1. ✅ 已安装 skhd
2. ✅ 已安装 yabai
3. ✅ 已安装 jq
4. ✅ 已创建 moonshot 分支
5. ✅ 已配置所有7个切换脚本
6. ✅ 已设置快捷键配置
7. ✅ 已启动 skhd 和 yabai 服务

## 🏗️ 工作原理

每个快捷键触发的脚本都会：
1. 检测当前显示器数量
2. 发送对应的 `Cmd+数字` 组合键
3. 实现桌面切换功能

## 📱 桌面布局建议

- **桌面 1**：主工作区（聊天软件如微信、钉钉，日程应用如Calendars）
- **桌面 2**：ChatGPT 应用
- **桌面 3**：本地开发环境（Cursor）
- **桌面 4**：文献管理（Zotero）
- **桌面 5**：娱乐（Apple Music/Spotify等）
- **桌面 6**：VS Code 开发
- **桌面 7**：网页浏览（Chrome/Safari等）

## 🔧 技术细节

### 前提条件
- macOS 已启用 `Cmd+1` 到 `Cmd+7` 的桌面切换快捷键
- skhd 和 yabai 服务正在运行
- 辅助功能权限已授予终端应用

### 服务状态检查
```bash
# 检查 skhd 状态
ps aux | grep skhd | grep -v grep

# 检查 yabai 状态
ps aux | grep yabai | grep -v grep
```

### 重启服务
如果快捷键不工作，尝试重启服务：
```bash
# 重启 skhd
pkill skhd
/opt/homebrew/bin/skhd --verbose &

# 重启 yabai
yabai --restart-service
```

## 🐛 故障排除

1. **快捷键不响应**：
   - 检查系统偏好设置中的Mission Control快捷键是否启用
   - 确认辅助功能权限

2. **脚本执行失败**：
   - 确认所有脚本文件有执行权限
   - 检查文件路径是否正确

3. **桌面切换无效**：
   - 确认目标桌面已创建
   - 手动测试 `Cmd+数字` 是否能正常切换

## 📝 自定义配置

要修改快捷键，编辑 `~/.skhdrc` 文件：
```bash
nano ~/.skhdrc
```

修改后重启 skhd 服务：
```bash
pkill skhd && /opt/homebrew/bin/skhd --verbose &
```

---

🎉 **现在就试试你的新桌面切换系统吧！** 