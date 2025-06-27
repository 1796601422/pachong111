// API基础URL配置
const config = {
  // 在开发环境中，使用相对路径
  // 在生产环境中，使用API的完整URL（如果前后端部署在同一域名下，可以继续使用相对路径）
  apiBaseUrl: process.env.NODE_ENV === 'production' ? '' : ''
};

export default config; 