# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 🚀 Session Startup Checklist

**When starting a new Claude Code session, please read these files in order:**

1. **CLAUDE.md** (this file) - Architecture and development guide
2. **docs/PROJECT_STATUS.md** - Current project status and recent changes
3. **docs/SESSION_HISTORY.md** - Previous session insights and decisions
4. **docs/KNOWN_ISSUES.md** - Current blockers and solutions
5. **docs/QUICK_REFERENCE.md** - Commands and patterns quick reference

**For specific areas, also read relevant module docs:**
- **docs/modules/[MODULE_NAME].md** - For module-specific work

**Before ending a session, please update:**
- `docs/SESSION_HISTORY.md` with key insights and decisions made
- `docs/PROJECT_STATUS.md` if project status changed
- `docs/KNOWN_ISSUES.md` if new issues discovered or resolved
- Relevant module docs if architectural changes made

**Git Hooks Setup:**
Run `./.githooks/setup.sh` to enable automatic documentation reminders during commits.

## Project Overview

**Project Name**: {{PROJECT_NAME}}  
**Project Type**: {{PROJECT_TYPE}}  
**Technology Stack**: {{TECH_STACK}}  
**Team Size**: {{TEAM_SIZE}}  
**Current Version**: {{PROJECT_VERSION}}

{{PROJECT_DESCRIPTION}}

## Architecture

### Technology Stack

**Core Technologies:**
{{CORE_TECH_DETAILS}}

**Development Tools:**
{{DEV_TOOLS}}

**Deployment:**
{{DEPLOYMENT_INFO}}

### Project Structure

```
{{PROJECT_ROOT}}/
├── {{PRIMARY_SOURCE_DIR}}/     # {{SOURCE_DESCRIPTION}}
├── {{CONFIG_DIR}}/             # Configuration files
├── {{DOCS_DIR}}/               # Documentation
└── {{BUILD_DIR}}/              # Build artifacts
```

## Development Commands

### Core Development
```bash
{{DEV_START_COMMAND}}           # Start development server
{{BUILD_COMMAND}}               # Build for production
{{TEST_COMMAND}}                # Run tests
{{LINT_COMMAND}}                # Code linting
```

### {{PROJECT_SPECIFIC_COMMANDS}}
```bash
{{CUSTOM_COMMAND_1}}            # {{COMMAND_1_DESCRIPTION}}
{{CUSTOM_COMMAND_2}}            # {{COMMAND_2_DESCRIPTION}}
```

## Key Architectural Patterns

### 1. {{PATTERN_1_NAME}}

**Description**: {{PATTERN_1_DESCRIPTION}}

**Implementation Pattern:**
```{{PATTERN_1_LANGUAGE}}
{{PATTERN_1_CODE_EXAMPLE}}
```

### 2. {{PATTERN_2_NAME}}

**Description**: {{PATTERN_2_DESCRIPTION}}

**Usage Guidelines:**
- {{GUIDELINE_1}}
- {{GUIDELINE_2}}

## Environment Configuration

**Required Environment Variables:**
```bash
{{ENV_VAR_1}}="{{ENV_VAR_1_DESCRIPTION}}"
{{ENV_VAR_2}}="{{ENV_VAR_2_DESCRIPTION}}"
```

**Optional Configuration:**
```bash
{{OPTIONAL_ENV_1}}="{{OPTIONAL_ENV_1_DESCRIPTION}}"
```

## Common Development Tasks

### {{COMMON_TASK_1}}
1. {{TASK_1_STEP_1}}
2. {{TASK_1_STEP_2}}
3. {{TASK_1_STEP_3}}

### {{COMMON_TASK_2}}
1. {{TASK_2_STEP_1}}
2. {{TASK_2_STEP_2}}

## Security and Best Practices

- {{SECURITY_PRACTICE_1}}
- {{SECURITY_PRACTICE_2}}
- {{BEST_PRACTICE_1}}
- {{BEST_PRACTICE_2}}

## Troubleshooting

**Common Issues:**

### Issue: {{COMMON_ISSUE_1}}
**Solution**: {{SOLUTION_1}}

### Issue: {{COMMON_ISSUE_2}}  
**Solution**: {{SOLUTION_2}}

**Debug Commands:**
```bash
{{DEBUG_COMMAND_1}}             # {{DEBUG_DESCRIPTION_1}}
{{DEBUG_COMMAND_2}}             # {{DEBUG_DESCRIPTION_2}}
```

---

*This file should be updated whenever there are significant architectural changes or new development patterns are established.*