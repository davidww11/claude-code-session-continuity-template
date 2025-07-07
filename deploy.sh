#!/bin/bash

# Claude Code 会话连续性系统 - 一键部署脚本
# 版本: v1.0.0

set -e  # 遇到错误时退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

print_success() {
    print_message $GREEN "✅ $1"
}

print_warning() {
    print_message $YELLOW "⚠️  $1"
}

print_error() {
    print_message $RED "❌ $1"
}

print_info() {
    print_message $BLUE "ℹ️  $1"
}

# 检查前置条件
check_prerequisites() {
    print_info "检查前置条件..."
    
    # 检查是否在Git仓库中
    if [ ! -d ".git" ]; then
        print_error "当前目录不是Git仓库"
        print_info "请先运行: git init"
        exit 1
    fi
    
    # 检查Git配置
    if ! git config user.name > /dev/null; then
        print_error "Git用户名未配置"
        print_info "请先运行: git config --global user.name 'Your Name'"
        exit 1
    fi
    
    print_success "前置条件检查通过"
}

# 下载模板文件
download_templates() {
    print_info "下载Claude Code会话连续性模板..."
    
    # 临时目录
    TEMP_DIR="/tmp/claude-continuity-$$"
    mkdir -p "$TEMP_DIR"
    
    # 下载模板（这里需要替换为实际的下载地址）
    if command -v curl > /dev/null; then
        curl -fsSL "https://github.com/claude-continuity/template/archive/main.tar.gz" | tar -xz -C "$TEMP_DIR" --strip-components=1
    elif command -v wget > /dev/null; then
        wget -qO- "https://github.com/claude-continuity/template/archive/main.tar.gz" | tar -xz -C "$TEMP_DIR" --strip-components=1
    else
        print_error "未找到curl或wget，无法下载模板"
        print_info "请手动下载并解压模板文件"
        exit 1
    fi
    
    TEMPLATE_DIR="$TEMP_DIR"
    print_success "模板下载完成"
}

# 收集项目信息
collect_project_info() {
    print_info "收集项目信息..."
    
    # 项目名称（从当前目录获取）
    PROJECT_NAME=$(basename "$(pwd)")
    echo "项目名称: $PROJECT_NAME"
    
    # 项目类型
    echo ""
    echo "请选择项目类型:"
    echo "1) Web应用 (React/Vue/Angular等)"
    echo "2) API服务 (Node.js/Python/Go等)"
    echo "3) 库/工具项目"
    echo "4) 移动应用"
    echo "5) 其他"
    
    read -p "选择 (1-5): " project_type_choice
    
    case $project_type_choice in
        1) PROJECT_TYPE="web" ;;
        2) PROJECT_TYPE="api" ;;
        3) PROJECT_TYPE="library" ;;
        4) PROJECT_TYPE="mobile" ;;
        5) PROJECT_TYPE="other" ;;
        *) PROJECT_TYPE="other" ;;
    esac
    
    # 技术栈
    read -p "主要技术栈 (例如: React, Node.js, Python): " TECH_STACK
    
    # 团队规模
    echo ""
    echo "团队规模:"
    echo "1) 个人项目"
    echo "2) 小团队 (2-5人)"
    echo "3) 大团队 (5+人)"
    
    read -p "选择 (1-3): " team_size_choice
    
    case $team_size_choice in
        1) TEAM_SIZE="solo" ;;
        2) TEAM_SIZE="small" ;;
        3) TEAM_SIZE="large" ;;
        *) TEAM_SIZE="small" ;;
    esac
    
    # 项目复杂度
    echo ""
    echo "项目复杂度:"
    echo "1) 基础 (简单项目，最小化文档)"
    echo "2) 标准 (完整文档体系)"
    echo "3) 企业级 (增强功能和合规性)"
    
    read -p "选择 (1-3): " complexity_choice
    
    case $complexity_choice in
        1) COMPLEXITY="basic" ;;
        2) COMPLEXITY="standard" ;;
        3) COMPLEXITY="enterprise" ;;
        *) COMPLEXITY="standard" ;;
    esac
    
    print_success "项目信息收集完成"
}

# 复制和定制模板文件
deploy_templates() {
    print_info "部署模板文件..."
    
    # 创建目录结构
    mkdir -p docs/modules
    mkdir -p docs/templates
    mkdir -p .githooks
    
    # 复制核心文档模板
    cp "$TEMPLATE_DIR/templates/core/"* docs/
    
    # 复制Git Hooks
    cp "$TEMPLATE_DIR/templates/hooks/"* .githooks/
    chmod +x .githooks/*
    
    # 复制CLAUDE.md到根目录
    cp "$TEMPLATE_DIR/templates/core/CLAUDE.md" ./
    
    print_success "模板文件复制完成"
}

# 定制模板内容
customize_templates() {
    print_info "定制模板内容..."
    
    CURRENT_DATE=$(date +"%Y-%m-%d")
    
    # 定制CLAUDE.md
    sed -i.bak "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" CLAUDE.md
    sed -i.bak "s/{{PROJECT_TYPE}}/$PROJECT_TYPE/g" CLAUDE.md
    sed -i.bak "s/{{TECH_STACK}}/$TECH_STACK/g" CLAUDE.md
    sed -i.bak "s/{{TEAM_SIZE}}/$TEAM_SIZE/g" CLAUDE.md
    
    # 定制PROJECT_STATUS.md
    sed -i.bak "s/{{CURRENT_DATE}}/$CURRENT_DATE/g" docs/PROJECT_STATUS.md
    sed -i.bak "s/{{PROJECT_VERSION}}/v0.1.0/g" docs/PROJECT_STATUS.md
    sed -i.bak "s/{{PROJECT_STATUS}}/开发中/g" docs/PROJECT_STATUS.md
    
    # 定制Git Hooks
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
    
    print_success "模板定制完成"
}

# 设置Git Hooks
setup_git_hooks() {
    print_info "设置Git Hooks..."
    
    # 运行hooks设置脚本
    ./.githooks/setup.sh
    
    print_success "Git Hooks设置完成"
}

# 创建初始文档内容
create_initial_content() {
    print_info "创建初始文档内容..."
    
    # 添加初始会话记录
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

    print_success "初始文档内容创建完成"
}

# 验证安装
verify_installation() {
    print_info "验证安装..."
    
    # 检查文件是否存在
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
            return 1
        fi
    done
    
    # 检查Git Hooks配置
    if git config core.hooksPath | grep -q ".githooks"; then
        print_success "Git Hooks配置正确"
    else
        print_warning "Git Hooks配置可能有问题"
    fi
    
    print_success "安装验证完成"
}

# 清理临时文件
cleanup() {
    if [ -n "$TEMP_DIR" ] && [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
        print_info "清理临时文件完成"
    fi
}

# 显示下一步指导
show_next_steps() {
    echo ""
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
    echo ""
    print_info "📚 了解更多:"
    echo "  • 查看完整文档: https://claude-continuity-docs.com"
    echo "  • 示例项目: https://github.com/claude-continuity/examples"
    echo "  • 获取支持: https://github.com/claude-continuity/template/issues"
    echo ""
    print_success "开始使用Claude Code体验无缝的项目连续性！"
}

# 主函数
main() {
    echo "🚀 Claude Code 会话连续性系统 - 一键部署"
    echo "========================================"
    echo ""
    
    # 设置错误处理
    trap cleanup EXIT
    
    # 执行部署步骤
    check_prerequisites
    download_templates
    collect_project_info
    deploy_templates
    customize_templates
    setup_git_hooks
    create_initial_content
    verify_installation
    show_next_steps
}

# 运行主函数
main "$@"