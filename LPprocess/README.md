# LPprocess

基于 draw.io desktop 32.5.5 的换壳定制版：改名 LPprocess，开发者信息 LPITS，其余功能与原版一致。

## 定制内容（相对原版 32.5.5）

**品牌**
- `package.json`：name → `lpprocess`，productName `LPprocess`，author → `LPITS`，仓库地址指向 Rabbrtf/lpprocess
- `electron-builder-win.json`：appId → `com.lpits.lpprocess`，copyright → `Copyright 2026 LPITS`，文件关联名"LPprocess Diagram"
- 图标：`build/` 下全部替换为 LP 深蓝圆角方 + 白色"LP"字（`.b64`）
- `drawio/src/main/webapp/images/logo.png`：换 LP logo（`.b64`）
- `drawio/src/main/webapp/index.html`：标题 → LPprocess
- 59 个语言资源：`draw.io=draw.io` → `draw.io=LPprocess`（`apply-branding.sh` 自动处理）

**功能调整**
- 禁用自动更新：`src/main/disableUpdate.js` 返回 true
- 帮助菜单隐藏：升级（检查更新）、访问官网、Support、开发者工具入口（`app.min.js.patch`）
- 帮助菜单新增"开发团队"：点击弹 `LPITS`（action `devTeam`，`apply-branding.sh` 加资源字符串）
- About 对话框：标题 LPprocess，删除 jgraph.com 链接（`app.min.js.patch`）
- Mac 应用菜单：删除 About / Support 项（`electron.js.patch`）

**未动的部分**
- 文件菜单、退出、打印、另存为、导出等全部为原版逻辑

## 目录说明

- `drawio-desktop/`：改动文件（保持原版相对路径）
  - 普通文件：直接覆盖到纯净源码对应位置
  - `*.patch`：用 `patch -p1` 打到纯净源码（在仓库根目录执行）
  - `*.b64`：二进制文件的 base64 文本，用 `restore.sh` 还原
  - `apply-branding.sh`：语言资源品牌替换脚本

## 还原与构建

```bash
# 1. 取纯净 draw.io desktop 32.5.5 源码（jgraph/drawio-desktop，drawio 子模块 32.5.5）
# 2. 覆盖普通文件（package.json、electron-builder-win.json、src/main/disableUpdate.js、
#    drawio/src/main/webapp/index.html）
# 3. 打补丁（在源码根目录）：
patch -p1 < LPprocess/drawio-desktop/drawio/src/main/webapp/js/app.min.js.patch
patch -p1 < LPprocess/drawio-desktop/src/main/electron.js.patch
# 4. 跑品牌脚本：
bash LPprocess/drawio-desktop/apply-branding.sh
# 5. 还原二进制：
bash LPprocess/restore.sh
# 6. 安装依赖并打包 Windows 便携版：
npm install
npx electron-builder --win --config electron-builder-win.json --publish never
# 注：Linux 下打 Windows 包需把 electron-builder-win.json 里 win.target 临时改为 dir（无 wine 时）
```

> 二进制资源以 `.b64` 文本存放：仓库 API 通道不支持二进制直传，base64 内容无损，用 `restore.sh` 还原。
