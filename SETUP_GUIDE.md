# DesktopJumper 设置指南

## 快捷键配置

本项目已为您配置了以下桌面切换快捷键：

- **Ctrl + E** → 第一个桌面（浏览器）
- **Ctrl + T** → 第二个桌面
- **Option + Space** → 第三个桌面（ChatGPT）
- **Ctrl + M** → 第四个桌面（音乐应用）

## 安装步骤

1. ✅ 已安装 skhd
2. ✅ 已创建 moonshot 分支
3. ✅ 已配置所有脚本
4. ✅ 已设置快捷键配置
5. ✅ 已启动 skhd 服务

## 使用说明

### 桌面布局建议

- **桌面 1**：放置浏览器应用（Chrome/Safari等）
- **桌面 2**：用于一般工作或终端
- **桌面 3**：放置 ChatGPT 应用
- **桌面 4**：放置音乐应用（Apple Music/Spotify等）

### 注意事项

1. 首次使用前，请确保 macOS 已授予相关权限：
   - 系统偏好设置 → 安全性与隐私 → 辅助功能
   - 添加并启用终端应用

2. 如果快捷键不生效，请检查：
   ```bash
   # 检查 skhd 服务状态
   brew services list | grep skhd
   
   # 重启 skhd 服务
   skhd --restart-service
   ```

3. 调试模式（可选）：
   ```bash
   # 停止后台服务
   pkill skhd
   # 前台运行查看日志
   skhd &
   ```

## 自定义配置

如需修改快捷键，编辑 `~/.skhdrc` 文件：

```bash
nano ~/.skhdrc
```

修改后重启 skhd 服务：
```bash
skhd --restart-service
```

## 依赖项

- `yabai`：窗口管理器（需单独安装）
- `jq`：JSON 处理工具（需单独安装）
- `skhd`：✅ 已安装

## 故障排除

如果遇到问题，请检查：
1. 脚本是否有执行权限
2. 路径是否正确
3. macOS 权限设置
4. skhd 服务是否正常运行 