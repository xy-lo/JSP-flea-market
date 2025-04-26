<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,java.sql.*,MyBean.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UPC二手交易平台 - 我的收藏</title>
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
        max-width: 1200px;
        margin: 30px auto;
        padding: 30px;
        background-color: #f9f6f0;
        border-radius: 20px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.05);
      }
      
      /* 页面标题 */
      .page-title {
        font-size: 32px;
        font-weight: bold;
        color: #3a7bd5;
        margin-bottom: 25px;
        text-align: center;
        position: relative;
        padding-bottom: 10px;
      }
      
      .page-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 150px;
        height: 4px;
        background: linear-gradient(to right, transparent, #3a7bd5, transparent);
        border-radius: 2px;
      }
      
      .subtitle {
        font-size: 20px;
        color: #ff8000;
        text-align: center;
        margin-bottom: 30px;
      }
      
      /* 商品列表样式 */
      .items-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
        gap: 25px;
      }
      
      .item-card {
        background-color: #fff;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        position: relative;
      }
      
      .item-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
      }
      
      .item-image {
        width: 100%;
        height: 300px;
        object-fit: cover;
        border-bottom: 1px solid #f0f0f0;
      }
      
      .item-details {
        padding: 20px;
      }
      
      .item-name {
        font-size: 22px;
        font-weight: bold;
        margin-bottom: 10px;
        color: #0a2463;
      }
      
      .item-description {
        font-size: 16px;
        color: #555;
        margin-bottom: 15px;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
      }
      
      .item-meta {
        display: flex;
        justify-content: space-between;
        margin-bottom: 15px;
      }
      
      .item-price {
        font-size: 20px;
        font-weight: bold;
        color: #e63946;
      }
      
      .item-status {
        padding: 5px 12px;
        border-radius: 15px;
        font-size: 16px;
        font-weight: bold;
      }
      
      .status-available {
        background-color: #d4edda;
        color: #155724;
      }
      
      .status-sold {
        background-color: #f8d7da;
        color: #721c24;
      }
      
      .item-condition {
        font-size: 16px;
        margin-bottom: 15px;
      }
      
      .item-actions {
        display: flex;
        justify-content: space-between;
        gap: 10px;
      }
      
      .view-btn, .remove-btn {
        padding: 10px 0;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        flex: 1;
        transition: all 0.3s ease;
    text-align: center; /* 添加文字居中 */
    text-decoration: none; /* 去掉下划线 */
    display: block; /* 使其成为块级元素 */
      }
      
      .view-btn {
        background-color: #3a7bd5;
        color: white;
      }
      
      .remove-btn {
        background-color: #ff4d4d;
        color: white;
      }
      
      .view-btn:hover {
        background-color: #2563eb;
      }
      
      .remove-btn:hover {
        background-color: #e60000;
      }
      
      .no-items {
        text-align: center;
        padding: 50px 20px;
        font-size: 20px;
        color: #666;
        background-color: #f5f5f5;
        border-radius: 10px;
        margin: 20px 0;
        grid-column: 1 / -1;
      }
      
      /* 收藏图标 */
      .favorite-icon {
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
      }
      
      .favorite-icon i {
        font-size: 20px;
        color: #ff4757;
      }
      
      /* 弹窗样式 */
      .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 1000;
        justify-content: center;
        align-items: center;
      }
      
      .modal-content {
        background-color: #fff;
        padding: 30px;
        border-radius: 15px;
        width: 90%;
        max-width: 500px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
        text-align: center;
      }
      
      .modal-title {
        color: #3a7bd5;
        font-size: 24px;
        margin-bottom: 15px;
      }
      
      .modal-message {
        margin-bottom: 20px;
        font-size: 18px;
      }
      
      .modal-buttons {
        display: flex;
        justify-content: center;
        gap: 15px;
      }
      
      .modal-button {
        background-color: #3a7bd5;
        color: white;
        border: none;
        padding: 10px 25px;
        border-radius: 20px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s;
      }
      
      .modal-button:hover {
        background-color: #2563eb;
        transform: translateY(-2px);
      }
      
      .modal-cancel {
        background-color: #f0f0f0;
        color: #555;
      }
      
      .modal-cancel:hover {
        background-color: #e0e0e0;
      }
      
      /* 响应式调整 */
      @media (max-width: 768px) {
        .header {
          flex-direction: column;
          align-items: flex-start;
          gap: 15px;
        }
        
        .container {
          padding: 20px;
          margin: 20px 10px;
        }
        
        .items-container {
          grid-template-columns: 1fr;
        }
      }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <% 
    // 设置请求和响应的字符编码
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    String flag = (String)session.getAttribute("flag");
    if(flag==null || flag!="success") response.sendRedirect("error.jsp");
    String uname = (String)session.getAttribute("uname");
    
    // 处理取消收藏操作
    String action = request.getParameter("action");
    String itemId = request.getParameter("itemid");
    String resultStatus = "";
    String resultMessage = "";
    
    if (action != null && action.equals("remove") && itemId != null) {
        try {
            sqlBean db = new sqlBean();
            String deleteSql = "DELETE FROM collection WHERE username = ? AND itemid = ?";
            PreparedStatement pstmt = db.getPreparedStatement(deleteSql);
            pstmt.setString(1, uname);
            pstmt.setString(2, itemId);
            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                resultStatus = "success";
                resultMessage = "已从收藏中移除该商品";
            } else {
                resultStatus = "error";
                resultMessage = "移除收藏失败，请重试";
            }
            
            pstmt.close();
            db.closeDB();
        } catch (Exception e) {
            resultStatus = "error";
            resultMessage = "操作失败：" + e.getMessage();
            e.printStackTrace();
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
        
        <button class="exit-btn" onclick="window.location.href='main.jsp'">返回主页</button>
        <button class="exit-btn" onclick="window.location.href='myitems.jsp'">我的商品</button>
        <button class="exit-btn" onclick="window.location.href='exit.jsp'">退出系统</button>
    </div>
    
    <div class="container">
        <h1 class="page-title">我的收藏</h1>
        <div class="subtitle">用户：<%=uname %></div>
        
        <div class="items-container">
            <% 
            // 查询当前用户收藏的商品
            sqlBean db = new sqlBean();
            String sql = "SELECT i.* FROM item i JOIN collection c ON i.itemid = c.itemid WHERE c.username = ? AND i.status='available' ORDER BY i.itemid DESC";
            PreparedStatement pstmt = db.getPreparedStatement(sql);
            pstmt.setString(1, uname);
            ResultSet rs = pstmt.executeQuery();
            boolean hasItems = false;
            
            while (rs.next()) {
                hasItems = true;
                int id = rs.getInt("itemid");
                String itemname = rs.getString("itemname");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                String status = rs.getString("status");
                String condition = rs.getString("condition");
                String photo = rs.getString("photo");
                String seller = rs.getString("username");
                
                // 转换状态和成色为中文显示
                String statusText = "available".equals(status) ? "可购买" : "已售出";
                String statusClass = "available".equals(status) ? "status-available" : "status-sold";
                String conditionText = "";
                
                if ("new".equals(condition)) conditionText = "全新";
                else if ("seventy".equals(condition)) conditionText = "七成新";
                else if ("fifty".equals(condition)) conditionText = "五成新";
                else if ("thirdth".equals(condition)) conditionText = "三成新及以下";
                
                // 如果没有图片路径，使用默认图片
                if(photo == null || photo.trim().isEmpty()) {
                    photo = "images/default-item.jpg";
                }
            %>
            <div class="item-card">
                <div class="favorite-icon" onclick="removeFromCollection('<%= id %>', '<%= itemname %>')">
                    <i class="fas fa-heart"></i>
                </div>
                <img src="<%= photo %>" class="item-image" alt="<%= itemname %>">
                <div class="item-details">
                    <h3 class="item-name"><%= itemname %></h3>
                    <div class="item-description"><%= description %></div>
                    <div class="item-meta">
                        <div class="item-price">¥<%= String.format("%.2f", price) %></div>
                        <div class="item-status <%= statusClass %>"><%= statusText %></div>
                    </div>
                    <div class="item-condition">成色：<%= conditionText %></div>
                    <div class="item-actions">
                        <a href="itemdetail.jsp?itemid=<%= id %>" class="view-btn">查看详情</a>
                        <button class="remove-btn" onclick="removeFromCollection('<%= id %>', '<%= itemname %>')">取消收藏</button>
                    </div>
                </div>
            </div>
            <% } 
            
            if (!hasItems) { %>
            <div class="no-items">
                您还没有收藏任何商品。快去浏览商品并收藏您喜欢的吧！
            </div>
            <% } 
            rs.close();
            pstmt.close();
            db.closeDB();
            %>
        </div>
    </div>
    
    <!-- 确认取消收藏弹窗 -->
    <div id="confirmModal" class="modal">
        <div class="modal-content">
            <h2 class="modal-title">确认操作</h2>
            <p id="confirmMessage" class="modal-message"></p>
            <div class="modal-buttons">
                <button id="confirmActionBtn" class="modal-button">确认</button>
                <button class="modal-button modal-cancel" onclick="closeModal('confirmModal')">取消</button>
            </div>
        </div>
    </div>
    
    <!-- 结果提示弹窗 -->
    <div id="resultModal" class="modal">
        <div class="modal-content">
            <h2 id="resultTitle" class="modal-title"></h2>
            <p id="resultMessage" class="modal-message"></p>
            <%
    			String reloadScript = resultStatus.equals("success") ? "location.reload();" : "";
			%>
			<button class="modal-button" onclick="closeModal('resultModal'); '<%= reloadScript %>'">确定</button>
        </div>
    </div>
    
    <script>
        // 取消收藏确认
        function removeFromCollection(itemId, itemName) {
            document.getElementById('confirmMessage').textContent = "确定要从收藏中移除商品 \"" + itemName + "\" 吗？";
            
            // 设置确认按钮的点击事件
            document.getElementById('confirmActionBtn').onclick = function() {
                window.location.href = "mycollection.jsp?action=remove&itemid=" + itemId;
            };
            
            // 显示确认弹窗
            document.getElementById('confirmModal').style.display = 'flex';
        }
        
        // 关闭弹窗
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }
    </script>
    
    <% if (!resultStatus.isEmpty()) { %>
        <script>
            // 自动显示结果弹窗
            window.onload = function() {
                var resultModal = document.getElementById('resultModal');
                var resultTitle = document.getElementById('resultTitle');
                var resultMessage = document.getElementById('resultMessage');
                
                resultTitle.textContent = '<%= "success".equals(resultStatus) ? "成功" : "错误" %>';
                resultMessage.textContent = '<%= resultMessage %>';
                
                // 设置标题颜色
                if ('<%= resultStatus %>' === 'success') {
                    resultTitle.style.color = '#22c55e';  // 绿色
                } else {
                    resultTitle.style.color = '#ef4444';  // 红色
                }
                
                resultModal.style.display = 'flex';
            }
        </script>
    <% } %>
</body>
</html>