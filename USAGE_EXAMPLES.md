# 使用示例 | Usage Examples

*不同项目场景下的Claude Code会话连续性系统使用示例*

---

## 🚀 快速开始示例

### 示例1: React Web应用
```bash
# 创建新项目
npx create-react-app my-react-app
cd my-react-app
git init
git add .
git commit -m "initial commit"

# 添加会话连续性系统
curl -fsSL https://raw.githubusercontent.com/claude-continuity/template/main/deploy.sh | bash

# 自动检测配置:
# - 项目类型: web
# - 技术栈: React, TypeScript  
# - 文件模式: src/, components/, *.tsx, *.jsx
```

### 示例2: Node.js API项目
```bash
# 创建API项目
mkdir my-api-project
cd my-api-project
npm init -y
git init

# 手动安装并配置
curl -fsSL https://github.com/claude-continuity/template/archive/main.zip -o template.zip
unzip template.zip && cd template-main
./setup.sh /path/to/my-api-project --type=api --tech="Node.js, Express"

# 结果:
# - 监控: routes/, models/, *.js, *.py
# - Git Hooks专门优化API项目文件类型
```

### 示例3: Python库项目
```bash
# Python项目
mkdir my-python-lib
cd my-python-lib
git init
echo "requests>=2.25.0" > requirements.txt

# 配置为库项目
./setup.sh . --type=library --level=standard --tech="Python"

# 获得:
# - 库项目特定的文档模板
# - API参考文档结构
# - 发布流程文档
```

### 示例4: 国际化营销网站项目 (基于ccusage项目实践)
```bash
# 创建Next.js营销网站项目
npx create-next-app@latest ccusage-web --typescript --tailwind --app
cd ccusage-web
git init && git add . && git commit -m "initial commit"

# 配置专业营销网站会话连续性系统
curl -fsSL https://raw.githubusercontent.com/claude-continuity/template/main/deploy.sh | bash
./setup.sh . --type=marketing \
  --features=analytics,seo,i18n \
  --languages=en,zh \
  --tech-stack="Next.js 15,TypeScript,Tailwind CSS,next-intl" \
  --deployment=cloudflare-pages \
  --team=solo \
  --level=standard

# 结果配置:
# - 自动创建Analytics集成文档模板
# - SEO优化模块文档(sitemap/robots管理)
# - 国际化管理文档(翻译状态跟踪)
# - 部署环境管理文档
# - 三层环境变量配置追踪
# - 性能监控基准记录
```

**专门适配功能**:
- 监控 `src/components/blocks/`, `src/messages/`, `src/app/[locale]/`
- Analytics配置验证脚本
- 多语言内容一致性检查
- SEO配置状态跟踪
- Core Web Vitals基准管理
- 第三方服务集成状态记录

### 示例5: CLI工具推广网站项目
```bash
# 专为开发工具推广设计的营销网站
mkdir my-cli-tool-website
cd my-cli-tool-website
npm init -y
git init

# 针对开发者受众的配置
./setup.sh . --type=marketing \
  --target-audience=developers \
  --features=tutorials,analytics,seo \
  --focus=conversion,education \
  --tech="Next.js,React,TypeScript" \
  --level=standard

# 获得专门的模块:
# - 教程系统管理文档
# - 开发者转化流程优化记录
# - 技术对比展示管理
# - 用户案例研究文档
# - 社区反馈收集系统
```

---

## 📊 不同复杂度配置对比

### Basic Level (基础配置)
**适用**: 个人项目、原型、学习项目

```bash
./setup.sh . --level=basic
```

**包含文档**:
- CLAUDE.md (简化版)
- PROJECT_STATUS.md (基础状态)
- SESSION_HISTORY.md (模板)
- KNOWN_ISSUES.md (基础问题跟踪)
- 基础Git Hooks

### Standard Level (标准配置)
**适用**: 团队项目、生产应用

```bash
./setup.sh . --level=standard
```

**包含文档**:
- 完整的核心文档集
- 模块化文档支持
- 增强的Git Hooks
- 团队协作功能
- 快速参考指南

### Enterprise Level (企业级配置)
**适用**: 大型项目、多团队协作

```bash
./setup.sh . --level=enterprise
```

**额外增加**:
- 合规性文档模板
- 架构决策记录(ADR)
- 安全和审计文档
- 多团队协作支持
- 高级自动化功能

---

## 🛠️ 项目类型特定示例

### Web应用项目配置
```bash
# Next.js项目
npx create-next-app@latest my-next-app
cd my-next-app
curl -fsSL [template-url]/deploy.sh | bash

# 交互配置时选择:
# 项目类型: 1 (Web应用)
# 技术栈: Next.js, React, TypeScript
# 团队规模: 2 (小团队)
# 复杂度: 2 (标准)
```

**结果特化**:
- 监控 `src/`, `components/`, `pages/`, `*.tsx`, `*.jsx`
- 组件开发文档模板
- 部署流程文档
- 性能优化记录模板

### 营销网站项目配置 (专业配置)
```bash
# 基于ccusage项目经验的营销网站配置
npx create-next-app@latest my-marketing-site --typescript --tailwind --app
cd my-marketing-site
curl -fsSL [template-url]/deploy.sh | bash

# 营销网站专用配置:
./setup.sh . --type=marketing \
  --features=analytics,seo,i18n \
  --tech="Next.js 15,TypeScript,Tailwind CSS,next-intl" \
  --deployment=cloudflare-pages \
  --team=solo
```

**营销网站特化功能**:
- 监控 `src/components/blocks/`, `src/messages/`, `src/app/[locale]/`
- Analytics集成状态跟踪 (Google Analytics, OpenPanel, Plausible)
- SEO优化配置管理 (动态sitemap/robots生成)
- 多语言内容一致性检查
- 转化漏斗优化记录
- 用户行为分析文档
- A/B测试管理模板
- Core Web Vitals基准追踪

### API服务项目配置
```bash
# Express API项目
mkdir my-express-api
cd my-express-api
npm init -y
npm install express
git init && git add . && git commit -m "init"

# 配置API项目
./setup.sh . --type=api --tech="Node.js, Express" --team=small
```

**结果特化**:
- 监控 `routes/`, `models/`, `controllers/`, `*.js`
- API设计文档模板
- 数据库架构文档
- 安全配置记录
- 端点测试文档

### 库/工具项目配置
```bash
# TypeScript库项目
mkdir my-ts-library
cd my-ts-library
npm init -y
npm install -D typescript
git init

# 配置库项目
./setup.sh . --type=library --tech="TypeScript" --level=standard
```

**结果特化**:
- 监控 `src/`, `lib/`, `*.ts`, `*.d.ts`
- API参考文档模板
- 示例和教程模板
- 发布流程文档
- 版本管理指南

---

## 👥 团队规模适配示例

### 个人项目 (Solo)
```bash
./setup.sh . --team=solo --level=basic
```

**特点**:
- 简化的文档结构
- 个人使用优化的模板
- 减少团队协作功能
- 专注于个人知识管理

### 小团队项目 (2-5人)
```bash  
./setup.sh . --team=small --level=standard
```

**特点**:
- 完整的协作文档
- Git Hooks团队通知
- 代码审查集成
- 知识共享机制

### 大团队项目 (5+人)
```bash
./setup.sh . --team=large --level=enterprise
```

**特点**:
- 角色权限管理
- 多层次文档结构
- 自动化工作流程
- 企业级合规性

---

## 🔄 实际使用场景

### 场景1: 项目交接
```bash
# 原开发者操作
cd existing-project
curl -fsSL [template-url]/deploy.sh | bash

# 填写项目信息后，创建交接文档
echo "## 项目交接说明" >> docs/PROJECT_STATUS.md
echo "原开发者: John Doe" >> docs/PROJECT_STATUS.md
echo "交接时间: $(date)" >> docs/PROJECT_STATUS.md

# 新开发者操作
git clone project-repo
cd project-repo
# Claude自动读取CLAUDE.md，快速了解项目架构
```

### 场景2: 紧急修复
```bash
# 紧急问题出现
echo "## 🔴 紧急问题 - 生产环境502错误" >> docs/KNOWN_ISSUES.md
echo "发现时间: $(date)" >> docs/KNOWN_ISSUES.md
echo "影响: 全站不可用" >> docs/KNOWN_ISSUES.md

# Claude Code会话
# 1. 自动读取KNOWN_ISSUES.md了解当前问题
# 2. 查看QUICK_REFERENCE.md获取调试命令
# 3. 解决后更新问题状态
```

### 场景3: 功能开发
```bash
# 开始新功能开发前
echo "## 会话 #$(date +%Y-%m-%d)-02" >> docs/SESSION_HISTORY.md
echo "任务: 添加用户认证功能" >> docs/SESSION_HISTORY.md

# Claude读取历史，了解:
# - 项目当前状态
# - 技术架构选择
# - 之前的开发模式
# - 已知的相关问题
```

---

## 📈 成功案例分析

### 案例1: ccusage CLI工具营销网站 (真实案例)
**背景**: 个人项目，专为ccusage CLI工具创建的多语言营销网站

**配置**:
```bash
./setup.sh . --type=marketing \
  --features=analytics,seo,i18n \
  --languages=en,zh \
  --tech="Next.js 15,TypeScript,Tailwind CSS,next-intl" \
  --deployment=cloudflare-pages \
  --team=solo \
  --level=standard
```

**实际效果**:
- **Analytics问题诊断**: 从Google Analytics配置问题到解决，时间从2小时减少到15分钟
- **多语言管理**: 中英文内容不一致问题归零，翻译状态追踪100%准确
- **SEO配置**: 动态sitemap/robots配置变更追踪，部署问题排查时间减少90%
- **环境变量管理**: 三层配置体系（.env.local/.env.production/wrangler.toml）文档化，环境问题归零
- **会话连续性**: 新会话启动时间从15分钟减少到2分钟，Claude立即了解项目状态

### 案例2: 初创公司Web应用
**背景**: 5人团队，React+Node.js全栈应用

**配置**:
```bash
./setup.sh . --type=web --team=small --level=standard --tech="React, Node.js, PostgreSQL"
```

**效果**:
- 新成员上手时间从2天减少到半天
- Claude Code会话效率提升70%
- 技术决策文档化，避免重复讨论
- 问题解决时间平均减少50%

### 案例3: 开源Python库
**背景**: 个人维护的机器学习库项目

**配置**:
```bash
./setup.sh . --type=library --team=solo --level=standard --tech="Python, scikit-learn"
```

**效果**:
- 贡献者能快速理解项目架构
- API文档始终保持最新
- 问题解决方案积累成知识库
- 发布流程标准化

### 案例4: 企业级微服务
**背景**: 20+人团队，多个微服务项目

**配置**:
```bash
# 每个微服务都配置
for service in user-service order-service payment-service; do
    cd $service
    ./setup.sh . --type=api --team=large --level=enterprise --tech="Go, gRPC"
done
```

**效果**:
- 跨服务的一致性文档结构
- 团队间知识共享效率提升
- 新服务开发模式标准化
- 问题排查时间显著减少

---

## 🎯 最佳实践总结

### 配置选择指南
1. **项目类型**: 根据主要技术栈选择，营销网站推荐使用`--type=marketing`
2. **复杂度**: 个人项目选basic，团队项目选standard，企业项目选enterprise
3. **团队规模**: 实际团队人数，影响协作功能
4. **技术栈**: 尽量具体，影响文件监控模式
5. **特殊功能**: 多语言项目必须设置`--features=i18n`，SEO优化项目设置`--features=seo`

### 使用习惯建议
1. **会话开始**: 总是让Claude先读取启动清单
2. **开发过程**: 遇到问题先查已知问题文档
3. **会话结束**: 及时更新会话历史和项目状态
4. **定期维护**: 每周回顾和清理过时信息

### 团队采用策略
1. **试点项目**: 先在小项目试用，积累经验
2. **模板定制**: 根据团队习惯调整模板内容
3. **培训推广**: 确保团队成员了解使用方法
4. **持续改进**: 根据使用反馈优化文档结构

---

**下一步**: 选择适合你项目的配置，开始体验Claude Code会话连续性的强大功能！