# GitHub Actions 云端编译（简体中文版）

## 使用方法

1. 在 GitHub 新建一个空仓库（建议设为 Public，以便遵循并展示 GPL-3.0 源码）。
2. 将本压缩包内 `airscreen-main` 文件夹中的**全部文件和隐藏文件**上传到仓库根目录。必须包含 `.github/workflows/build.yml`。
3. 打开仓库的 **Actions** 页面，启用 Actions。
4. 选择 **Build AirScreen 简体中文版**，点击 **Run workflow**。
5. 等待 Windows x64 编译完成，在该次运行页面底部的 **Artifacts** 下载 `AirScreen-简体中文版-Windows-x64`。

压缩包内的工作流会自动在 GitHub 托管的 Windows 环境安装 OpenSSL 和 Inno Setup，下载 FFmpeg，使用 MSVC 编译，并生成独立安装目录的中文安装程序。

## 自动发布 Release

需要发布正式版本时，在仓库根目录执行：

```bash
git tag v1.1.0-cn1
git push origin v1.1.0-cn1
```

推送 `v*-cn*` 标签会触发编译，并自动创建 GitHub Release，附上安装包和 SHA256 校验文件。也可以在网页的 **Releases → Create a new release** 创建同名标签。

## 注意

- 当前工作流构建 Windows x64，不构建 ARM64。
- 首次运行会下载 FFmpeg 依赖，耗时可能较长。
- 如果 Actions 报错，请把失败步骤的完整日志发来；尤其是 `Build AirScreen` 或 `Build Chinese installer`。
- 安装程序使用独立的 AppId 和安装目录 `AirScreen-简体中文版`，不会主动覆盖官方原版。
- 安装包未进行代码签名，Windows SmartScreen 可能显示提示。
