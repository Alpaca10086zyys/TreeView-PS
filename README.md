# 🌲 TreeView — 现代化的 Windows PowerShell 目录树工具

**TreeView** 是一个为 Windows PowerShell / PowerShell 7 打造的现代化 `tree` 命令替代品。
它支持深度控制、文件图标、彩色输出、Unicode 树形结构——完全补全了原生 Windows tree 的缺陷。

---

## ✨ 特点（为什么选择 TreeView）

### • 自定义深度（`-Depth` / `-L`）

原生 Windows `tree` 不支持深度限制，本工具提供完整深度控制，与 Linux `tree` 对齐。

### • 文件/目录图标（`-Icon`）

根据文件类型显示 📁 📄 🖼️ 🎬 等 emoji 图标（可关闭）。

### • Unicode 树结构字符

使用优雅的 `├──`、`└──`、`│`，呈现更清晰的树状结构。

### • 彩色输出（`-C`）

可选启用，用颜色区分文件与目录。

### • 跨版本支持

支持 **Windows PowerShell 5.1** 与 **PowerShell 7+**。

---

## 📦 安装（开箱即用！）

### 方法 1 — PowerShell Gallery（推荐）

```powershell
Install-Module -Name TreeView -Scope CurrentUser -Force
```

验证安装：

```powershell
Get-Module -ListAvailable TreeView | Select-Object Name, Version, Path
```

安装后可直接使用：

```powershell
treeview
```

如果控制台报：

```text
treeview :在模块“TreeView"中找到“treeview”命令，但无法加载该模块。有关详细信息，请运行“Import-Module Treeview”
```

则需要引入一下模块：

```ps
Import-Module Treeview
```

---

### 方法 2 — 从 GitHub 克隆（不推荐）

```powershell
git clone https://github.com/Alpaca1008zyys/TreeView-PS
cd TreeView-PS
.\TreeView.ps1 -L 2
```

---

## 📘 用法指南

### 最简单的用法

```powershell
treeview
```

### 指定路径、深度、图标

```powershell
treeview -Path . -L 3 -Icon
```

### 显示完整路径

```powershell
treeview -f
```

### 仅显示目录

```powershell
treeview -d
```

### 启用彩色输出

```powershell
treeview -C
```

### 显示所有项（包括隐藏项）

```powershell
treeview -a
```

### 使用简写

```powershell
tr
```

---

## 📝 输出示例

```txt
📁 src
├── 📁 assets
├── 📄 index.js
└── 🎬 demo.mp4
```

---

## 🔧 参数速览

| 参数              | 缩写   | 描述                           |
| --------------- | ---- | ---------------------------- |
| `-Path`         |      | 要显示的目录，默认当前目录                |
| `-Depth` / `-L` | `-L` | 显示目录深度                       |
| `-Icon`         |      | 显示文件类型 emoji 图标              |
| `-a`            |      | 显示隐藏文件（与 Linux `tree -a` 对齐） |
| `-f`            |      | 显示完整路径                       |
| `-d`            |      | 仅显示目录                        |
| `-C`            |      | 启用彩色输出                       |

---

## 📄 License

MIT License © 2025 Alpaca1008zyys
欢迎提交 issue 或 PR！

---

---

# 🌲 TreeView — A Modern Tree Command for Windows PowerShell

**TreeView** is a modern replacement for the classic `tree` command in Windows PowerShell / PowerShell 7.
It adds depth control, file icons, color output, and clean Unicode tree characters — fully addressing the limitations of the native Windows tree command.

---

## ✨ Features (Why TreeView)

### • Depth Control (`-Depth` / `-L`)

The native Windows `tree` command does not support depth limiting. TreeView adds full depth control consistent with Linux `tree`.

### • File & Folder Icons (`-Icon`)

Displays emoji icons such as 📁 📄 🖼️ 🎬 based on file types (optional).

### • Unicode Tree Characters

Cleaner structure using `├──`, `└──`, `│`.

### • Color Output (`-C`)

Optional colored view to distinguish folders and files.

### • Cross-Version Support

Compatible with **Windows PowerShell 5.1** and **PowerShell 7+**.

---

## 📦 Installation

### Method 1 — PowerShell Gallery (Recommended)

```powershell
Install-Module -Name TreeView -Scope CurrentUser -Force
```

Verify the installation:

```powershell
Get-Module -ListAvailable TreeView | Select-Object Name, Version, Path
```

Start using it:

```powershell
treeview
```

---

### Method 2 — Clone from GitHub (Not Recommended)

```powershell
git clone https://github.com/Alpaca1008zyys/TreeView-PS
cd TreeView-PS
.\TreeView.ps1 -L 2
```

---

## 📘 Usage Guide

### Basic:

```powershell
treeview
```

### With path, depth, and icons:

```powershell
treeview -Path . -L 3 -Icon
```

### Show full path:

```powershell
treeview -f
```

### Directories only:

```powershell
treeview -d
```

### Enable color:

```powershell
treeview -C
```

### Show all files including hidden:

```powershell
treeview -a
```

### Short alias:

```powershell
tr
```

---

## 📝 Output Example

```txt
📁 src
├── 📁 assets
├── 📄 index.js
└── 🎬 demo.mp4
```

---

## 🔧 Parameter Overview

| Parameter       | Alias | Description                     |
| --------------- | ----- | ------------------------------- |
| `-Path`         |       | Target directory (default: pwd) |
| `-Depth` / `-L` | `-L`  | Limit display depth             |
| `-Icon`         |       | Show emoji file-type icons      |
| `-a`            |       | Include hidden files            |
| `-f`            |       | Show full absolute path         |
| `-d`            |       | Directories only                |
| `-C`            |       | Enable colored output           |

---

## 📄 License

MIT License © 2025 Alpaca1008zyys
Issues and PRs are welcome!

---
