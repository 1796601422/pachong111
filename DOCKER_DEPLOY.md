# 知乎爬虫项目 - Docker部署指南

本文档提供使用Docker将知乎爬虫项目部署到Render云平台的详细步骤。

## 前提条件

- 一个Render账号（可以使用GitHub账号登录）
- 项目代码已推送到GitHub或GitLab等Git仓库，包含Dockerfile

## 部署步骤

### 1. 创建新的Web服务

1. 登录Render控制台：https://dashboard.render.com
2. 点击"New +"按钮，选择"Web Service"
3. 连接您的Git仓库，选择包含项目代码的仓库
4. 填写以下信息：
   - **Name**: `zhihu-scraper`（或您喜欢的名称）
   - **Runtime**: `Docker`
   - 其他设置保持默认值
5. 选择适合的实例类型（Free计划足够测试使用）
6. 点击"Create Web Service"按钮

### 2. 环境变量配置

部署完成后，您可能需要在Render控制台中配置以下环境变量（如果没有自动从render.yaml中读取）：

- `NODE_ENV`: `production`
- `PORT`: `3000`（Render会自动设置这个变量）
- `PUPPETEER_SKIP_CHROMIUM_DOWNLOAD`: `true`
- `PUPPETEER_EXECUTABLE_PATH`: `/usr/bin/chromium`

### 3. 注意事项

- 首次构建可能需要较长时间（5-10分钟），因为需要下载Node.js镜像和安装依赖
- 免费计划的Render服务在15分钟不活动后会自动休眠
- 首次访问时可能需要等待服务启动（约30秒）

### 4. 故障排除

如果部署后遇到问题：

1. **检查Render日志**：在Render控制台中查看构建和运行日志
2. **容器内调试**：可以通过添加临时的Shell命令来检查容器内环境
3. **浏览器问题**：确认Chromium是否正确安装，路径是否正确设置
4. **内存限制**：如果遇到内存不足错误，可能需要优化代码或升级到付费计划

## 本地测试Docker镜像

在推送到Render之前，您可以在本地测试Docker镜像：

```bash
# 构建镜像
docker build -t zhihu-scraper .

# 运行容器
docker run -p 3000:3000 zhihu-scraper
```

## 更新部署

每次推送到Git仓库的主分支时，Render会自动重新构建Docker镜像并部署。

## Docker镜像优化

如果构建时间过长或镜像过大，可以考虑：

1. 使用多阶段构建减小镜像大小
2. 优化依赖安装顺序，利用Docker缓存
3. 使用Alpine版本的Node.js基础镜像减小体积 