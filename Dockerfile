FROM node:20

WORKDIR /app

# 复制依赖文件
COPY package*.json ./
COPY client/package*.json ./client/

# 安装依赖
RUN npm install && cd client && npm install && cd ..

# 设置环境变量避免下载Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV NODE_ENV=production

# 安装Chromium依赖
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# 设置Chromium路径
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 复制代码
COPY . .

# 构建前端
RUN cd client && npm run build

# 暴露端口
EXPOSE 3000

# 启动命令
CMD ["node", "server.js"] 