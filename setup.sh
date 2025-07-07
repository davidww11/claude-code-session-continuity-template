#!/bin/bash

# Claude Code 会话连续性系统 - 本地安装脚本
# 用于从本地模板目录安装到目标项目

set -e

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }

# 使用说明
usage() {
    echo "使用方法: $0 <目标项目目录> [选项]"
    echo ""
    echo "选项:"
    echo "  --type=TYPE          项目类型 (web/api/library/mobile/other)"
    echo "  --level=LEVEL        复杂度 (basic/standard/enterprise)"
    echo "  --team=SIZE          团队规模 (solo/small/large)"
    echo "  --tech=STACK         技术栈描述"
    echo "  --help               显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 /path/to/my-project"
    echo "  $0 /path/to/my-project --type=web --level=standard --team=small"
    exit 1
}

# 检查参数
if [ $# -eq 0 ] || [ "$1" = "--help" ]; then
    usage
fi

TARGET_DIR="$1"
shift

# 解析选项
PROJECT_TYPE="web"
COMPLEXITY="standard"
TEAM_SIZE="small"
TECH_STACK=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --type=*)
            PROJECT_TYPE="${1#*=}"
            shift
            ;;
        --level=*)
            COMPLEXITY="${1#*=}"
            shift
            ;;
        --team=*)
            TEAM_SIZE="${1#*=}"
            shift
            ;;
        --tech=*)
            TECH_STACK="${1#*=}"
            shift
            ;;
        *)
            print_error "未知选项: $1"
            usage
            ;;
    esac
done

# 验证目标目录
if [ ! -d "$TARGET_DIR" ]; then
    print_error "目标目录不存在: $TARGET_DIR"
    exit 1
fi

if [ ! -d "$TARGET_DIR/.git" ]; then
    print_error "目标目录不是Git仓库: $TARGET_DIR"
    print_info "请先在目标目录运行: git init"
    exit 1
fi

# 获取模板目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/templates"

if [ ! -d "$TEMPLATE_DIR" ]; then
    print_error "模板目录不存在: $TEMPLATE_DIR"
    exit 1
fi

print_info "开始安装Claude Code会话连续性系统..."
print_info "目标目录: $TARGET_DIR"
print_info "项目类型: $PROJECT_TYPE"
print_info "复杂度: $COMPLEXITY"
print_info "团队规模: $TEAM_SIZE"

# 进入目标目录
cd "$TARGET_DIR"

# 创建目录结构
print_info "创建目录结构..."
mkdir -p docs/modules
mkdir -p docs/templates
mkdir -p .githooks

# 复制核心文档
print_info "复制核心文档..."
cp "$TEMPLATE_DIR/core/"* docs/
cp "$TEMPLATE_DIR/core/CLAUDE.md" ./

# 复制Git Hooks
print_info "复制Git Hooks..."
cp "$TEMPLATE_DIR/hooks/"* .githooks/
chmod +x .githooks/*

# 获取项目信息
PROJECT_NAME=$(basename "$(pwd)")
CURRENT_DATE=$(date +"%Y-%m-%d")

# 如果技术栈未指定，尝试自动检测
if [ -z "$TECH_STACK" ]; then
    if [ -f "package.json" ]; then
        if grep -q "react" package.json; then
            TECH_STACK="React, TypeScript"
        elif grep -q "vue" package.json; then
            TECH_STACK="Vue.js, TypeScript"
        elif grep -q "express" package.json; then
            TECH_STACK="Node.js, Express"
        else
            TECH_STACK="JavaScript/TypeScript"
        fi
    elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
        TECH_STACK="Python"
    elif [ -f "go.mod" ]; then
        TECH_STACK="Go"
    elif [ -f "Cargo.toml" ]; then
        TECH_STACK="Rust"
    else
        TECH_STACK="未指定"
    fi
fi

print_info "定制模板内容..."

# 定制CLAUDE.md
sed -i.bak "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" CLAUDE.md
sed -i.bak "s/{{PROJECT_TYPE}}/$PROJECT_TYPE/g" CLAUDE.md
sed -i.bak "s/{{TECH_STACK}}/$TECH_STACK/g" CLAUDE.md
sed -i.bak "s/{{TEAM_SIZE}}/$TEAM_SIZE/g" CLAUDE.md

# 简化模板以适应不同复杂度
if [ "$COMPLEXITY" = "basic" ]; then
    # 基础版本：移除复杂的部分
    sed -i.bak '/### 2\. {{PATTERN_2_NAME}}/,$d' CLAUDE.md
    sed -i.bak '/### {{COMMON_TASK_2}}/,$d' CLAUDE.md
fi

# 定制PROJECT_STATUS.md
sed -i.bak "s/{{CURRENT_DATE}}/$CURRENT_DATE/g" docs/PROJECT_STATUS.md
sed -i.bak "s/{{PROJECT_VERSION}}/v0.1.0/g" docs/PROJECT_STATUS.md
sed -i.bak "s/{{PROJECT_STATUS}}/开发中/g" docs/PROJECT_STATUS.md

# 根据项目类型定制Git Hooks
case $PROJECT_TYPE in
    "web")
        IMPORTANT_PATTERNS="src/|components/|pages/|package.json|.*\\.tsx?$|.*\\.jsx?$"
        FILE_EXT="tsx"
        ;;
    "api")
        IMPORTANT_PATTERNS="src/|routes/|models/|package.json|.*\\.py$|.*\\.js$"
        FILE_EXT="js"
        ;;
    "library")
        IMPORTANT_PATTERNS="src/|lib/|package.json|.*\\.ts$|.*\\.js$"
        FILE_EXT="ts"
        ;;
    *)
        IMPORTANT_PATTERNS="src/|package.json|.*\\.(js|ts|py)$"
        FILE_EXT="js"
        ;;
esac

sed -i.bak "s/{{IMPORTANT_FILE_PATTERNS}}/$IMPORTANT_PATTERNS/g" .githooks/pre-commit
sed -i.bak "s/{{FILE_EXTENSION}}/$FILE_EXT/g" .githooks/setup.sh

# 清理备份文件
find . -name "*.bak" -delete

# 设置Git Hooks
print_info "设置Git Hooks..."
./.githooks/setup.sh

# 创建初始会话记录
print_info "创建初始会话记录..."
cat >> docs/SESSION_HISTORY.md << EOF

## 会话 #$(date +"%Y-%m-%d")-01

**时间**: $(date +"%Y-%m-%d")  
**主要任务**: 项目初始化和Claude Code会话连续性系统设置

### 🎯 主要成就
- ✅ 设置完整的Claude Code会话连续性系统
- ✅ 创建标准化的文档结构
- ✅ 配置Git Hooks自动提醒机制

### 🔍 关键发现
- 项目类型: $PROJECT_TYPE
- 技术栈: $TECH_STACK
- 团队规模: $TEAM_SIZE
- 复杂度: $COMPLEXITY

### 💡 最佳实践总结
- 使用模板化的会话记录格式保持一致性
- 及时更新项目状态，避免信息滞后
- 重要决策要记录背景和原因，不只是结果

### 🎯 重要决策记录
- **选择会话连续性系统**: 基于提高Claude Code使用效率的需求
- **采用标准化文档结构**: 便于团队协作和知识传承

### 🚀 会话结束前的建议
**为下次会话准备**:
- 开始具体的项目开发工作
- 按照建立的文档模式持续更新

**当前优先级**:
- 完成项目基础架构搭建
- 建立开发工作流程

EOF

# 验证安装
print_info "验证安装..."
local files_to_check=(
    "CLAUDE.md"
    "docs/PROJECT_STATUS.md"
    "docs/SESSION_HISTORY.md"
    "docs/KNOWN_ISSUES.md"
    "docs/QUICK_REFERENCE.md"
    ".githooks/pre-commit"
    ".githooks/setup.sh"
)

for file in "${files_to_check[@]}"; do
    if [ -f "$file" ]; then
        print_success "文件检查: $file"
    else
        print_error "文件缺失: $file"
        exit 1
    fi
done

print_success "🎉 Claude Code 会话连续性系统安装完成！"
echo ""
print_info "📋 下一步操作："
echo "  1. 查看生成的文档: ls -la docs/"
echo "  2. 编辑 CLAUDE.md 添加项目特定信息"
echo "  3. 提交初始设置: git add . && git commit -m 'feat: 添加Claude Code会话连续性系统'"
echo ""
print_info "🧪 测试Git Hooks:"
echo "  1. 创建测试文件: touch test.$FILE_EXT"
echo "  2. 添加到暂存: git add test.$FILE_EXT"
echo "  3. 尝试提交: git commit -m 'test: 测试hooks'"
echo "  4. 应该会看到文档更新提醒"