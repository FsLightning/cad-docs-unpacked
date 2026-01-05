# cad-docs-unpacked

[English](#english) | [中文](#中文)

---

## English

### 📚 AI-Friendly CAD Documentation Repository

Unpacked HTML API references for AutoCAD & ZWCAD (.NET/ARX/LISP), optimized for LLM context ingestion and RAG knowledge base construction.

Traditional CHM (Compiled HTML Help) files are difficult for modern AI tools to read directly. This repository aims to solve that problem by providing unpacked, accessible documentation.

### 🎯 Purpose

1. **AI-Friendly**: Provide plain text/HTML corpus for LLM (Large Language Model) training or fine-tuning domain-specific programming assistants.
2. **RAG Knowledge Base**: Serve as source data for RAG (Retrieval-Augmented Generation) systems to build "CAD Expert" Q&A systems.
3. **Full-Text Search**: Enable more powerful code-level search through Git management, superior to CHM's native search capabilities.

### 📦 Contents

- **AutoCAD**:
  - .NET Developer's Guide
  - ObjectARX Reference
  - AutoLISP Reference
- **ZWCAD**:
  - .NET API Reference
  - ZRX SDK Help

*(This list will be updated dynamically as more content is added)*

### 📄 Format

All documents have been **decompiled** from CHM containers, preserving the original directory structure and HTML content. This makes them ready for:
- Data cleaning
- Vectorization (embedding)
- Integration into AI/ML pipelines
- Full-text indexing

### 🚀 Usage

#### For AI/ML Projects

1. **Clone the repository**:
   ```bash
   git clone https://github.com/FsLightning/cad-docs-unpacked.git
   ```

2. **Use for RAG systems**: Point your document loader to the unpacked HTML files
3. **Use for training**: Process the HTML content for LLM fine-tuning
4. **Use for search**: Leverage Git's powerful search capabilities across all documentation

#### For Manual Reference

Browse the HTML files directly in your web browser or use your preferred text editor to search across the documentation.

### 🤝 Contributing

Contributions are welcome! If you have additional CAD documentation in CHM format that you'd like to see unpacked, please:
1. Open an issue describing the documentation
2. Submit a pull request with the unpacked content (maintaining the original structure)

### 📜 License

This project is released into the public domain under the [Unlicense](LICENSE).

**Note**: The unpacked documentation content remains subject to the original licenses from Autodesk, ZWSOFT, and other respective copyright holders. This repository only provides the unpacked format for easier access and does not claim ownership of the documentation content.

---

## 中文

### 📚 AI 友好的 CAD 文档仓库

解压后的 AutoCAD & ZWCAD HTML API 参考文档（.NET/ARX/LISP），为 LLM 上下文摄取和 RAG 知识库构建优化。

传统的 CHM（编译帮助文件）文件难以被现代 AI 工具直接读取。建立此仓库的目的是解决这个问题，提供解压后的、可访问的文档。

### 🎯 目的

1. **AI 友好**：为 LLM（大语言模型）提供纯文本/HTML 语料，用于训练或微调垂直领域的编程助手。
2. **RAG 知识库**：作为 RAG（检索增强生成）系统的源数据，方便构建"CAD 开发专家"问答系统。
3. **全文检索**：通过 Git 管理，实现比 CHM 原生搜索更强大的代码级搜索。

### 📦 包含内容

- **AutoCAD**:
  - .NET Developer's Guide（.NET 开发者指南）
  - ObjectARX Reference（ObjectARX 参考）
  - AutoLISP Reference（AutoLISP 参考）
- **ZWCAD**:
  - .NET API Reference（.NET API 参考）
  - ZRX SDK Help（ZRX SDK 帮助）

*（此处可根据实际上传内容动态更新）*

### 📄 格式说明

所有文档均已从 CHM 容器中**解压**（Decompiled），保留了原始的目录结构和 HTML 内容，方便进行：
- 数据清洗（Data Cleaning）
- 向量化（Embedding）
- 集成到 AI/ML 管道
- 全文索引

### 🚀 使用方法

#### 用于 AI/ML 项目

1. **克隆仓库**：
   ```bash
   git clone https://github.com/FsLightning/cad-docs-unpacked.git
   ```

2. **用于 RAG 系统**：将文档加载器指向解压的 HTML 文件
3. **用于训练**：处理 HTML 内容用于 LLM 微调
4. **用于搜索**：利用 Git 的强大搜索功能检索所有文档

#### 用于手动参考

直接在 Web 浏览器中浏览 HTML 文件，或使用您喜欢的文本编辑器搜索文档。

### 🤝 贡献

欢迎贡献！如果您有其他 CHM 格式的 CAD 文档希望被解压，请：
1. 开启一个 issue 描述该文档
2. 提交包含解压内容的 pull request（保持原始结构）

### 📜 许可证

本项目使用 [Unlicense](LICENSE) 发布到公共领域。

**注意**：解压的文档内容仍受 Autodesk、中望软件及其他相应版权持有者的原始许可证约束。本仓库仅提供解压格式以便于访问，不声明对文档内容的所有权。
