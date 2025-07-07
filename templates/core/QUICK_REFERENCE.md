# 快速参考指南 | Quick Reference

*Claude Code会话中的常用命令、模式和快捷方式*

---

## 🚀 常用开发命令

### 基础开发
```bash
# 启动开发服务器
{{DEV_START_COMMAND}}

# 构建生产版本
{{BUILD_COMMAND}}

# 运行测试
{{TEST_COMMAND}}

# 代码检查
{{LINT_COMMAND}}

# 类型检查 (如果是TypeScript项目)
{{TYPE_CHECK_COMMAND}}
```

### {{PROJECT_SPECIFIC_CATEGORY}}
```bash
# {{CUSTOM_COMMAND_1_DESCRIPTION}}
{{CUSTOM_COMMAND_1}}

# {{CUSTOM_COMMAND_2_DESCRIPTION}}
{{CUSTOM_COMMAND_2}}

# {{CUSTOM_COMMAND_3_DESCRIPTION}}
{{CUSTOM_COMMAND_3}}
```

### 部署相关
```bash
# 部署到{{DEPLOYMENT_TARGET}}
{{DEPLOY_COMMAND}}

# 预览部署
{{PREVIEW_COMMAND}}

# 检查部署状态
{{DEPLOYMENT_STATUS_COMMAND}}
```

---

## 📁 关键文件位置

### 项目结构
```
{{PROJECT_ROOT}}/
├── {{SOURCE_DIR}}/              # {{SOURCE_DESCRIPTION}}
│   ├── {{COMPONENT_DIR}}/       # {{COMPONENT_DESCRIPTION}}
│   ├── {{UTIL_DIR}}/            # {{UTIL_DESCRIPTION}}
│   └── {{CONFIG_DIR}}/          # {{CONFIG_DESCRIPTION}}
├── {{TEST_DIR}}/                # {{TEST_DESCRIPTION}}
├── {{DOC_DIR}}/                 # {{DOC_DESCRIPTION}}
└── {{BUILD_DIR}}/               # {{BUILD_DESCRIPTION}}
```

### 配置文件
```
{{CONFIG_FILE_1}}               # {{CONFIG_1_DESCRIPTION}}
{{CONFIG_FILE_2}}               # {{CONFIG_2_DESCRIPTION}}
{{CONFIG_FILE_3}}               # {{CONFIG_3_DESCRIPTION}}
```

---

## 🔧 常用代码模式

### 模式1: {{PATTERN_1_NAME}}
```{{PATTERN_1_LANGUAGE}}
// {{PATTERN_1_DESCRIPTION}}
{{PATTERN_1_CODE}}
```

### 模式2: {{PATTERN_2_NAME}}
```{{PATTERN_2_LANGUAGE}}
// {{PATTERN_2_DESCRIPTION}}
{{PATTERN_2_CODE}}
```

### 模式3: {{PATTERN_3_NAME}}
```{{PATTERN_3_LANGUAGE}}
// {{PATTERN_3_DESCRIPTION}}
{{PATTERN_3_CODE}}
```

---

## 🌐 URL和端点

### 开发环境
```
{{DEV_URL}}                     # 主应用
{{DEV_API_URL}}                 # API端点
{{DEV_ADMIN_URL}}               # 管理界面
```

### 生产环境
```
{{PROD_URL}}                    # 生产环境
{{PROD_API_URL}}                # 生产API
{{STAGING_URL}}                 # 预发布环境
```

### 外部服务
```
{{EXTERNAL_SERVICE_1}}          # {{SERVICE_1_DESCRIPTION}}
{{EXTERNAL_SERVICE_2}}          # {{SERVICE_2_DESCRIPTION}}
```

---

## 🎯 测试和调试

### 测试命令
```bash
# 运行所有测试
{{TEST_ALL_COMMAND}}

# 运行特定测试
{{TEST_SPECIFIC_COMMAND}}

# 测试覆盖率
{{TEST_COVERAGE_COMMAND}}

# 监视模式测试
{{TEST_WATCH_COMMAND}}
```

### 调试工具
```bash
# 启动调试模式
{{DEBUG_COMMAND}}

# 查看日志
{{LOG_COMMAND}}

# 性能分析
{{PERFORMANCE_COMMAND}}
```

### 常用调试技巧
```{{DEBUG_LANGUAGE}}
// {{DEBUG_TIP_1}}
{{DEBUG_CODE_1}}

// {{DEBUG_TIP_2}}
{{DEBUG_CODE_2}}
```

---

## 🚨 故障排除快速指南

### 常见问题速查

| 问题 | 可能原因 | 快速解决 |
|------|----------|----------|
| {{COMMON_PROBLEM_1}} | {{CAUSE_1}} | {{QUICK_FIX_1}} |
| {{COMMON_PROBLEM_2}} | {{CAUSE_2}} | {{QUICK_FIX_2}} |
| {{COMMON_PROBLEM_3}} | {{CAUSE_3}} | {{QUICK_FIX_3}} |
| {{COMMON_PROBLEM_4}} | {{CAUSE_4}} | {{QUICK_FIX_4}} |

### 紧急重置命令
```bash
# 完全重置开发环境
{{RESET_COMMAND_1}}
{{RESET_COMMAND_2}}
{{RESET_COMMAND_3}}

# 清理缓存
{{CLEAR_CACHE_COMMAND}}

# 重新安装依赖
{{REINSTALL_DEPS_COMMAND}}
```

---

## 📝 代码规范快速检查

### 提交前检查清单
- [ ] {{CHECKLIST_ITEM_1}}
- [ ] {{CHECKLIST_ITEM_2}}
- [ ] {{CHECKLIST_ITEM_3}}
- [ ] {{CHECKLIST_ITEM_4}}

### Git提交规范
```bash
# 提交消息格式
{{COMMIT_FORMAT}}

# 常用提交类型
{{COMMIT_TYPE_1}}: {{COMMIT_DESCRIPTION_1}}
{{COMMIT_TYPE_2}}: {{COMMIT_DESCRIPTION_2}}
{{COMMIT_TYPE_3}}: {{COMMIT_DESCRIPTION_3}}
```

### 代码风格
```{{STYLE_LANGUAGE}}
// ✅ 推荐写法
{{GOOD_STYLE_EXAMPLE}}

// ❌ 避免写法
{{BAD_STYLE_EXAMPLE}}
```

---

## 🔗 重要链接

### 项目相关
- **项目仓库**: {{REPO_URL}}
- **项目文档**: {{DOCS_URL}}
- **部署面板**: {{DEPLOYMENT_DASHBOARD}}
- **监控面板**: {{MONITORING_DASHBOARD}}

### 技术文档
- **{{TECH_1}}**: {{TECH_1_DOCS}}
- **{{TECH_2}}**: {{TECH_2_DOCS}}
- **{{TECH_3}}**: {{TECH_3_DOCS}}

### 团队资源
- **团队Wiki**: {{TEAM_WIKI}}
- **设计系统**: {{DESIGN_SYSTEM}}
- **API文档**: {{API_DOCS}}

---

## ⚡ 性能优化快速技巧

### {{PERFORMANCE_CATEGORY_1}}
```{{PERF_LANGUAGE_1}}
// {{PERF_TIP_1}}
{{PERF_CODE_1}}
```

### {{PERFORMANCE_CATEGORY_2}}
```{{PERF_LANGUAGE_2}}
// {{PERF_TIP_2}}
{{PERF_CODE_2}}
```

### 性能监控
```bash
# 性能分析
{{PERF_ANALYSIS_COMMAND}}

# 构建分析
{{BUILD_ANALYSIS_COMMAND}}

# 运行时监控
{{RUNTIME_MONITORING_COMMAND}}
```

---

## 🔐 安全检查要点

### 开发时检查
- [ ] {{SECURITY_CHECK_1}}
- [ ] {{SECURITY_CHECK_2}}
- [ ] {{SECURITY_CHECK_3}}

### 部署前检查
- [ ] {{DEPLOYMENT_SECURITY_1}}
- [ ] {{DEPLOYMENT_SECURITY_2}}
- [ ] {{DEPLOYMENT_SECURITY_3}}

### 安全扫描命令
```bash
# 依赖安全扫描
{{SECURITY_SCAN_COMMAND}}

# 代码安全检查
{{CODE_SECURITY_COMMAND}}
```

---

## 📊 监控和分析

### 关键指标
- **{{METRIC_1}}**: {{METRIC_1_COMMAND}}
- **{{METRIC_2}}**: {{METRIC_2_COMMAND}}
- **{{METRIC_3}}**: {{METRIC_3_COMMAND}}

### 日志查看
```bash
# 应用日志
{{APP_LOG_COMMAND}}

# 错误日志
{{ERROR_LOG_COMMAND}}

# 性能日志
{{PERFORMANCE_LOG_COMMAND}}
```

---

## 🎨 UI/UX 相关

### 设计系统
- **颜色方案**: {{COLOR_SCHEME}}
- **字体系统**: {{TYPOGRAPHY_SYSTEM}}
- **间距规范**: {{SPACING_SYSTEM}}

### 响应式断点
```{{STYLE_LANGUAGE}}
{{RESPONSIVE_BREAKPOINTS}}
```

### 常用组件模式
```{{COMPONENT_LANGUAGE}}
// {{COMPONENT_PATTERN_1}}
{{COMPONENT_CODE_1}}

// {{COMPONENT_PATTERN_2}}
{{COMPONENT_CODE_2}}
```

---

## 📱 移动端相关 (如适用)

### 移动端测试
```bash
# 移动端模拟
{{MOBILE_SIMULATOR_COMMAND}}

# 真机测试
{{DEVICE_TESTING_COMMAND}}
```

### 移动端优化
- {{MOBILE_OPTIMIZATION_1}}
- {{MOBILE_OPTIMIZATION_2}}
- {{MOBILE_OPTIMIZATION_3}}

---

## 🔄 CI/CD 快速操作

### 构建状态检查
```bash
# 检查构建状态
{{BUILD_STATUS_COMMAND}}

# 触发重新构建
{{REBUILD_COMMAND}}
```

### 部署操作
```bash
# 手动部署
{{MANUAL_DEPLOY_COMMAND}}

# 回滚部署
{{ROLLBACK_COMMAND}}
```

---

## 💡 效率提升技巧

### IDE/编辑器设置
- **推荐插件**: {{RECOMMENDED_EXTENSIONS}}
- **快捷键**: {{USEFUL_SHORTCUTS}}
- **代码片段**: {{CODE_SNIPPETS}}

### 工作流优化
1. {{WORKFLOW_TIP_1}}
2. {{WORKFLOW_TIP_2}}
3. {{WORKFLOW_TIP_3}}

### 自动化脚本
```bash
# {{AUTOMATION_SCRIPT_1_DESCRIPTION}}
{{AUTOMATION_SCRIPT_1}}

# {{AUTOMATION_SCRIPT_2_DESCRIPTION}}
{{AUTOMATION_SCRIPT_2}}
```

---

**使用提示**: 
- 使用 Ctrl+F 在此文档中快速搜索
- 常用命令可以加入 shell 别名
- 遇到问题时先查看 KNOWN_ISSUES.md
- 定期更新此文档以保持实用性