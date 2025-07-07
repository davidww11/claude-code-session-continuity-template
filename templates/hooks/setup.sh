#!/bin/bash

# 设置 Git Hooks 的脚本
echo "🔧 设置 Claude Code Git Hooks..."

# 检查是否在Git仓库中
if [ ! -d ".git" ]; then
    echo "❌ 错误: 当前目录不是Git仓库"
    echo "请在Git仓库根目录下运行此脚本"
    exit 1
fi

# 设置 git hooks 路径
git config core.hooksPath .githooks

# 确保hooks文件有执行权限
chmod +x .githooks/*

echo "✅ Git Hooks 设置完成！"
echo ""
echo "📋 已启用的 hooks："
echo "   • pre-commit: 提交前文档更新提醒"
echo ""
echo "💡 使用说明："
echo "   • 提交代码时会自动检查是否需要更新文档"
echo "   • 修改重要文件时会提醒更新相关文档"
echo "   • 可以选择继续提交或先更新文档"
echo ""
echo "🧪 测试Git Hooks："
echo "   1. 创建测试文件: touch test-file.{{FILE_EXTENSION}}"
echo "   2. 添加到暂存: git add test-file.{{FILE_EXTENSION}}"
echo "   3. 尝试提交: git commit -m 'test: 测试hooks'"
echo "   4. 应该会看到文档更新提醒"
echo "   5. 清理测试: git reset HEAD~1 && rm test-file.{{FILE_EXTENSION}}"
echo ""

# 项目特定的设置
{{PROJECT_SPECIFIC_HOOK_SETUP}}

echo "🎉 Claude Code 会话连续性系统已就绪！"