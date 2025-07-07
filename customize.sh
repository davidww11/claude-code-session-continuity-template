#!/bin/bash

# Claude Code 会话连续性系统 - 定制化配置脚本
# 用于根据项目特性定制模板内容

set -e

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
print_step() { echo -e "${CYAN}🔧 $1${NC}"; }

# 显示脚本帮助信息
show_help() {
    echo "Claude Code 会话连续性系统 - 定制化配置脚本"
    echo ""
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  --project-name=NAME     项目名称"
    echo "  --project-type=TYPE     项目类型 (web/api/library/mobile/other)"
    echo "  --tech-stack=STACK      技术栈描述"
    echo "  --team-size=SIZE        团队规模 (solo/small/large)"
    echo "  --complexity=LEVEL      复杂度 (basic/standard/enterprise)"
    echo "  --interactive           交互式配置 (默认)"
    echo "  --batch                 批处理模式 (使用默认值)"
    echo "  --help                  显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 --interactive"
    echo "  $0 --project-name='My App' --project-type=web --tech-stack='React, Node.js'"
    echo "  $0 --batch --complexity=standard"
    exit 0
}

# 检查依赖
check_dependencies() {
    local deps=("sed" "find" "grep")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" > /dev/null; then
            print_error "缺少依赖工具: $dep"
            exit 1
        fi
    done
}

# 获取项目信息
get_project_info() {
    print_step "收集项目信息..."
    
    # 自动检测项目名称
    if [ -z "$PROJECT_NAME" ]; then
        DEFAULT_NAME=$(basename "$(pwd)")
        if [ "$INTERACTIVE_MODE" = true ]; then
            read -p "项目名称 [$DEFAULT_NAME]: " PROJECT_NAME
            PROJECT_NAME=${PROJECT_NAME:-$DEFAULT_NAME}
        else
            PROJECT_NAME=$DEFAULT_NAME
        fi
    fi
    
    # 项目类型选择
    if [ -z "$PROJECT_TYPE" ] && [ "$INTERACTIVE_MODE" = true ]; then
        echo ""
        echo "请选择项目类型:"
        echo "1) Web应用 (React/Vue/Angular等)"
        echo "2) API服务 (Node.js/Python/Go等)" 
        echo "3) 库/工具项目"
        echo "4) 移动应用"
        echo "5) 其他"
        
        read -p "选择 (1-5): " type_choice
        case $type_choice in
            1) PROJECT_TYPE="web" ;;
            2) PROJECT_TYPE="api" ;;
            3) PROJECT_TYPE="library" ;;
            4) PROJECT_TYPE="mobile" ;;
            5) PROJECT_TYPE="other" ;;
            *) PROJECT_TYPE="web" ;;
        esac
    elif [ -z "$PROJECT_TYPE" ]; then
        PROJECT_TYPE="web"
    fi
    
    # 自动检测技术栈
    if [ -z "$TECH_STACK" ]; then
        DETECTED_STACK=$(detect_tech_stack)
        if [ "$INTERACTIVE_MODE" = true ]; then
            read -p "主要技术栈 [$DETECTED_STACK]: " TECH_STACK
            TECH_STACK=${TECH_STACK:-$DETECTED_STACK}
        else
            TECH_STACK=$DETECTED_STACK
        fi
    fi
    
    # 团队规模
    if [ -z "$TEAM_SIZE" ] && [ "$INTERACTIVE_MODE" = true ]; then
        echo ""
        echo "团队规模:"
        echo "1) 个人项目"
        echo "2) 小团队 (2-5人)"
        echo "3) 大团队 (5+人)"
        
        read -p "选择 (1-3): " team_choice
        case $team_choice in
            1) TEAM_SIZE="solo" ;;
            2) TEAM_SIZE="small" ;;
            3) TEAM_SIZE="large" ;;
            *) TEAM_SIZE="small" ;;
        esac
    elif [ -z "$TEAM_SIZE" ]; then
        TEAM_SIZE="small"
    fi
    
    # 项目复杂度
    if [ -z "$COMPLEXITY" ] && [ "$INTERACTIVE_MODE" = true ]; then
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
    elif [ -z "$COMPLEXITY" ]; then
        COMPLEXITY="standard"
    fi
}

# 检测技术栈
detect_tech_stack() {
    local stack=""
    
    # 检测 JavaScript/TypeScript 项目
    if [ -f "package.json" ]; then
        if grep -q "react" package.json; then
            stack="React"
        elif grep -q "vue" package.json; then
            stack="Vue.js"
        elif grep -q "angular" package.json; then
            stack="Angular"
        elif grep -q "express" package.json; then
            stack="Node.js, Express"
        elif grep -q "next" package.json; then
            stack="Next.js, React"
        else
            stack="JavaScript/TypeScript"
        fi
        
        if grep -q "typescript" package.json; then
            stack="$stack, TypeScript"
        fi
    # 检测 Python 项目
    elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ] || [ -f "setup.py" ]; then
        if [ -f "requirements.txt" ] && grep -q "django" requirements.txt; then
            stack="Python, Django"
        elif [ -f "requirements.txt" ] && grep -q "flask" requirements.txt; then
            stack="Python, Flask"
        elif [ -f "requirements.txt" ] && grep -q "fastapi" requirements.txt; then
            stack="Python, FastAPI"
        else
            stack="Python"
        fi
    # 检测 Go 项目
    elif [ -f "go.mod" ]; then
        stack="Go"
    # 检测 Rust 项目
    elif [ -f "Cargo.toml" ]; then
        stack="Rust"
    # 检测 Java 项目
    elif [ -f "pom.xml" ] || [ -f "build.gradle" ]; then
        if [ -f "pom.xml" ]; then
            stack="Java, Maven"
        else
            stack="Java, Gradle"
        fi
    # 检测 PHP 项目
    elif [ -f "composer.json" ]; then
        if grep -q "laravel" composer.json; then
            stack="PHP, Laravel"
        elif grep -q "symfony" composer.json; then
            stack="PHP, Symfony"
        else
            stack="PHP"
        fi
    # 检测 C# 项目
    elif [ -f "*.csproj" ] || [ -f "*.sln" ]; then
        stack=".NET, C#"
    else
        stack="未检测到"
    fi
    
    echo "$stack"
}

# 定制CLAUDE.md文件
customize_claude_md() {
    print_step "定制 CLAUDE.md 文件..."
    
    if [ ! -f "CLAUDE.md" ]; then
        print_error "CLAUDE.md 文件不存在"
        return 1
    fi
    
    # 基本信息替换
    sed -i.bak "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" CLAUDE.md
    sed -i.bak "s/{{PROJECT_TYPE}}/$PROJECT_TYPE/g" CLAUDE.md
    sed -i.bak "s/{{TECH_STACK}}/$TECH_STACK/g" CLAUDE.md
    sed -i.bak "s/{{TEAM_SIZE}}/$TEAM_SIZE/g" CLAUDE.md
    
    # 根据项目类型定制内容
    case $PROJECT_TYPE in
        "web")
            sed -i.bak "s/{{PROJECT_SPECIFIC_COMMANDS}}/Web Development/g" CLAUDE.md
            sed -i.bak "s/{{CUSTOM_COMMAND_1}}/npm run dev/g" CLAUDE.md
            sed -i.bak "s/{{COMMAND_1_DESCRIPTION}}/Start development server/g" CLAUDE.md
            sed -i.bak "s/{{CUSTOM_COMMAND_2}}/npm run build/g" CLAUDE.md
            sed -i.bak "s/{{COMMAND_2_DESCRIPTION}}/Build for production/g" CLAUDE.md
            ;;
        "api")
            sed -i.bak "s/{{PROJECT_SPECIFIC_COMMANDS}}/API Development/g" CLAUDE.md
            sed -i.bak "s/{{CUSTOM_COMMAND_1}}/npm start/g" CLAUDE.md
            sed -i.bak "s/{{COMMAND_1_DESCRIPTION}}/Start API server/g" CLAUDE.md
            sed -i.bak "s/{{CUSTOM_COMMAND_2}}/npm run test:api/g" CLAUDE.md
            sed -i.bak "s/{{COMMAND_2_DESCRIPTION}}/Run API tests/g" CLAUDE.md
            ;;
        "library")
            sed -i.bak "s/{{PROJECT_SPECIFIC_COMMANDS}}/Library Development/g" CLAUDE.md
            sed -i.bak "s/{{CUSTOM_COMMAND_1}}/npm run publish/g" CLAUDE.md
            sed -i.bak "s/{{COMMAND_1_DESCRIPTION}}/Publish package/g" CLAUDE.md
            sed -i.bak "s/{{CUSTOM_COMMAND_2}}/npm run docs/g" CLAUDE.md
            sed -i.bak "s/{{COMMAND_2_DESCRIPTION}}/Generate documentation/g" CLAUDE.md
            ;;
        *)
            sed -i.bak "s/{{PROJECT_SPECIFIC_COMMANDS}}/Project Specific/g" CLAUDE.md
            sed -i.bak "s/{{CUSTOM_COMMAND_1}}/# Add your commands here/g" CLAUDE.md
            sed -i.bak "s/{{COMMAND_1_DESCRIPTION}}/Project specific command/g" CLAUDE.md
            sed -i.bak "s/{{CUSTOM_COMMAND_2}}/# Add your commands here/g" CLAUDE.md
            sed -i.bak "s/{{COMMAND_2_DESCRIPTION}}/Project specific command/g" CLAUDE.md
            ;;
    esac
    
    # 根据复杂度调整内容
    if [ "$COMPLEXITY" = "basic" ]; then
        # 简化版本，移除复杂部分
        sed -i.bak '/### 2\. {{PATTERN_2_NAME}}/,/## Environment Configuration/d' CLAUDE.md
    fi
}

# 定制项目状态文档
customize_project_status() {
    print_step "定制 docs/PROJECT_STATUS.md 文件..."
    
    if [ ! -f "docs/PROJECT_STATUS.md" ]; then
        print_warning "docs/PROJECT_STATUS.md 文件不存在，跳过"
        return 0
    fi
    
    local current_date=$(date +"%Y-%m-%d")
    
    sed -i.bak "s/{{UPDATE_DATE}}/$current_date/g" docs/PROJECT_STATUS.md
    sed -i.bak "s/{{CURRENT_VERSION}}/v0.1.0/g" docs/PROJECT_STATUS.md
    sed -i.bak "s/{{PROJECT_STATUS}}/开发中/g" docs/PROJECT_STATUS.md
    sed -i.bak "s/{{CURRENT_BRANCH}}/main/g" docs/PROJECT_STATUS.md
}

# 定制快速参考文档
customize_quick_reference() {
    print_step "定制 docs/QUICK_REFERENCE.md 文件..."
    
    if [ ! -f "docs/QUICK_REFERENCE.md" ]; then
        print_warning "docs/QUICK_REFERENCE.md 文件不存在，跳过"
        return 0
    fi
    
    # 根据技术栈定制命令
    case $PROJECT_TYPE in
        "web")
            sed -i.bak "s/{{DEV_START_COMMAND}}/npm run dev/g" docs/QUICK_REFERENCE.md
            sed -i.bak "s/{{BUILD_COMMAND}}/npm run build/g" docs/QUICK_REFERENCE.md
            sed -i.bak "s/{{TEST_COMMAND}}/npm test/g" docs/QUICK_REFERENCE.md
            sed -i.bak "s/{{LINT_COMMAND}}/npm run lint/g" docs/QUICK_REFERENCE.md
            ;;
        "api")
            sed -i.bak "s/{{DEV_START_COMMAND}}/npm run dev/g" docs/QUICK_REFERENCE.md
            sed -i.bak "s/{{BUILD_COMMAND}}/npm run build/g" docs/QUICK_REFERENCE.md
            sed -i.bak "s/{{TEST_COMMAND}}/npm run test/g" docs/QUICK_REFERENCE.md
            sed -i.bak "s/{{LINT_COMMAND}}/npm run lint/g" docs/QUICK_REFERENCE.md
            ;;
        *)
            sed -i.bak "s/{{DEV_START_COMMAND}}/# Configure your dev command/g" docs/QUICK_REFERENCE.md
            sed -i.bak "s/{{BUILD_COMMAND}}/# Configure your build command/g" docs/QUICK_REFERENCE.md
            sed -i.bak "s/{{TEST_COMMAND}}/# Configure your test command/g" docs/QUICK_REFERENCE.md
            sed -i.bak "s/{{LINT_COMMAND}}/# Configure your lint command/g" docs/QUICK_REFERENCE.md
            ;;
    esac
}

# 定制Git Hooks
customize_git_hooks() {
    print_step "定制 Git Hooks..."
    
    if [ ! -f ".githooks/pre-commit" ]; then
        print_warning ".githooks/pre-commit 文件不存在，跳过"
        return 0
    fi
    
    # 根据项目类型设置文件监控模式
    case $PROJECT_TYPE in
        "web")
            local patterns="src/|components/|pages/|package.json|.*\\.tsx?$|.*\\.jsx?$"
            ;;
        "api")
            local patterns="src/|routes/|models/|package.json|.*\\.py$|.*\\.js$"
            ;;
        "library")
            local patterns="src/|lib/|package.json|.*\\.ts$|.*\\.js$"
            ;;
        *)
            local patterns="src/|package.json|.*\\.(js|ts|py)$"
            ;;
    esac
    
    sed -i.bak "s/{{IMPORTANT_FILE_PATTERNS}}/$patterns/g" .githooks/pre-commit
}

# 创建项目特定的模块文档
create_module_docs() {
    print_step "创建项目特定的模块文档..."
    
    mkdir -p docs/modules
    
    case $PROJECT_TYPE in
        "web")
            create_component_docs
            create_ui_guidelines_docs
            ;;
        "api")
            create_api_docs
            create_database_docs
            ;;
        "library")
            create_api_reference_docs
            create_usage_examples_docs
            ;;
    esac
}

# 创建组件文档 (Web项目)
create_component_docs() {
    if [ ! -f "docs/modules/COMPONENTS.md" ]; then
        cat > docs/modules/COMPONENTS.md << 'EOF'
# 组件架构文档

## 组件分类

### 基础组件
- UI基础组件列表

### 业务组件  
- 业务逻辑组件列表

### 页面组件
- 页面级组件列表

## 组件开发规范

### 命名规范
- 组件文件命名
- 组件导出命名

### 代码结构
- 文件组织方式
- Props定义规范

EOF
        print_success "创建了 docs/modules/COMPONENTS.md"
    fi
}

# 创建API文档 (API项目)
create_api_docs() {
    if [ ! -f "docs/modules/API.md" ]; then
        cat > docs/modules/API.md << 'EOF'
# API 文档

## API 概览
- 基础URL
- 认证方式
- 通用响应格式

## 端点列表

### 用户相关
- 用户注册
- 用户登录
- 用户信息

### 业务接口
- 核心业务API

## 错误码说明
- 通用错误码
- 业务错误码

EOF
        print_success "创建了 docs/modules/API.md"
    fi
}

# 创建使用示例文档 (库项目)
create_usage_examples_docs() {
    if [ ! -f "docs/modules/EXAMPLES.md" ]; then
        cat > docs/modules/EXAMPLES.md << 'EOF'
# 使用示例

## 快速开始

### 安装
```bash
npm install your-library
```

### 基础用法
```javascript
// 基础使用示例
```

## 高级用法

### 配置选项
- 配置参数说明

### 自定义扩展
- 扩展方法

EOF
        print_success "创建了 docs/modules/EXAMPLES.md"
    fi
}

# 创建API参考文档 (库项目)
create_api_reference_docs() {
    if [ ! -f "docs/modules/API_REFERENCE.md" ]; then
        cat > docs/modules/API_REFERENCE.md << 'EOF'
# API 参考

## 主要方法

### 方法1
- 功能描述
- 参数说明
- 返回值
- 使用示例

### 方法2
- 功能描述
- 参数说明
- 返回值
- 使用示例

## 类型定义
- TypeScript 类型定义

EOF
        print_success "创建了 docs/modules/API_REFERENCE.md"
    fi
}

# 清理备份文件
cleanup_backup_files() {
    print_step "清理备份文件..."
    find . -name "*.bak" -delete 2>/dev/null || true
}

# 生成配置总结
generate_summary() {
    print_success "配置完成！"
    echo ""
    print_info "项目配置总结："
    echo "  项目名称: $PROJECT_NAME"
    echo "  项目类型: $PROJECT_TYPE"
    echo "  技术栈: $TECH_STACK"
    echo "  团队规模: $TEAM_SIZE"
    echo "  复杂度: $COMPLEXITY"
    echo ""
    print_info "已定制的文件："
    echo "  ✓ CLAUDE.md"
    echo "  ✓ docs/PROJECT_STATUS.md"
    echo "  ✓ docs/QUICK_REFERENCE.md"
    echo "  ✓ .githooks/pre-commit"
    echo "  ✓ 项目特定模块文档"
    echo ""
    print_info "下一步操作："
    echo "  1. 查看并编辑生成的文档"
    echo "  2. 运行 git add . && git commit -m 'feat: 定制Claude Code会话连续性系统'"
    echo "  3. 开始使用Claude Code进行开发"
}

# 主函数
main() {
    echo "🔧 Claude Code 会话连续性系统 - 定制化配置"
    echo "================================================="
    echo ""
    
    check_dependencies
    get_project_info
    
    echo ""
    print_step "开始定制化配置..."
    
    customize_claude_md
    customize_project_status
    customize_quick_reference
    customize_git_hooks
    
    if [ "$COMPLEXITY" != "basic" ]; then
        create_module_docs
    fi
    
    cleanup_backup_files
    generate_summary
}

# 参数解析
INTERACTIVE_MODE=true
PROJECT_NAME=""
PROJECT_TYPE=""
TECH_STACK=""
TEAM_SIZE=""
COMPLEXITY=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --project-name=*)
            PROJECT_NAME="${1#*=}"
            shift
            ;;
        --project-type=*)
            PROJECT_TYPE="${1#*=}"
            shift
            ;;
        --tech-stack=*)
            TECH_STACK="${1#*=}"
            shift
            ;;
        --team-size=*)
            TEAM_SIZE="${1#*=}"
            shift
            ;;
        --complexity=*)
            COMPLEXITY="${1#*=}"
            shift
            ;;
        --interactive)
            INTERACTIVE_MODE=true
            shift
            ;;
        --batch)
            INTERACTIVE_MODE=false
            shift
            ;;
        --help)
            show_help
            ;;
        *)
            print_error "未知选项: $1"
            echo "使用 --help 查看帮助信息"
            exit 1
            ;;
    esac
done

# 运行主函数
main