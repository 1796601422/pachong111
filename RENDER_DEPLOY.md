# 知乎爬虫项目 - Render部署指南

本文档提供在Render云平台上部署知乎爬虫项目的详细步骤。

## 前提条件

- 一个Render账号（可以使用GitHub账号登录）
- 项目代码已推送到GitHub或GitLab等Git仓库

## 部署步骤

### 1. 创建新的Web服务

1. 登录Render控制台：https://dashboard.render.com
2. 点击"New +"按钮，选择"Web Service"
3. 连接您的Git仓库，选择包含项目代码的仓库
4. 填写以下信息：
   - **Name**: `zhihu-scraper`（或您喜欢的名称）
   - **Runtime**: `Node`
   - **Build Command**: `npm install && cd client && npm install && npm run build && cd ..`
   - **Start Command**: `node server.js`
5. 选择适合的实例类型（Free计划足够测试使用）
6. 点击"Create Web Service"按钮

### 2. 环境变量配置

部署完成后，您可能需要在Render控制台中配置以下环境变量：

- `NODE_ENV`: `production`
- `PORT`: `3000`（Render会自动设置这个变量）

### 3. 注意事项

- 免费计划的Render服务在15分钟不活动后会自动休眠
- 首次访问时可能需要等待服务启动（约30秒）
- 爬虫功能在云环境中可能会受到一些限制，特别是与浏览器相关的操作

### 4. 故障排除

如果部署后遇到问题：

1. 检查Render日志，查看具体错误信息
2. 确认puppeteer能够在无头模式下正常工作
3. 验证所有依赖都已正确安装

## 更新部署

每次推送到Git仓库的主分支时，Render会自动重新部署您的应用。 