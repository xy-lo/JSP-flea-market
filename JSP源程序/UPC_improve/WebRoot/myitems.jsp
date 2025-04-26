<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,java.sql.*,java.io.*,MyBean.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UPC二手交易平台 - 我的商品</title>
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
      
      .edit-btn, .delete-btn {
        padding: 10px 0;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        flex: 1;
        transition: all 0.3s ease;
      }
      
      .edit-btn {
        background-color: #3a7bd5;
        color: white;
      }
      
      .delete-btn {
        background-color: #ff4d4d;
        color: white;
      }
      
      .edit-btn:hover {
        background-color: #2563eb;
      }
      
      .delete-btn:hover {
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
      
      /* 编辑表单弹窗 */
      .edit-modal {
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
        overflow-y: auto;
      }
      
      .edit-form {
        background-color: #fff;
        padding: 30px;
        border-radius: 15px;
        width: 90%;
        max-width: 700px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
      }
      
      .edit-title {
        color: #3a7bd5;
        font-size: 24px;
        margin-bottom: 20px;
        text-align: center;
      }
      
      .form-group {
        margin-bottom: 20px;
      }
      
      .form-group label {
        display: block;
        margin-bottom: 8px;
        font-size: 16px;
        color: #0a2463;
      }
      
      .form-control {
        width: 100%;
        padding: 10px 15px;
        border: 2px solid #d1d5db;
        border-radius: 10px;
        font-size: 16px;
        transition: all 0.3s ease;
      }
      
      .form-control:focus {
        border-color: #3a7bd5;
        box-shadow: 0 0 0 3px rgba(58, 123, 213, 0.2);
        outline: none;
      }
      
      .form-buttons {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 20px;
      }
      
      .form-submit, .form-cancel {
        padding: 12px 30px;
        border: none;
        border-radius: 20px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s;
      }
      
      .form-submit {
        background-color: #3a7bd5;
        color: white;
      }
      
      .form-cancel {
        background-color: #f0f0f0;
        color: #555;
      }
      
      .form-submit:hover {
        background-color: #2563eb;
        transform: translateY(-2px);
      }
      
      .form-cancel:hover {
        background-color: #e0e0e0;
        transform: translateY(-2px);
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
        
        .item-actions {
          flex-direction: column;
        }
      }
    </style>
</head>
<body>
    <% 
    // 设置请求和响应的字符编码
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    String flag = (String)session.getAttribute("flag");
    if(flag==null || flag!="success") response.sendRedirect("error.jsp");
    String uname = (String)session.getAttribute("uname");
    
    // 定义用于处理操作的变量
    String resultStatus = "";
    String resultMessage = "";
    String action = request.getParameter("action");
    String itemId = request.getParameter("id");
    
    // 处理删除操作
    if (action != null && action.equals("delete") && itemId != null) {
        try {
            sqlBean db = new sqlBean();
            // 先查询商品信息，获取图片路径
            String querySql = "SELECT photo FROM item WHERE itemid = " + itemId + " AND username = '" + uname + "'";
            ResultSet rs = db.executeQuery(querySql);
            String photoPath = null;
            
            if (rs.next()) {
                photoPath = rs.getString("photo");
            }
            
            // 执行删除操作
            String deleteSql = "DELETE FROM item WHERE itemid = " + itemId + " AND username = '" + uname + "'";
            int result = db.executeUpdate(deleteSql);
            if (result > 0) {
                // 删除成功，尝试删除图片文件
                if (photoPath != null && !photoPath.isEmpty()) {
                    String fullPath = application.getRealPath("/") + photoPath;
                    File photoFile = new File(fullPath);
                    if (photoFile.exists()) {
                        photoFile.delete();
                    }
                }
                
                resultStatus = "success";
                resultMessage = "商品删除成功！";
            } else {
                resultStatus = "error";
                resultMessage = "删除失败，未找到该商品或无权删除！";
            }
            
            rs.close();
            db.closeDB();
        } catch (Exception e) {
            resultStatus = "error";
            resultMessage = "删除操作失败：" + e.getMessage();
            e.printStackTrace();
        }
    }
    
    // 处理编辑操作
    if (action != null && action.equals("update") && request.getMethod().equals("POST")) {
        try {
            String id = request.getParameter("itemId");
            String itemname = request.getParameter("itemname");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            String status = request.getParameter("status");
            String condition = request.getParameter("condition");
            
            if (id != null && !id.isEmpty()) {
                sqlBean db = new sqlBean();
                // 使用简单的SQL语句，但确保之前已设置请求编码为UTF-8
                String updateSql = "UPDATE item SET itemname='" + itemname + "', description='" + description + 
                                  "', price=" + price + ", status='" + status + "', `condition`='" + condition + 
                                  "' WHERE itemid=" + id + " AND username='" + uname + "'";
                
                int result = db.executeUpdate(updateSql);
                
                if (result > 0) {
                    resultStatus = "success";
                    resultMessage = "商品信息更新成功！";
                } else {
                    resultStatus = "error";
                    resultMessage = "更新失败，未找到该商品或无权更新！";
                }
                
                db.closeDB();
            } else {
                resultStatus = "error";
                resultMessage = "无效的商品ID！";
            }
        } catch (Exception e) {
            resultStatus = "error";
            resultMessage = "更新操作失败：" + e.getMessage();
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
        <button class="exit-btn" onclick="window.location.href='mycollection.jsp'">我的收藏</button>
        <button class="exit-btn" onclick="window.location.href='main.jsp'">返回主页</button>
        <button class="exit-btn" onclick="window.location.href='exit.jsp'">退出系统</button>
    </div>
    
    <div class="container">
        <h1 class="page-title">我的商品</h1>
        <div class="subtitle">用户：<%=uname %></div>
        
        <div class="items-container">
            <% 
            // 从数据库获取当前用户的所有商品
            sqlBean db = new sqlBean();
            String sql = "SELECT * FROM item WHERE username = '" + uname + "' ORDER BY itemid DESC";
            ResultSet rs = db.executeQuery(sql);
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
                
                // 转换状态和成色为中文显示
                String statusText = "available".equals(status) ? "可购买" : "已售出";
                String statusClass = "available".equals(status) ? "status-available" : "status-sold";
                String conditionText = "";
                
                if ("new".equals(condition)) conditionText = "全新";
                else if ("seventy".equals(condition)) conditionText = "七成新";
                else if ("fifty".equals(condition)) conditionText = "五成新";
                else if ("thirdth".equals(condition)) conditionText = "三成新及以下";
            %>
            <div class="item-card">
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
                        <button class="edit-btn" onclick="editItem('<%= id %>', this.getAttribute('data-name'), this.getAttribute('data-desc'), '<%= price %>', '<%= status %>', '<%= condition %>')" data-name="<%= itemname %>" data-desc="<%= description %>">修改</button>
                        <button class="delete-btn" onclick="confirmDelete('<%= id %>', this.getAttribute('data-name'))" data-name="<%= itemname %>">删除</button>
                    </div>
                </div>
            </div>
            <% } 
            
            if (!hasItems) { %>
            <div class="no-items" style="grid-column: 1 / -1;">
                您还没有发布任何商品。点击"商品录入"开始发布您的第一个商品吧！
            </div>
            <% } 
            rs.close();
            db.closeDB();
            %>
        </div>
    </div>
    
    <!-- 确认删除弹窗 -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h2 class="modal-title">确认删除</h2>
            <p id="deleteMessage" class="modal-message"></p>
            <div class="modal-buttons">
                <button id="confirmDeleteBtn" class="modal-button">确认删除</button>
                <button class="modal-button modal-cancel" onclick="document.getElementById('deleteModal').style.display='none';">取消</button>
            </div>
        </div>
    </div>
    
    <!-- 结果提示弹窗 -->
    <div id="resultModal" class="modal">
        <div class="modal-content">
            <h2 id="resultTitle" class="modal-title"></h2>
            <p id="resultMessage" class="modal-message"></p>
            <button class="modal-button" onclick="document.getElementById('resultModal').style.display='none';">确定</button>
        </div>
    </div>
    
    <!-- 编辑商品弹窗 -->
    <div id="editModal" class="edit-modal">
        <div class="edit-form">
            <h2 class="edit-title">修改商品信息</h2>
            <form id="editItemForm" method="post" action="myitems.jsp">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="itemId" id="editItemId">
                
                <div class="form-group">
                    <label for="itemname">商品名称：</label>
                    <input type="text" id="editItemname" class="form-control" name="itemname" required>
                </div>
                
                <div class="form-group">
                    <label for="description">商品描述：</label>
                    <textarea id="editDescription" class="form-control" name="description" rows="4" required></textarea>
                </div>
                
                <div class="form-group">
                    <label for="price">价格(元)：</label>
                    <input type="number" id="editPrice" class="form-control" min="0" step="0.01" name="price" required>
                </div>
                
                <div class="form-group">
                    <label for="status">状态：</label>
                    <select id="editStatus" class="form-control" name="status">
                        <option value="available">可购买</option>
                        <option value="sold">已售出</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="condition">成色：</label>
                    <select id="editCondition" class="form-control" name="condition">
                        <option value="new">全新</option>
                        <option value="seventy">七成新</option>
                        <option value="fifty">五成新</option>
                        <option value="thirdth">三成新及以下</option>
                    </select>
                </div>
                
                <div class="form-buttons">
                    <button type="submit" class="form-submit">保存修改</button>
                    <button type="button" class="form-cancel" onclick="document.getElementById('editModal').style.display='none';">取消</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // 删除商品确认
        function confirmDelete(id, itemname) {
            document.getElementById('deleteMessage').textContent = "确定要删除商品 \"" + itemname + "\" 吗？此操作不可恢复。";
            
            // 设置确认按钮的点击事件
            document.getElementById('confirmDeleteBtn').onclick = function() {
                window.location.href = "myitems.jsp?action=delete&id=" + id;
            };
            
            // 显示确认弹窗
            document.getElementById('deleteModal').style.display = 'flex';
        }
        
        // 编辑商品
        function editItem(id, itemname, description, price, status, condition) {
            document.getElementById('editItemId').value = id;
            document.getElementById('editItemname').value = itemname;
            document.getElementById('editDescription').value = description;
            document.getElementById('editPrice').value = price;
            document.getElementById('editStatus').value = status;
            document.getElementById('editCondition').value = condition;
            
            // 显示编辑弹窗
            document.getElementById('editModal').style.display = 'flex';
        }
        
        // 关闭弹窗 - 实际不使用，直接内联
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