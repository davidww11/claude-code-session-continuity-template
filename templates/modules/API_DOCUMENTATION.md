# API 文档 | API Documentation

*{{PROJECT_NAME}} REST API 接口文档*

---

## 📋 API 概览

**基础信息**:
- **API版本**: {{API_VERSION}}
- **基础URL**: {{BASE_URL}}
- **文档版本**: {{DOC_VERSION}}
- **最后更新**: {{LAST_UPDATE}}

**认证方式**: {{AUTH_METHOD}}  
**数据格式**: JSON  
**字符编码**: UTF-8

---

## 🔐 认证授权

### 认证方式

#### {{AUTH_METHOD_1}}
```http
Authorization: {{AUTH_HEADER_EXAMPLE}}
```

**获取Token**:
```http
POST {{BASE_URL}}/auth/login
Content-Type: application/json

{
  "{{USERNAME_FIELD}}": "{{USERNAME_EXAMPLE}}",
  "{{PASSWORD_FIELD}}": "{{PASSWORD_EXAMPLE}}"
}
```

**响应**:
```json
{
  "token": "{{TOKEN_EXAMPLE}}",
  "expires_in": {{TOKEN_EXPIRES}},
  "refresh_token": "{{REFRESH_TOKEN_EXAMPLE}}"
}
```

#### 权限范围
| 权限级别 | 描述 | 访问范围 |
|----------|------|----------|
| {{PERMISSION_1}} | {{PERMISSION_1_DESC}} | {{PERMISSION_1_SCOPE}} |
| {{PERMISSION_2}} | {{PERMISSION_2_DESC}} | {{PERMISSION_2_SCOPE}} |
| {{PERMISSION_3}} | {{PERMISSION_3_DESC}} | {{PERMISSION_3_SCOPE}} |

---

## 📊 通用响应格式

### 成功响应
```json
{
  "success": true,
  "data": {
    // 具体数据内容
  },
  "message": "{{SUCCESS_MESSAGE}}",
  "timestamp": "{{TIMESTAMP_FORMAT}}"
}
```

### 错误响应
```json
{
  "success": false,
  "error": {
    "code": "{{ERROR_CODE}}",
    "message": "{{ERROR_MESSAGE}}",
    "details": "{{ERROR_DETAILS}}"
  },
  "timestamp": "{{TIMESTAMP_FORMAT}}"
}
```

### 分页响应
```json
{
  "success": true,
  "data": {
    "items": [
      // 数据列表
    ],
    "pagination": {
      "page": {{CURRENT_PAGE}},
      "limit": {{PAGE_SIZE}},
      "total": {{TOTAL_COUNT}},
      "pages": {{TOTAL_PAGES}}
    }
  }
}
```

---

## 🔍 {{RESOURCE_1}} 接口

### 获取{{RESOURCE_1}}列表

```http
GET {{BASE_URL}}/{{RESOURCE_1_ENDPOINT}}
```

**查询参数**:
| 参数 | 类型 | 必需 | 默认值 | 描述 |
|------|------|------|--------|------|
| `page` | integer | 否 | 1 | 页码 |
| `limit` | integer | 否 | 20 | 每页数量 |
| `{{FILTER_PARAM_1}}` | {{PARAM_TYPE_1}} | 否 | - | {{PARAM_DESC_1}} |
| `{{FILTER_PARAM_2}}` | {{PARAM_TYPE_2}} | 否 | - | {{PARAM_DESC_2}} |

**请求示例**:
```http
GET {{BASE_URL}}/{{RESOURCE_1_ENDPOINT}}?page=1&limit=10&{{FILTER_PARAM_1}}={{FILTER_VALUE_1}}
Authorization: {{AUTH_HEADER_EXAMPLE}}
```

**响应示例**:
```json
{
  "success": true,
  "data": {
    "items": [
      {
        "{{FIELD_1}}": "{{FIELD_1_VALUE}}",
        "{{FIELD_2}}": "{{FIELD_2_VALUE}}",
        "{{FIELD_3}}": {{FIELD_3_VALUE}},
        "created_at": "{{TIMESTAMP_EXAMPLE}}",
        "updated_at": "{{TIMESTAMP_EXAMPLE}}"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 10,
      "total": {{TOTAL_EXAMPLE}},
      "pages": {{PAGES_EXAMPLE}}
    }
  }
}
```

### 获取单个{{RESOURCE_1}}

```http
GET {{BASE_URL}}/{{RESOURCE_1_ENDPOINT}}/{{RESOURCE_ID}}
```

**路径参数**:
- `{{RESOURCE_ID}}` ({{ID_TYPE}}): {{RESOURCE_1}}的唯一标识符

**响应示例**:
```json
{
  "success": true,
  "data": {
    "{{FIELD_1}}": "{{FIELD_1_VALUE}}",
    "{{FIELD_2}}": "{{FIELD_2_VALUE}}",
    "{{FIELD_3}}": {{FIELD_3_VALUE}},
    "{{NESTED_OBJECT}}": {
      "{{NESTED_FIELD_1}}": "{{NESTED_VALUE_1}}",
      "{{NESTED_FIELD_2}}": {{NESTED_VALUE_2}}
    },
    "created_at": "{{TIMESTAMP_EXAMPLE}}",
    "updated_at": "{{TIMESTAMP_EXAMPLE}}"
  }
}
```

### 创建{{RESOURCE_1}}

```http
POST {{BASE_URL}}/{{RESOURCE_1_ENDPOINT}}
Content-Type: application/json
```

**请求体**:
```json
{
  "{{REQUIRED_FIELD_1}}": "{{REQUIRED_VALUE_1}}",
  "{{REQUIRED_FIELD_2}}": "{{REQUIRED_VALUE_2}}",
  "{{OPTIONAL_FIELD_1}}": "{{OPTIONAL_VALUE_1}}"
}
```

**字段说明**:
| 字段 | 类型 | 必需 | 验证规则 | 描述 |
|------|------|------|----------|------|
| `{{REQUIRED_FIELD_1}}` | {{FIELD_TYPE_1}} | 是 | {{VALIDATION_RULE_1}} | {{FIELD_DESC_1}} |
| `{{REQUIRED_FIELD_2}}` | {{FIELD_TYPE_2}} | 是 | {{VALIDATION_RULE_2}} | {{FIELD_DESC_2}} |
| `{{OPTIONAL_FIELD_1}}` | {{FIELD_TYPE_3}} | 否 | {{VALIDATION_RULE_3}} | {{FIELD_DESC_3}} |

**响应示例** (201 Created):
```json
{
  "success": true,
  "data": {
    "{{ID_FIELD}}": "{{GENERATED_ID}}",
    "{{REQUIRED_FIELD_1}}": "{{REQUIRED_VALUE_1}}",
    "{{REQUIRED_FIELD_2}}": "{{REQUIRED_VALUE_2}}",
    "created_at": "{{TIMESTAMP_EXAMPLE}}"
  },
  "message": "{{RESOURCE_1}} created successfully"
}
```

### 更新{{RESOURCE_1}}

```http
PUT {{BASE_URL}}/{{RESOURCE_1_ENDPOINT}}/{{RESOURCE_ID}}
Content-Type: application/json
```

**请求体** (部分更新):
```json
{
  "{{UPDATABLE_FIELD_1}}": "{{NEW_VALUE_1}}",
  "{{UPDATABLE_FIELD_2}}": {{NEW_VALUE_2}}
}
```

**响应示例**:
```json
{
  "success": true,
  "data": {
    "{{ID_FIELD}}": "{{RESOURCE_ID}}",
    "{{UPDATABLE_FIELD_1}}": "{{NEW_VALUE_1}}",
    "{{UPDATABLE_FIELD_2}}": {{NEW_VALUE_2}},
    "updated_at": "{{TIMESTAMP_EXAMPLE}}"
  },
  "message": "{{RESOURCE_1}} updated successfully"
}
```

### 删除{{RESOURCE_1}}

```http
DELETE {{BASE_URL}}/{{RESOURCE_1_ENDPOINT}}/{{RESOURCE_ID}}
```

**响应示例** (204 No Content):
```json
{
  "success": true,
  "message": "{{RESOURCE_1}} deleted successfully"
}
```

---

## 🔗 {{RESOURCE_2}} 接口

### 批量操作

#### 批量创建
```http
POST {{BASE_URL}}/{{RESOURCE_2_ENDPOINT}}/batch
Content-Type: application/json
```

**请求体**:
```json
{
  "items": [
    {
      "{{FIELD_1}}": "{{VALUE_1}}",
      "{{FIELD_2}}": "{{VALUE_2}}"
    },
    {
      "{{FIELD_1}}": "{{VALUE_3}}",
      "{{FIELD_2}}": "{{VALUE_4}}"
    }
  ]
}
```

**响应示例**:
```json
{
  "success": true,
  "data": {
    "created": [
      {
        "{{ID_FIELD}}": "{{ID_1}}",
        "{{FIELD_1}}": "{{VALUE_1}}"
      }
    ],
    "failed": [
      {
        "index": 1,
        "error": "{{ERROR_MESSAGE}}"
      }
    ]
  },
  "message": "Batch operation completed"
}
```

### 高级查询

#### 复合查询
```http
POST {{BASE_URL}}/{{RESOURCE_2_ENDPOINT}}/search
Content-Type: application/json
```

**请求体**:
```json
{
  "filters": {
    "{{FILTER_FIELD_1}}": {
      "operator": "{{OPERATOR}}",
      "value": "{{FILTER_VALUE}}"
    },
    "{{FILTER_FIELD_2}}": {
      "operator": "in",
      "value": ["{{VALUE_1}}", "{{VALUE_2}}"]
    }
  },
  "sort": [
    {
      "field": "{{SORT_FIELD}}",
      "direction": "{{SORT_DIRECTION}}"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20
  }
}
```

**支持的操作符**:
- `eq`: 等于
- `ne`: 不等于
- `gt`: 大于
- `gte`: 大于等于
- `lt`: 小于
- `lte`: 小于等于
- `in`: 包含在列表中
- `like`: 模糊匹配

---

## 📁 文件上传接口

### 单文件上传

```http
POST {{BASE_URL}}/files/upload
Content-Type: multipart/form-data
```

**表单字段**:
- `file`: 要上传的文件
- `category`: 文件分类 (可选)
- `description`: 文件描述 (可选)

**响应示例**:
```json
{
  "success": true,
  "data": {
    "file_id": "{{FILE_ID}}",
    "filename": "{{ORIGINAL_FILENAME}}",
    "url": "{{FILE_URL}}",
    "size": {{FILE_SIZE}},
    "type": "{{MIME_TYPE}}",
    "uploaded_at": "{{TIMESTAMP_EXAMPLE}}"
  }
}
```

### 多文件上传

```http
POST {{BASE_URL}}/files/upload/multiple
Content-Type: multipart/form-data
```

**响应示例**:
```json
{
  "success": true,
  "data": {
    "uploaded": [
      {
        "file_id": "{{FILE_ID_1}}",
        "filename": "{{FILENAME_1}}",
        "url": "{{FILE_URL_1}}"
      }
    ],
    "failed": [
      {
        "filename": "{{FAILED_FILENAME}}",
        "error": "{{ERROR_MESSAGE}}"
      }
    ]
  }
}
```

---

## ⚠️ 错误代码

### HTTP 状态码

| 状态码 | 含义 | 描述 |
|--------|------|------|
| 200 | OK | 请求成功 |
| 201 | Created | 资源创建成功 |
| 204 | No Content | 请求成功，无返回内容 |
| 400 | Bad Request | 请求参数错误 |
| 401 | Unauthorized | 未认证或认证失败 |
| 403 | Forbidden | 权限不足 |
| 404 | Not Found | 资源不存在 |
| 409 | Conflict | 资源冲突 |
| 422 | Unprocessable Entity | 参数验证失败 |
| 429 | Too Many Requests | 请求频率限制 |
| 500 | Internal Server Error | 服务器内部错误 |

### 业务错误代码

| 错误代码 | 描述 | 解决方案 |
|----------|------|----------|
| `{{ERROR_CODE_1}}` | {{ERROR_DESC_1}} | {{ERROR_SOLUTION_1}} |
| `{{ERROR_CODE_2}}` | {{ERROR_DESC_2}} | {{ERROR_SOLUTION_2}} |
| `{{ERROR_CODE_3}}` | {{ERROR_DESC_3}} | {{ERROR_SOLUTION_3}} |

---

## 🚦 限流规则

### 请求频率限制

| 端点类型 | 限制 | 时间窗口 | 超限行为 |
|----------|------|----------|----------|
| 认证接口 | {{AUTH_RATE_LIMIT}} | {{AUTH_TIME_WINDOW}} | {{AUTH_LIMIT_ACTION}} |
| 查询接口 | {{QUERY_RATE_LIMIT}} | {{QUERY_TIME_WINDOW}} | {{QUERY_LIMIT_ACTION}} |
| 写入接口 | {{WRITE_RATE_LIMIT}} | {{WRITE_TIME_WINDOW}} | {{WRITE_LIMIT_ACTION}} |

### 响应头
```http
X-RateLimit-Limit: {{RATE_LIMIT}}
X-RateLimit-Remaining: {{REMAINING_REQUESTS}}
X-RateLimit-Reset: {{RESET_TIMESTAMP}}
```

---

## 🧪 测试指南

### API 测试工具

#### cURL 示例
```bash
# 获取访问令牌
curl -X POST "{{BASE_URL}}/auth/login" \
  -H "Content-Type: application/json" \
  -d '{
    "{{USERNAME_FIELD}}": "{{TEST_USERNAME}}",
    "{{PASSWORD_FIELD}}": "{{TEST_PASSWORD}}"
  }'

# 使用令牌访问API
curl -X GET "{{BASE_URL}}/{{RESOURCE_1_ENDPOINT}}" \
  -H "Authorization: Bearer {{TEST_TOKEN}}"
```

#### Postman 集合
```json
{
  "info": {
    "name": "{{PROJECT_NAME}} API",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Authentication",
      "request": {
        "method": "POST",
        "header": [],
        "body": {
          "mode": "raw",
          "raw": "{{AUTH_REQUEST_EXAMPLE}}"
        },
        "url": "{{BASE_URL}}/auth/login"
      }
    }
  ]
}
```

### 测试环境

| 环境 | 基础URL | 用途 |
|------|---------|------|
| 开发 | {{DEV_BASE_URL}} | 开发测试 |
| 测试 | {{TEST_BASE_URL}} | 功能测试 |
| 预发布 | {{STAGING_BASE_URL}} | 集成测试 |

---

## 📚 SDK 和示例

### JavaScript SDK
```javascript
// 安装
npm install {{SDK_PACKAGE_NAME}}

// 使用示例
import {{SDK_CLASS_NAME}} from '{{SDK_PACKAGE_NAME}}';

const client = new {{SDK_CLASS_NAME}}({
  baseURL: '{{BASE_URL}}',
  apiKey: 'your-api-key'
});

// 获取资源列表
const {{RESOURCE_VAR}} = await client.{{RESOURCE_1_ENDPOINT}}.list({
  page: 1,
  limit: 10
});
```

### Python SDK
```python
# 安装
pip install {{PYTHON_SDK_PACKAGE}}

# 使用示例
from {{PYTHON_SDK_MODULE}} import {{PYTHON_SDK_CLASS}}

client = {{PYTHON_SDK_CLASS}}(
    base_url='{{BASE_URL}}',
    api_key='your-api-key'
)

# 获取资源列表
{{RESOURCE_VAR}} = client.{{RESOURCE_1_ENDPOINT}}.list(page=1, limit=10)
```

---

## 📝 更新日志

### {{API_VERSION}} ({{RELEASE_DATE}})
- ✅ {{FEATURE_1}}
- ✅ {{FEATURE_2}}
- 🔧 {{IMPROVEMENT_1}}
- 🐛 {{BUGFIX_1}}

### {{PREVIOUS_VERSION}} ({{PREVIOUS_DATE}})
- ✅ {{PREVIOUS_FEATURE_1}}
- 🐛 {{PREVIOUS_BUGFIX_1}}

---

## 🤝 支持和反馈

### 获取帮助
- **技术支持**: {{SUPPORT_EMAIL}}
- **文档问题**: {{DOCS_EMAIL}}
- **Bug报告**: {{BUG_REPORT_URL}}

### 社区资源
- **开发者论坛**: {{FORUM_URL}}
- **GitHub仓库**: {{GITHUB_URL}}
- **示例代码**: {{EXAMPLES_URL}}

---

**API文档版本**: {{DOC_VERSION}}  
**API版本**: {{API_VERSION}}  
**最后更新**: {{LAST_UPDATE}}  
**维护团队**: {{MAINTAINER_TEAM}}

**注意**: API变更会提前通知，重大变更需要版本升级。