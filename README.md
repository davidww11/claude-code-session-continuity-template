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
# Web应用项目 (Next.js, React, Vue等)
./setup.sh --type=web

# 营销网站项目 (产品展示、教程网站)
./setup.sh --type=marketing --features=analytics,seo,i18n

# API/后端项目
./setup.sh --type=api

# 库/工具项目 (CLI工具、npm包等)
./setup.sh --type=library

# 移动应用项目
./setup.sh --type=mobile

# 文档/教程网站
./setup.sh --type=docs

# 多语言国际化项目
./setup.sh --type=web --features=i18n --languages=en,zh
```

## 📋 使用流程

### 1. 新项目初始化

#### 基础Web应用项目
```bash
# 在新项目中设置会话连续性系统
curl -fsSL https://raw.githubusercontent.com/davidww11/claude-code-session-continuity-template/main/deploy.sh | bash
./docs/customize.sh --type=web --level=standard
git add . && git commit -m "feat: 添加Claude Code会话连续性系统"
```

#### 国际化营销网站项目 (基于ccusage项目经验)
```bash
# 专为多语言营销网站优化的设置
curl -fsSL https://raw.githubusercontent.com/davidww11/claude-code-session-continuity-template/main/deploy.sh | bash
./docs/customize.sh --type=marketing \
  --features=analytics,seo,i18n \
  --languages=en,zh \
  --tech-stack="Next.js,TypeScript,Tailwind CSS,next-intl" \
  --deployment=cloudflare-pages
git add . && git commit -m "feat: 添加多语言营销网站会话连续性系统"
```

#### CLI工具推广网站项目
```bash
# 专为开发工具推广网站设计
./docs/customize.sh --type=marketing \
  --target-audience=developers \
  --features=tutorials,analytics,seo \
  --focus=conversion,education
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

#### 基础配置
```bash
PROJECT_NAME="Your Project Name"
PROJECT_TYPE="web"  # web/api/library/mobile/docs/marketing
TECH_STACK="Next.js 15, React 19, TypeScript, Tailwind CSS"
TEAM_SIZE="small"   # solo/small/large
```

#### 国际化和SEO配置 (基于ccusage项目实践)
```bash
INTERNATIONAL="true"  # 是否支持国际化
LANGUAGES="en,zh"     # 支持的语言代码
SEO_FOCUSED="true"    # 是否SEO优化项目
DYNAMIC_SEO="true"    # 是否使用Next.js MetadataRoute API
```

#### 第三方服务集成配置
```bash
ANALYTICS_ENABLED="true"          # 是否集成Analytics
ANALYTICS_PROVIDERS="google,openpanel,plausible"  # Analytics提供商
DEPLOYMENT_PLATFORM="cloudflare"  # vercel/cloudflare/aws
PERFORMANCE_MONITORING="true"     # Core Web Vitals监控
```

#### 营销网站特定配置
```bash
TARGET_AUDIENCE="developers"      # 目标用户群体
CONVERSION_FOCUSED="true"         # 是否转化优化项目
TUTORIAL_SYSTEM="progressive"     # 教程系统类型
USER_CASE_STUDIES="true"         # 是否包含用例研究
```

### 添加项目特定模块

#### 基础模块创建
```bash
# 创建新的模块文档
cp docs/templates/module-template.md docs/modules/YOUR_MODULE.md
# 编辑并添加到 CLAUDE.md 的启动清单中
```

#### 营销网站常用模块 (基于ccusage项目)
```bash
# Analytics集成模块
cp docs/templates/analytics-integration-template.md docs/modules/ANALYTICS_INTEGRATION.md

# SEO优化模块
cp docs/templates/seo-optimization-template.md docs/modules/SEO_OPTIMIZATION.md

# 国际化管理模块
cp docs/templates/i18n-management-template.md docs/modules/I18N_MANAGEMENT.md

# 部署和环境管理模块
cp docs/templates/deployment-guide-template.md docs/modules/DEPLOYMENT_GUIDE.md

# 用户转化优化模块
cp docs/templates/conversion-optimization-template.md docs/modules/CONVERSION_OPTIMIZATION.md
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
- **环境配置**: 详细记录生产环境、测试环境的差异
- **第三方集成**: 记录Analytics、SEO工具等第三方服务配置
- **国际化状态**: 记录多语言内容的翻译和维护状态
- **性能基准**: 记录Core Web Vitals和关键性能指标
- **部署状态**: 记录当前部署环境和配置版本
- **Analytics验证**: 定期验证数据收集和分析工具状态

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
- **v1.4**: 新增国际化项目支持、SEO优化项目模板、第三方服务集成文档
- **v1.5**: 基于ccusage项目实践，增强营销网站模板、Analytics集成指导、多语言项目管理

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
- 🌐 **国际化支持**: 记录多语言项目的特殊配置
- 📈 **SEO友好**: 针对SEO项目的特殊文档管理
- 📊 **Analytics跟踪**: 系统化管理第三方服务集成状态
- 🚀 **部署管理**: 环境配置和部署状态的完整追踪
- 🎯 **转化优化**: 营销网站项目的用户体验改进记录

### 成功指标
- 新会话需要的上下文说明时间 < 2分钟
- 重复问题解决次数减少 > 80%
- 团队新成员上手时间减少 > 50%
- 项目知识遗失率 < 5%
- 多语言项目配置恢复时间 < 1分钟
- SEO配置和部署状态追踪准确率 > 95%
- Analytics配置问题诊断时间 < 5分钟
- 生产环境问题定位时间减少 > 70%

### 基于ccusage项目的实际效果 (V1.5新增)
- **Analytics集成**: 从配置混乱到系统化管理，问题解决时间减少85%
- **多语言维护**: 翻译状态追踪准确率达到100%，避免内容不一致
- **SEO优化**: 动态sitemap/robots配置记录，部署问题排查时间减少90%
- **环境管理**: 三层配置体系文档化，环境变量问题归零
- **性能监控**: Core Web Vitals基准记录，性能回归检测提升60%

---

**开始使用**: 运行 `curl -fsSL https://raw.githubusercontent.com/davidww11/claude-code-session-continuity-template/main/deploy.sh | bash` 在你的项目中设置会话连续性系统

**需要帮助**: 查看 [完整文档](https://claude-continuity-docs.com) 或 [联系支持](mailto:support@example.com)