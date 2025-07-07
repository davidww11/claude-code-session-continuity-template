# Claude Code 会话连续性系统模板

*一套可复用的模板系统，让Claude Code在任何项目中都能保持会话连续性*

## 🎯 系统功能

### ✅ 会话启动自动化
- Claude启动时自动读取项目状态
- 快速了解历史决策和当前进展
- 避免重复询问已知信息

### ✅ 知识传承机制
- 系统性记录重要决策和背景
- 保存问题解决方案和最佳实践
- 建立项目知识库

### ✅ 自动化提醒
- Git提交时自动检查文档更新
- 智能识别需要记录的变更
- 减少文档遗漏

## 🚀 快速部署 (30秒设置)

### 方法1: 一键脚本 (推荐)
```bash
# 在你的新项目根目录下运行
curl -fsSL https://github.com/davidww11/claude-code-session-continuity-template/blob/master/deploy.sh | bash
```

### 方法2: 手动复制
```bash
# 1. 下载模板
git clone https://github.com/davidww11/claude-code-session-continuity-template.git
cd claude-code-session-continuity-template

# 2. 复制到你的项目
./setup.sh /path/to/your/project

# 3. 根据项目定制
cd /path/to/your/project
./docs/customize.sh
```

## 📁 文件结构

部署后，你的项目将获得以下文件结构：

```
your-project/
├── CLAUDE.md                    # 🤖 Claude启动指导文件
├── .githooks/                   # 🔧 Git自动化脚本
│   ├── pre-commit              # 提交前文档检查
│   └── setup.sh               # Hooks设置脚本
└── docs/                       # 📚 项目文档系统
    ├── README.md               # 文档导航中心
    ├── PROJECT_STATUS.md       # 项目当前状态
    ├── SESSION_HISTORY.md      # 会话历史记录
    ├── KNOWN_ISSUES.md         # 问题跟踪
    ├── QUICK_REFERENCE.md      # 快速参考
    ├── customize.sh           # 定制化脚本
    └── templates/             # 文档模板
        ├── session-template.md
        ├── issue-template.md
        └── decision-template.md
```

## ⚙️ 配置选项

### 项目复杂度选择
```bash
# 简单项目 (个人项目、原型)
./setup.sh --level=basic

# 标准项目 (团队项目、生产应用)  
./setup.sh --level=standard

# 复杂项目 (企业级、多团队)
./setup.sh --level=enterprise
```

### 项目类型适配
```bash
# Web应用项目
./setup.sh --type=web

# API/后端项目
./setup.sh --type=api

# 库/工具项目
./setup.sh --type=library

# 移动应用项目
./setup.sh --type=mobile
```

## 📋 使用流程

### 1. 新项目初始化
```bash
# 在新项目中设置会话连续性系统
curl -fsSL https://raw.githubusercontent.com/davidww11/claude-code-session-continuity-template/main/deploy.sh | bash
./docs/customize.sh --type=web --level=standard
git add . && git commit -m "feat: 添加Claude Code会话连续性系统"
```

### 2. 日常开发工作流

#### 启动新的Claude会话时：
1. Claude会自动读取 `CLAUDE.md` 获得项目指导
2. 按清单顺序阅读 `docs/` 中的状态文档
3. 快速了解项目当前状态和历史背景

#### 开发过程中：
1. 遇到问题先查 `docs/KNOWN_ISSUES.md`
2. 需要命令时查 `docs/QUICK_REFERENCE.md`
3. 做重要决策时记录到相应文档

#### 会话结束前：
1. Git提交时会自动提醒更新文档
2. 按模板更新 `docs/SESSION_HISTORY.md`
3. 更新项目状态到 `docs/PROJECT_STATUS.md`

### 3. 团队协作
```bash
# 团队成员首次使用
git clone project-repo
./docs/onboarding.sh  # 自动设置和介绍

# 项目交接
./docs/handover.sh    # 生成交接文档
```

## 🔧 定制化指南

### 修改项目信息
编辑 `docs/customize.sh` 中的配置：
```bash
PROJECT_NAME="Your Project Name"
PROJECT_TYPE="web"  # web/api/library/mobile
TECH_STACK="Next.js, React, TypeScript"
TEAM_SIZE="small"   # solo/small/large
```

### 添加项目特定模块
```bash
# 创建新的模块文档
cp docs/templates/module-template.md docs/modules/YOUR_MODULE.md
# 编辑并添加到 CLAUDE.md 的启动清单中
```

### 自定义Git Hooks
编辑 `.githooks/pre-commit` 添加项目特定的检查：
```bash
# 添加项目特定文件检查
SPECIFIC_FILES=$(git diff --cached --name-only | grep -E "(your-pattern)")
```

## 🎯 最佳实践

### ✅ 建议做的
- **及时更新**: 每次会话结束都更新文档
- **具体记录**: 记录决策的背景和原因，不只是结果
- **模板使用**: 使用提供的模板保持一致性
- **定期回顾**: 每周回顾和清理过时信息

### ❌ 避免做的
- **过度详细**: 不要记录每个小的代码更改
- **重复信息**: 避免在多个文档中重复相同信息
- **忽略更新**: 不要积累大量未记录的变更
- **格式混乱**: 保持文档格式的一致性

## 🔄 版本升级

### 检查模板更新
```bash
# 检查是否有新版本
./docs/check-updates.sh

# 升级到最新版本 (保留你的定制)
./docs/upgrade.sh
```

### 模板版本历史
- **v1.0**: 基础会话连续性系统
- **v1.1**: 添加项目类型适配
- **v1.2**: 增强Git Hooks和自动化
- **v1.3**: 添加团队协作功能

## 🤝 社区和支持

### 获取帮助
- **文档**: [完整文档站点](https://claude-continuity-docs.com)
- **问题报告**: [GitHub Issues](https://github.com/davidww11/claude-code-session-continuity-template/issues)
- **讨论**: [GitHub Discussions](https://github.com/davidww11/claude-code-session-continuity-template/discussions)

### 贡献指南
- 提交项目类型模板
- 改进自动化脚本
- 完善文档和示例
- 分享最佳实践

## 📊 效果评估

### 使用这个系统后，你将获得：
- ⏱️ **节省时间**: 新会话启动时间从15分钟减少到2分钟
- 🧠 **知识保留**: 重要决策和解决方案不再丢失
- 🔄 **连续性**: Claude能够无缝接续之前的工作
- 👥 **团队协作**: 团队成员可以快速了解项目状态

### 成功指标
- 新会话需要的上下文说明时间 < 2分钟
- 重复问题解决次数减少 > 80%
- 团队新成员上手时间减少 > 50%
- 项目知识遗失率 < 5%

---

**开始使用**: 运行 `curl -fsSL https://raw.githubusercontent.com/davidww11/claude-code-session-continuity-template/main/deploy.sh | bash` 在你的项目中设置会话连续性系统

**需要帮助**: 查看 [完整文档](https://claude-continuity-docs.com) 或 [联系支持](mailto:support@example.com)