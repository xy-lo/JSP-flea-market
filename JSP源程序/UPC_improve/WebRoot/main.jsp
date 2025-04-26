<%@ page language="java"  contentType="text/html;charset=utf-8" import="java.util.*,java.sql.*,MyBean.*" pageEncoding="UTF-8"%>
<html>
<head>
    <title>UPC二手交易平台</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style>
	  /* 全局基础设置：字体、内外边距、盒模型 */
	  * {
	    margin: 0;
	    padding: 0;
	    box-sizing: border-box;
	    font-family: '楷体', 'KaiTi', 'STKaiti', serif;
	  }
	
	  /* 页面背景与文字颜色 */
	  body {
	    background-color: #f5f1e6; /* 米白色背景 */
	    color: #333;
	  }
	
	  /* 顶部标题栏 */
	  .header {
	    background: linear-gradient(135deg, #5d9eee, #3a7bd5); /* 浅蓝渐变 */
	    padding: 15px 20px;
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    position: sticky;
	    top: 0;
	    z-index: 100;
	    box-shadow: 0 4px 12px rgba(58, 123, 213, 0.2);
	  }
	
	  .logo {
	    color: #fff;
	    font-size: 36px;
	    font-weight: bold;
	    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
	  }
	
	  .user-info {
	    color: #fff;
	    font-size: 24px;
	    
	    padding: 8px 16px;
	    border-radius: 20px;
	    flex: 0.8; /* 比例稍大一点，偏左中 */
	  }
	
	
	  /* 退出按钮 */
	  .exit-btn {
	    background-color: #fff;
	    color: #0a2463;
	    border: none;
	    padding: 10px 18px;
	    border-radius: 25px;
	    cursor: pointer;
	    font-weight: bold;
	    font-size: 20px;
	    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	    transition: 0.3s;
	  }
	
	  .exit-btn:hover {
	    background-color: #f0f0f0;
	    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
	    transform: translateY(-2px);
	  }
	
	  /* 主容器，控制宽度与边界 */
	  .container {
	    max-width: 1100px;
	    margin: 30px auto;
	    padding: 20px;
	    background-color: #f9f6f0;
	    border-radius: 10px;
	    box-shadow: 0 2px 10px rgba(0,0,0,0.03); /* 柔和边框 */
	  }
	
	  /* 小节标题 */
	  .section-title {
	    font-size: 32px;
	    font-weight: bold;
	    color: #3a7bd5;
	    position: relative;
	    margin-bottom: 25px;
	    display: inline-block;
	    padding-bottom: 10px;
	  }
	
	  .section-title::after {
	    content: '';
	    position: absolute;
	    bottom: 0;
	    left: 0;
	    width: 60%;
	    height: 4px;
	    background: linear-gradient(to right, #3a7bd5, transparent);
	    border-radius: 2px;
	  }
	
	  /* 商品展示区 */
	  .items-grid {
	    display: grid;
	    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
	    gap: 25px;
	    margin-top: 20px;
	  }
	
	  .item-card {
	    background-color: #fff;
	    border-radius: 16px;
	    overflow: hidden;
	    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
	    transition: 0.4s ease;
	  }
	
	  .item-card:hover {
	    transform: translateY(-8px);
	    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
	  }
	
	  .item-image {
	    width: 100%;
	    height: 300px;
	    object-fit: cover;
	    transition: transform 0.5s ease;
	  }
	
	  .item-card:hover .item-image {
	    transform: scale(1.05);
	  }
	
	  .item-info {
	    padding: 20px;
	  }
	
	  .item-name {
	    font-size: 18px;
	    font-weight: bold;
	    color: #0a2463;
	    margin-bottom: 8px;
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	  }
	
	  .item-price {
	    color: #1e3a8a;
	    font-size: 22px;
	    font-weight: bold;
	    margin-bottom: 10px;
	  }
	
	  .item-desc {
	    font-size: 14px;
	    color: #555;
	    line-height: 1.5;
	    margin: 12px 0;
	    display: -webkit-box;
	    -webkit-line-clamp: 2;
	    -webkit-box-orient: vertical;
	    overflow: hidden;
	  }
	
	  .item-meta {
	    display: flex;
	    justify-content: space-between;
	    font-size: 13px;
	    color: #777;
	    margin-top: 12px;
	    border-top: 1px solid #eee;
	    padding-top: 12px;
	  }
	
	  .view-details {
	    background-color: #0a2463;
	    color: #fff;
	    text-align: center;
	    padding: 8px 16px;
	    border-radius: 20px;
	    margin-top: 15px;
	    display: block;
	    font-weight: 500;
	    transition: 0.3s ease;
	    text-decoration: none; /* 去掉下划线 */
	  }
	
	  .view-details:hover {
	    background-color: #1e3a8a;
	    transform: translateY(-2px);
	  }
	
	  .no-items {
	    grid-column: 1 / -1;
	    text-align: center;
	    padding: 80px 0;
	    background-color: #eff6ff;
	    color: #2563eb;
	    border-radius: 16px;
	    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
	  }
	  /* 收藏图标样式 */
      .favorite-btn {
        position: absolute;
        top: 15px;
        right: 15px;
        width: 36px;
        height: 36px;
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        z-index: 10;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        border: none;
      }
      
      .favorite-btn:hover {
        transform: scale(1.1);
      }
      
      .favorite-btn i {
		  font-size: 20px;
		  color: #ff4757; /* 将默认颜色也改为红色 */
		}
		
		/* 空心样式 */
		.favorite-btn i.far {
		  color: #ff4757; /* 红色边框 */
		}
		
		/* 实心样式 */
		.favorite-btn i.fas {
		  color: #ff4757; /* 红色填充 */
		}
      
      /* 商品卡片添加相对定位 */
      .item-card {
        position: relative;
      }
	
	  /* 提示框样式 */
      .toast {
        position: fixed;
        bottom: 20px;
        left: 50%;
        transform: translateX(-50%);
        background-color: rgba(0, 0, 0, 0.7);
        color: white;
        padding: 12px 24px;
        border-radius: 25px;
        z-index: 9999;
        font-size: 16px;
        opacity: 0;
        transition: opacity 0.3s ease;
      }
      
      .toast.show {
        opacity: 1;
      }
	
	  /* 自定义滚动条 */
	  ::-webkit-scrollbar {
	    width: 8px;
	  }
	
	  ::-webkit-scrollbar-thumb {
	    background: rgba(10, 36, 99, 0.4);
	    border-radius: 10px;
	  }
	
	  ::-webkit-scrollbar-thumb:hover {
	    background: rgba(10, 36, 99, 0.7);
	  }
	
	  /* 响应式调整 */
	  @media (max-width: 768px) {
	    .header {
	      flex-direction: column;
	      align-items: flex-start;
	      gap: 15px;
	    }
	
	    .nav {
	      flex-wrap: nowrap;
	      overflow-x: auto;
	    }
	  }
	</style>
	 <!-- 引入Font Awesome图标库 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
<%
    String flag = (String)session.getAttribute("flag");
    if(flag==null || !"success".equals(flag)) response.sendRedirect("error.jsp");
    String uname = (String)session.getAttribute("uname");
    // 为避免空指针错误，先初始化响应变量
    String resultMessage = "";
    String resultStatus = "";
    
    // 处理收藏请求
    if(request.getParameter("action") != null && request.getParameter("action").equals("favorite")) {
        String itemid = request.getParameter("itemid");
        String operation = request.getParameter("operation"); // add或remove
        boolean success = false;
        
        System.out.println("收到收藏请求: itemid=" + itemid + ", operation=" + operation + ", username=" + uname);
        
        if(itemid != null && !itemid.isEmpty()) {
            sqlBean db = new sqlBean();
            try {
                // 检查是否已经收藏
                String checkSql = "SELECT * FROM collection WHERE username = ? AND itemid = ?";
                PreparedStatement checkStmt = db.getPreparedStatement(checkSql);
                checkStmt.setString(1, uname);
                checkStmt.setString(2, itemid);
                ResultSet rs = checkStmt.executeQuery();
                boolean exists = rs.next();
                rs.close();
                checkStmt.close();
                
                System.out.println("商品是否已收藏: " + exists);
                
                // 根据操作和现有状态执行不同的SQL
                if("add".equals(operation) && !exists) {
                    // 添加收藏
                    String insertSql = "INSERT INTO collection (username, itemid, collectdate) VALUES (?, ?, NOW())";
                    PreparedStatement insertStmt = db.getPreparedStatement(insertSql);
                    insertStmt.setString(1, uname);
                    insertStmt.setString(2, itemid);
                    int result = insertStmt.executeUpdate();
                    insertStmt.close();
                    
                    System.out.println("添加收藏结果: " + result + "行受影响");
                    
                    if(result > 0) {
                        success = true;
                        resultMessage = "收藏成功！";
                        resultStatus = "success";
                    } else {
                        resultMessage = "收藏失败，请稍后再试";
                        resultStatus = "error";
                    }
                } else if("remove".equals(operation) && exists) {
                    // 取消收藏
                    String deleteSql = "DELETE FROM collection WHERE username = ? AND itemid = ?";
                    PreparedStatement deleteStmt = db.getPreparedStatement(deleteSql);
                    deleteStmt.setString(1, uname);
                    deleteStmt.setString(2, itemid);
                    int result = deleteStmt.executeUpdate();
                    deleteStmt.close();
                    
                    System.out.println("取消收藏结果: " + result + "行受影响");
                    
                    if(result > 0) {
                        success = true;
                        resultMessage = "已取消收藏！";
                        resultStatus = "success";
                    } else {
                        resultMessage = "取消收藏失败，请稍后再试";
                        resultStatus = "error";
                    }
                } else if("add".equals(operation) && exists) {
                    // 已经收藏过了
                    success = true;
                    resultMessage = "该商品已在收藏列表中";
                    resultStatus = "info";
                } else if("remove".equals(operation) && !exists) {
                    // 本来就没收藏
                    success = true;
                    resultMessage = "该商品未收藏";
                    resultStatus = "info";
                }
                
                // 如果是AJAX请求，返回JSON响应
                if(request.getHeader("X-Requested-With") != null && 
                   request.getHeader("X-Requested-With").equals("XMLHttpRequest")) {
                    response.setContentType("application/json;charset=UTF-8");
                    response.setHeader("Cache-Control", "no-cache");
                    // 关键修复：清空输出缓冲区，确保没有其他内容
                    out.clearBuffer();
                    // 使用JSONObject构建响应更安全，但这里简单地用字符串拼接
                    out.print("{\"success\":" + success + ", \"message\":\"" + resultMessage.replace("\"", "\\\"") + "\"}");
                    out.flush();
                    // 提前结束页面执行
                    return;
                }
            } catch(SQLException e) {
                e.printStackTrace();
                System.out.println("数据库错误: " + e.getMessage());
                resultMessage = "操作失败：" + e.getMessage();
                resultStatus = "error";
                
                // 返回错误JSON
                if(request.getHeader("X-Requested-With") != null && 
                   request.getHeader("X-Requested-With").equals("XMLHttpRequest")) {
                    response.setContentType("application/json;charset=UTF-8");
                    response.setHeader("Cache-Control", "no-cache");
                    out.clearBuffer();
                    out.print("{\"success\":false, \"message\":\"数据库错误\"}");
                    out.flush();
                    return;
                }
            } finally {
                db.closeDB();
            }
        }
    }
%>
    
    <div class="header">
        <div class="logo">UPC二手交易平台</div>
        <div class="user-info">
        <%String role = (String) session.getAttribute("role");
          if ("admin".equals(role)) {%>
            管理员：<%= uname %>
        <%} else {%>
            当前用户：<%= uname %>
        <%}%>
        </div>
            
        <button class="exit-btn" onclick="window.location.href='infolr.jsp'">商品录入</button>
        <button class="exit-btn" onclick="window.location.href='infocx.jsp'">商品查询</button>
        <button class="exit-btn" onclick="window.location.href='mycollection.jsp'">我的收藏</button>
        <button class="exit-btn" onclick="window.location.href='myitems.jsp'">我的商品</button>
        <button class="exit-btn" onclick="window.location.href='exit.jsp'">退出系统</button>
    </div>
    
    <!-- 提示框 -->
    <div id="toast" class="toast"></div>
    
    <div class="container">
        <h2 class="section-title">当前商品</h2>
        
        <div class="items-grid">
            <% 
                String sql = "SELECT * FROM item WHERE status='available' ORDER BY itemid DESC";
                sqlBean db = new sqlBean();
                ResultSet rs = db.executeQuery(sql);
                boolean hasItems = false;
                
                while(rs.next()) {
                    hasItems = true;
                    String itemId = rs.getString("itemid");
                    String itemName = rs.getString("itemname");
                    String description = rs.getString("description");
                    String price = rs.getString("price");
                    String condition = rs.getString("condition");
                    String itemUsername = rs.getString("username");
                    String photoPath = rs.getString("photo");
                    
                    // 检查当前用户是否已收藏该商品
                    boolean isFavorited = false;
                    String checkFavSql = "SELECT * FROM collection WHERE username = ? AND itemid = ?";
                    PreparedStatement checkFavStmt = db.getPreparedStatement(checkFavSql);
                    checkFavStmt.setString(1, uname);
                    checkFavStmt.setString(2, itemId);
                    ResultSet favRs = checkFavStmt.executeQuery();
                    isFavorited = favRs.next();
                    favRs.close();
                    checkFavStmt.close();
                    
                    // 如果没有图片路径，使用默认图片
                    if(photoPath == null || photoPath.trim().isEmpty()) {
                        photoPath = "images/default-item.jpg";
                    }
                    
                    // 转换condition值为显示文本
                    String conditionText = "";
                    String conditionColor = "";
                    switch(condition) {
                        case "new": 
                            conditionText = "全新"; 
                            conditionColor = "#4a89dc";
                            break;
                        case "seventy": 
                            conditionText = "七成新"; 
                            conditionColor = "#5d9cec";
                            break;
                        case "fifty": 
                            conditionText = "五成新"; 
                            conditionColor = "#4fc1e9";
                            break;
                        case "thirdth": 
                            conditionText = "三成新"; 
                            conditionColor = "#48cfad";
                            break;
                        default: 
                            conditionText = "未知"; 
                            conditionColor = "#a0b0c5";
                            break;
                    }
            %>
                <div class="item-card">
                    <!-- 收藏按钮 -->
                    <button class="favorite-btn <%= isFavorited ? "favorited" : "" %>" 
                            data-item-id="<%= itemId %>">
                        <i class="<%= isFavorited ? "fas" : "far" %> fa-heart"></i>
                    </button>
                    
                    <img src="<%= photoPath %>" alt="<%= itemName %>" class="item-image">
                    <div class="item-info">
                        <div class="item-name"><%= itemName %></div>
                        <div class="item-price">¥<%= price %></div>
                        <div class="item-desc"><%= description %></div>
                        <div class="item-meta">
                            <span class="condition-badge" 
                                  style="background-color: rgba(40, 167, 69, 0.15); color: #28a745;">
                                <%= conditionText %>
                            </span>
                            <span class="seller-info">
                                卖家: <%= itemUsername %>
                            </span>
                        </div>
                        <a href="itemdetail.jsp?itemid=<%= itemId %>" class="view-details">查看详情</a>
                    </div>
                </div>
            <% 
                }
                
                if(!hasItems) {
            %>
                <div class="no-items">
                    <h3>暂无商品信息</h3>
                    <p>去添加新商品或者稍后再来看看吧！</p>
                </div>
            <%
                }
                
                // 关闭数据库连接
                db.closeDB();
            %>
        </div>
    </div>
    
    
	<script>

    document.addEventListener('DOMContentLoaded', function() {
        // 为所有收藏按钮添加点击事件
        const favoriteButtons = document.querySelectorAll('.favorite-btn');
        favoriteButtons.forEach(button => {
            button.addEventListener('click', function() {
                const itemId = this.getAttribute('data-item-id');
                toggleFavorite(itemId, this);
            });
        });
    });

    // 收藏/取消收藏函数
    function toggleFavorite(itemId, element) {
        // 判断当前状态
        const isFavorited = element.classList.contains('favorited');
        const operation = isFavorited ? 'remove' : 'add';
        
        // 确保itemId存在且有效
        if (!itemId || itemId === 'null' || itemId === 'undefined') {
            showToast('商品ID无效，无法完成操作');
            console.error('无效的商品ID:', itemId);
            return;
        }
        
        // 防止重复点击
        element.disabled = true;
        
        // 创建XHR对象
        const xhr = new XMLHttpRequest();
        xhr.open('POST', window.location.href, true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
        
        // 添加事件处理器
        xhr.onload = function() {
            if (xhr.status === 200) {
                // 先打印原始响应用于调试
                console.log("原始响应:", xhr.responseText);
                
                try {
                    // 尝试去除可能的BOM头和非JSON内容
                    let responseText = xhr.responseText.trim();
                    if (responseText.startsWith("\uFEFF")) {
                        responseText = responseText.substring(1);
                    }
                    
                    // 尝试只提取JSON部分
                    const jsonStartIndex = responseText.indexOf('{');
                    const jsonEndIndex = responseText.lastIndexOf('}') + 1;
                    
                    if (jsonStartIndex >= 0 && jsonEndIndex > jsonStartIndex) {
                        responseText = responseText.substring(jsonStartIndex, jsonEndIndex);
                    }
                    
                    const data = JSON.parse(responseText);
                    console.log("解析后的数据:", data);
                    
                    if(data.success) {
                        // 更新UI
                        element.classList.toggle('favorited');
                        const icon = element.querySelector('i');
                        icon.className = element.classList.contains('favorited') 
                            ? 'fas fa-heart' 
                            : 'far fa-heart';
                        
                        showToast(data.message || (operation === 'add' ? '收藏成功' : '取消收藏成功'));
                    } else {
                        showToast(data.message || '操作失败');
                    }
                } catch(e) {
                    console.error("JSON解析错误:", e);
                    console.log("响应文本:", xhr.responseText);
                    showToast('系统响应格式错误，请刷新页面后重试');
                } finally {
                    // 恢复按钮状态
                    element.disabled = false;
                }
            } else {
                element.disabled = false;
                showToast('请求失败: ' + xhr.status);
            }
        };
        
        xhr.onerror = function() {
            element.disabled = false;
            console.error('请求发送失败');
            showToast('网络连接错误，请检查网络后重试');
        };
        
        // 发送请求
        const params = 'action=favorite&itemid=' + encodeURIComponent(itemId) + '&operation=' + encodeURIComponent(operation);
        xhr.send(params);
    }
            
    // 显示提示框函数
    function showToast(message) {
        const toast = document.getElementById('toast');
        toast.textContent = message;
        toast.classList.add('show');

        // 3秒后自动隐藏
        setTimeout(() => {
            toast.classList.remove('show');
        }, 3000);
    }
	</script>
</body>
</html>