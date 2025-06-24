# 📱 账单记录应用 (BillingRecord)

一个简洁易用的个人财务管理 iOS 应用，帮助您轻松记录和管理日常收支情况。

## ✨ 功能特性

### 💰 核心功能
- **添加交易记录** - 支持收入和支出两种类型
- **实时余额计算** - 自动计算和显示当前总余额
- **交易历史查看** - 按时间倒序显示所有交易记录
- **删除记录** - 支持滑动删除不需要的交易记录

### 🎨 界面设计
- **现代化 UI** - 采用 SwiftUI 打造的原生界面
- **直观的视觉反馈** - 收入显示绿色，支出显示红色
- **清晰的信息展示** - 每笔交易包含金额、描述、日期和类型
- **空状态提示** - 友好的引导信息帮助用户快速上手

### 📊 数据管理
- **本地存储** - 所有数据保存在设备本地，保护隐私
- **实时更新** - 添加或删除记录后立即更新余额显示
- **数据验证** - 确保输入的金额格式正确且大于零

## 🛠 技术栈

- **开发语言**: Swift
- **UI 框架**: SwiftUI
- **最低系统要求**: iOS 14.0+
- **开发工具**: Xcode 12.0+

## 📋 系统要求

- iOS 14.0 或更高版本
- iPhone 设备
- 大约 10MB 存储空间

## 🚀 安装和运行

### 前置要求
- macOS 10.15.4 或更高版本
- Xcode 12.0 或更高版本
- iOS 14.0+ 的 iPhone 设备或模拟器

### 安装步骤

1. **克隆仓库**
   ```bash
   git clone https://github.com/yourusername/BillingRecord.git
   cd BillingRecord
   ```

2. **打开项目**
   ```bash
   open BillingRecord.xcodeproj
   ```

3. **运行应用**
   - 在 Xcode 中选择目标设备或模拟器
   - 点击运行按钮 (⌘+R) 或选择 Product → Run

## 📱 使用指南

### 添加交易记录

1. 点击主界面右上角的 **+** 按钮
2. 选择交易类型：
   - **收入** - 工资、奖金、投资收益等
   - **支出** - 购物、餐饮、交通等费用
3. 输入交易金额（必填）
4. 添加备注信息（可选）
5. 点击 **保存** 完成添加

### 查看交易记录

- 主界面显示所有交易记录，按时间倒序排列
- 每条记录显示：
  - 📊 交易类型图标和颜色
  - 💬 交易描述
  - 📅 交易日期
  - 💰 交易金额
  - 🏷 交易类型标签

### 删除交易记录

1. 在交易记录列表中找到要删除的记录
2. 向左滑动该记录
3. 点击红色的 **删除** 按钮确认

### 查看余额

- 主界面顶部显示当前总余额
- 余额为正数时显示绿色
- 余额为负数时显示红色
- 余额会随着交易记录的增删自动更新

## 📁 项目结构

```
BillingRecord/
├── BillingRecord/
│   ├── BillingRecordApp.swift    # 应用入口
│   ├── ContentView.swift         # 主界面视图
│   ├── Assets.xcassets/          # 应用资源
│   └── Preview Content/          # 预览资源
├── BillingRecord.xcodeproj/      # Xcode 项目文件
├── README.md                     # 项目说明文档
└── .gitignore                    # Git 忽略文件配置
```

## 🎯 核心代码说明

### 数据模型

```swift
// 交易类型枚举
enum TransactionType: String, CaseIterable, Hashable {
    case income = "收入"
    case expense = "支出"
}

// 交易数据模型
struct Transaction: Identifiable {
    let id = UUID()
    let type: TransactionType
    let amount: Double
    let description: String
    let date: Date
}
```

### 主要组件

- **ContentView** - 主界面，包含余额显示和交易列表
- **AddTransactionView** - 添加交易的弹窗界面
- **TransactionRow** - 单个交易记录的显示组件

## 🔄 版本历史

### v1.0.0 (当前版本)
- ✅ 基础交易记录功能
- ✅ 收入和支出分类管理
- ✅ 实时余额计算
- ✅ 交易记录的增删操作
- ✅ 现代化 SwiftUI 界面

## 🤝 贡献指南

欢迎为项目做出贡献！请遵循以下步骤：

1. Fork 项目仓库
2. 创建您的功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 📝 待办事项

- [ ] 数据持久化存储
- [ ] 交易分类标签
- [ ] 统计图表功能
- [ ] 数据导出功能
- [ ] 深色模式支持
- [ ] iPad 适配
- [ ] 国际化支持

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 联系方式

如果您有任何问题或建议，欢迎通过以下方式联系：

- 📧 邮箱: your.email@example.com
- 🐙 GitHub: [@yourusername](https://github.com/yourusername)

## 🙏 致谢

感谢所有为这个项目做出贡献的开发者！

---

**⭐ 如果这个项目对您有帮助，请给个 Star 支持一下！** 