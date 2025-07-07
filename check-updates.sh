#!/bin/bash

# Claude Code 会话连续性系统 - 更新检查脚本
# 检查模板更新和版本信息

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
print_step() { echo -e "${CYAN}🔍 $1${NC}"; }

# 配置信息
TEMPLATE_REPO="https://github.com/davidww11/claude-code-session-continuity-template"
TEMPLATE_API="https://api.github.com/repos/davidww11/claude-code-session-continuity-template"
LOCAL_VERSION_FILE=".claude-continuity-version"
REMOTE_VERSION_FILE="VERSION"

# 显示帮助信息
show_help() {
    echo "Claude Code 会话连续性系统 - 更新检查脚本"
    echo ""
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  --check-only            仅检查更新，不提示升级"
    echo "  --auto-update           自动更新到最新版本"
    echo "  --show-changelog        显示更新日志"
    echo "  --show-version          显示当前版本信息"
    echo "  --help                  显示此帮助信息"
    echo ""
    echo "功能:"
    echo "  • 检查远程仓库的最新版本"
    echo "  • 比较本地版本和远程版本"
    echo "  • 显示版本更新日志"
    echo "  • 提供安全的更新建议"
    exit 0
}

# 获取本地版本
get_local_version() {
    if [ -f "$LOCAL_VERSION_FILE" ]; then
        cat "$LOCAL_VERSION_FILE" | head -1
    else
        echo "unknown"
    fi
}

# 获取远程版本信息
get_remote_version() {
    print_step "获取远程版本信息..."
    
    if command -v curl >/dev/null 2>&1; then
        # 获取最新release版本
        local latest_release=$(curl -s "$TEMPLATE_API/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' || echo "")
        
        if [ -n "$latest_release" ]; then
            echo "$latest_release"
            return 0
        fi
        
        # 如果没有release，获取最新commit
        local latest_commit=$(curl -s "$TEMPLATE_API/commits/main" | grep '"sha"' | head -1 | sed -E 's/.*"([^"]+)".*/\1/' | cut -c1-7 || echo "")
        
        if [ -n "$latest_commit" ]; then
            echo "main-$latest_commit"
            return 0
        fi
    elif command -v wget >/dev/null 2>&1; then
        # 使用wget获取版本信息
        local latest_release=$(wget -qO- "$TEMPLATE_API/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' || echo "")
        
        if [ -n "$latest_release" ]; then
            echo "$latest_release"
            return 0
        fi
    fi
    
    print_error "无法获取远程版本信息"
    print_info "请检查网络连接或手动访问: $TEMPLATE_REPO"
    return 1
}

# 比较版本号
compare_versions() {
    local local_ver="$1"
    local remote_ver="$2"
    
    # 处理特殊版本格式
    if [ "$local_ver" = "unknown" ]; then
        echo "update_available"
        return 0
    fi
    
    # 简单的版本比较
    if [ "$local_ver" = "$remote_ver" ]; then
        echo "up_to_date"
    else
        echo "update_available"
    fi
}

# 获取更新日志
get_changelog() {
    print_step "获取更新日志..."
    
    if command -v curl >/dev/null 2>&1; then
        local changelog=$(curl -s "$TEMPLATE_API/releases" | grep -A 10 '"body"' | head -20 || echo "")
        if [ -n "$changelog" ]; then
            echo "$changelog"
        else
            echo "无法获取更新日志"
        fi
    else
        echo "无法获取更新日志 (需要curl)"
    fi
}

# 检查模板文件是否存在
check_template_files() {
    local missing_files=()
    local core_files=(
        "CLAUDE.md"
        "docs/PROJECT_STATUS.md"
        "docs/SESSION_HISTORY.md"
        "docs/KNOWN_ISSUES.md"
        "docs/QUICK_REFERENCE.md"
        ".githooks/pre-commit"
        ".githooks/setup.sh"
    )
    
    for file in "${core_files[@]}"; do
        if [ ! -f "$file" ]; then
            missing_files+=("$file")
        fi
    done
    
    if [ ${#missing_files[@]} -gt 0 ]; then
        print_warning "缺少以下核心文件:"
        for file in "${missing_files[@]}"; do
            echo "  - $file"
        done
        return 1
    fi
    
    return 0
}

# 检查配置完整性
check_configuration() {
    print_step "检查配置完整性..."
    
    local issues=()
    
    # 检查CLAUDE.md是否包含占位符
    if [ -f "CLAUDE.md" ] && grep -q "{{" "CLAUDE.md"; then
        issues+=("CLAUDE.md 包含未替换的占位符")
    fi
    
    # 检查Git hooks是否设置
    if ! git config core.hooksPath | grep -q ".githooks"; then
        issues+=("Git hooks 未正确设置")
    fi
    
    # 检查项目状态文档
    if [ -f "docs/PROJECT_STATUS.md" ] && grep -q "{{" "docs/PROJECT_STATUS.md"; then
        issues+=("PROJECT_STATUS.md 包含未替换的占位符")
    fi
    
    if [ ${#issues[@]} -gt 0 ]; then
        print_warning "发现配置问题:"
        for issue in "${issues[@]}"; do
            echo "  - $issue"
        done
        print_info "建议运行: ./customize.sh 来完成配置"
        return 1
    fi
    
    print_success "配置检查通过"
    return 0
}

# 显示版本信息
show_version_info() {
    local local_ver=$(get_local_version)
    
    echo "版本信息："
    echo "  本地版本: $local_ver"
    echo "  模板仓库: $TEMPLATE_REPO"
    echo "  检查时间: $(date)"
    
    if [ -f "$LOCAL_VERSION_FILE" ]; then
        echo "  安装时间: $(stat -f %Sm -t %Y-%m-%d\ %H:%M:%S "$LOCAL_VERSION_FILE" 2>/dev/null || date -r "$LOCAL_VERSION_FILE" '+%Y-%m-%d %H:%M:%S' 2>/dev/null || echo 'unknown')"
    fi
}

# 更新版本文件
update_version_file() {
    local version="$1"
    echo "$version" > "$LOCAL_VERSION_FILE"
    echo "更新时间: $(date)" >> "$LOCAL_VERSION_FILE"
    echo "更新方式: 自动检查" >> "$LOCAL_VERSION_FILE"
}

# 提供更新建议
provide_update_suggestions() {
    local local_ver="$1"
    local remote_ver="$2"
    
    echo ""
    print_info "更新建议："
    echo "  1. 备份当前配置:"
    echo "     cp -r docs/ docs_backup/"
    echo "     cp CLAUDE.md CLAUDE.md.backup"
    echo ""
    echo "  2. 获取最新模板:"
    echo "     curl -fsSL https://raw.githubusercontent.com/davidww11/claude-code-session-continuity-template/main/deploy.sh | bash"
    echo ""
    echo "  3. 或者手动更新:"
    echo "     git clone $TEMPLATE_REPO template-update"
    echo "     # 手动合并更新的文件"
    echo ""
    echo "  4. 重新运行定制化配置:"
    echo "     ./customize.sh"
    echo ""
    print_warning "注意: 更新前请务必备份您的自定义配置"
}

# 主检查函数
main_check() {
    print_step "开始检查更新..."
    
    local local_ver=$(get_local_version)
    local remote_ver=$(get_remote_version)
    
    if [ $? -ne 0 ]; then
        print_error "无法获取远程版本信息"
        return 1
    fi
    
    echo ""
    echo "版本比较："
    echo "  本地版本: $local_ver"
    echo "  远程版本: $remote_ver"
    
    local comparison=$(compare_versions "$local_ver" "$remote_ver")
    
    case $comparison in
        "up_to_date")
            print_success "您使用的是最新版本！"
            ;;
        "update_available")
            print_warning "发现新版本可用！"
            
            if [ "$CHECK_ONLY" != true ]; then
                provide_update_suggestions "$local_ver" "$remote_ver"
                
                if [ "$SHOW_CHANGELOG" = true ]; then
                    echo ""
                    print_info "更新日志："
                    get_changelog
                fi
                
                if [ "$AUTO_UPDATE" = true ]; then
                    print_step "开始自动更新..."
                    # 这里可以实现自动更新逻辑
                    print_info "自动更新功能正在开发中"
                fi
            fi
            ;;
    esac
    
    echo ""
    check_template_files
    check_configuration
    
    # 更新本地版本记录
    if [ "$comparison" = "update_available" ] && [ "$CHECK_ONLY" != true ]; then
        update_version_file "$remote_ver"
    fi
}

# 检查依赖
check_dependencies() {
    local missing_deps=()
    
    if ! command -v git >/dev/null 2>&1; then
        missing_deps+=("git")
    fi
    
    if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
        missing_deps+=("curl 或 wget")
    fi
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        print_error "缺少依赖工具:"
        for dep in "${missing_deps[@]}"; do
            echo "  - $dep"
        done
        exit 1
    fi
}

# 主函数
main() {
    echo "🔍 Claude Code 会话连续性系统 - 更新检查"
    echo "============================================"
    echo ""
    
    check_dependencies
    
    if [ "$SHOW_VERSION" = true ]; then
        show_version_info
        exit 0
    fi
    
    if [ "$SHOW_CHANGELOG" = true ] && [ "$CHECK_ONLY" != true ]; then
        echo "更新日志："
        get_changelog
        exit 0
    fi
    
    main_check
}

# 参数解析
CHECK_ONLY=false
AUTO_UPDATE=false
SHOW_CHANGELOG=false
SHOW_VERSION=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --check-only)
            CHECK_ONLY=true
            shift
            ;;
        --auto-update)
            AUTO_UPDATE=true
            shift
            ;;
        --show-changelog)
            SHOW_CHANGELOG=true
            shift
            ;;
        --show-version)
            SHOW_VERSION=true
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