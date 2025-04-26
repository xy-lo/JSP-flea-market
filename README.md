# 二手交易平台

![GitHub last commit](https://img.shields.io/github/last-commit/yourusername/second-hand-trading)
![GitHub](https://img.shields.io/github/license/yourusername/second-hand-trading)
![GitHub stars](https://img.shields.io/github/stars/yourusername/second-hand-trading?style=social)

一个基于Java Web技术栈的校园二手交易平台，提供商品发布、浏览、收藏、留言等功能，帮助校园用户便捷地进行二手物品交易。

## 项目概览

这是一个专为校园环境设计的二手交易平台，旨在为大学生提供一个安全、便捷的二手物品交易环境。系统支持用户注册登录、商品发布与管理、商品搜索、收藏管理以及用户间留言交流等功能。

### 功能特点

- **用户管理**：注册、登录、权限分级（普通用户/管理员）
- **商品操作**：发布、修改、删除、查询商品
- **收藏系统**：收藏感兴趣的商品，快速访问
- **留言功能**：对商品进行留言咨询，促进用户交流
- **搜索筛选**：多维度商品搜索与筛选
- **响应式设计**：适配不同设备屏幕，提供良好的移动端体验

### 项目截图

#### 登录界面
![登录界面](./screenshots/login.png)

#### 主界面
![主界面](./screenshots/main.png)

#### 我的商品
![我的商品](./screenshots/my_items.png)

#### 商品详情
![商品详情](./screenshots/item_detail1.png)
![商品详情](./screenshots/item_detail2.png)
## 技术栈

### 前端
- HTML5 + CSS3 + JavaScript
- jQuery
- Bootstrap（响应式布局）

### 后端
- Java Servlet
- JSP (JavaServer Pages)
- JDBC (Java Database Connectivity)

### 数据库
- MySQL 5.7+

### 开发与部署环境
- JDK 8+
- Tomcat 8+
- XAMPP/WAMP/MAMP (本地开发)

## 快速开始

### 环境准备
1. 安装JDK 8或更高版本
2. 安装Tomcat 8或更高版本
3. 安装MySQL 5.7或更高版本
4. 安装IDE（推荐IntelliJ IDEA或Eclipse）

### 安装步骤
1. 克隆仓库到本地
   ```bash
   git clone https://github.com/yourusername/second-hand-trading.git
   ```

2. 导入项目到IDE中
   - 对于IntelliJ IDEA：File -> Open -> 选择项目目录
   - 对于Eclipse：File -> Import -> Existing Maven Projects -> 选择项目目录

3. 导入数据库
   ```sql
   CREATE DATABASE second_hand_trading;
   USE second_hand_trading;
   SOURCE /path/to/project/database/init.sql;
   ```

4. 配置数据库连接
   - 打开`src/main/resources/db.properties`
   - 修改数据库连接参数（URL、用户名、密码）

5. 部署到Tomcat
   - 配置Tomcat服务器
   - 部署项目
   - 启动Tomcat

6. 访问应用
   - 打开浏览器访问：`http://localhost:8080/second-hand-trading`

### 预设账户
- 管理员：username: admin, password: admin123
- 测试用户：username: testuser, password: test123

## 项目结构

```
second-hand-trading/
├── src/
│   ├── main/
│   │   ├── java/            # Java源代码
│   │   │   ├── controller/  # Servlet控制器
│   │   │   ├── dao/         # 数据访问对象
│   │   │   ├── model/       # 数据模型
│   │   │   ├── service/     # 业务逻辑
│   │   │   └── util/        # 工具类
│   │   ├── resources/       # 配置文件
│   │   └── webapp/          # Web资源
│   │       ├── css/         # 样式文件
│   │       ├── js/          # JavaScript文件
│   │       ├── images/      # 图片资源
│   │       ├── uploads/     # 用户上传文件
│   │       └── WEB-INF/     # JSP页面和配置
├── database/                # 数据库脚本
├── docs/                    # 项目文档
└── README.md               # 项目说明
```

## 数据库设计

### 主要表结构

- **Users表**：用户信息（用户名、密码、联系方式、邮箱、用户类型）
- **Items表**：商品信息（名称、描述、价格、成色、状态、图片路径）
- **Messages表**：留言信息（商品ID、发送者ID、内容、时间）
- **Collections表**：收藏记录（用户ID、商品ID、收藏时间）

## 功能亮点

### 用户体验优化
- 响应式设计，适配各种设备
- 界面美观，操作直观
- 表单验证确保数据有效性

### 安全性考虑
- 密码加密存储
- 输入验证防止SQL注入
- 权限控制保障数据安全

### 实用功能
- 多条件组合搜索
- 商品状态管理（在售/已售）
- 留言互动功能

## 扩展与优化方向

- [ ] 集成支付功能
- [ ] 添加用户评价系统
- [ ] 开发移动端App
- [ ] 引入消息推送功能
- [ ] 实现商品推荐算法

## 常见问题

### 图片上传失败
- 确保uploads目录有正确的写入权限
- 检查配置的最大上传文件大小限制

### 数据库连接错误
- 验证数据库连接参数是否正确
- 确认MySQL服务是否正常运行

## 贡献指南

欢迎提交Pull Request或Issue来帮助改进这个项目！

1. Fork本仓库
2. 创建您的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个Pull Request

## 许可证

该项目采用MIT许可证 - 详情请见 [LICENSE](LICENSE) 文件

## 联系方式

项目维护者 - [Your Name](https://github.com/yourusername)

项目链接：[https://github.com/yourusername/second-hand-trading](https://github.com/yourusername/second-hand-trading)
