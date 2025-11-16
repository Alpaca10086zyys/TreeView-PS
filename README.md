# TreeView.ps1 — A Modern Tree Command for Windows 🌲

A better tree for Windows — supports depth (-Depth), icons (-IconMode), and Unicode tree characters.

## ✨ Features

-Depth depth control (tree on Windows does not support this)

-IconMode shows file type icons (📁 🎬 🧱 🖼)

Clean Unicode tree drawing (├──, └──, │)

Works on any Windows PowerShell or PowerShell 7

## 🚀 Installation

### Option 1 — Install from PowerShell Gallery（Recommend）

```sh
Install-Script TreeView
```

### Option 2 — Clone from GitHub

```sh
git clone https://github.com/Alpaca1008zyys/TreeView-PS
cd TreeView-PS
.\TreeView.ps1 -Depth 2
```

## 📘 Usage

```sh
treeview -Path . -Depth 3 -IconMode
```

output-example：

📁 src
├── 📁 assets
├── 📄 index.js
└── 🎬 demo.mp4

## 📄 License

MIT License.
