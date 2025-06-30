FROM node:20

WORKDIR /app

# 复制依赖文件
COPY package*.json ./
COPY .npmrc ./
COPY client/package*.json ./client/

# 安装依赖时忽略警告
RUN npm config set loglevel error && \
    npm config set fund false && \
    npm config set audit false && \
    npm config set legacy-peer-deps true && \
    npm install --no-fund --no-audit && \
    cd client && npm install --no-fund --no-audit && cd ..

# 设置环境变量避免下载Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV NODE_ENV=production

# 安装Chromium依赖和网络工具
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
    ca-certificates \
    curl \
    wget \
    iputils-ping \
    net-tools \
    dnsutils \
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