<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,java.sql.*,MyBean.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UPC二手交易平台 - 商品查询</title>
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
        max-width: 800px;
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
      
      /* 查询表单样式 */
      .search-form {
        margin: 20px 0;
      }
      
      .search-options {
        display: flex;
        flex-direction: column;
        gap: 15px;
        margin-bottom: 25px;
      }
      
      .search-option {
        display: flex;
        align-items: center;
        font-size: 18px;
        color: #333;
      }
      
      .search-option input[type="radio"] {
        margin-right: 12px;
        width: 18px;
        height: 18px;
        accent-color: #3a7bd5;
      }
      
      .search-input {
        display: flex;
        align-items: center;
        margin-bottom: 25px;
      }
      
      .search-input label {
        font-size: 18px;
        margin-right: 15px;
        color: #0a2463;
      }
      
      .search-input input[type="text"],
      .search-input select {
        flex: 1;
        padding: 12px 15px;
        border: 2px solid #d1d5db;
        border-radius: 10px;
        font-size: 16px;
        transition: all 0.3s ease;
      }
      
      .search-input input[type="text"]:focus,
      .search-input select:focus {
        border-color: #3a7bd5;
        box-shadow: 0 0 0 3px rgba(58, 123, 213, 0.2);
        outline: none;
      }
      
      .price-range-inputs {
        display: flex;
        align-items: center;
        gap: 10px;
      }
      
      .price-range-inputs input {
        flex: 1;
        padding: 12px 15px;
        border: 2px solid #d1d5db;
        border-radius: 10px;
        font-size: 16px;
        transition: all 0.3s ease;
      }
      
      .price-range-inputs input:focus {
        border-color: #3a7bd5;
        box-shadow: 0 0 0 3px rgba(58, 123, 213, 0.2);
        outline: none;
      }
      
      .price-range-dash {
        font-weight: bold;
        color: #64748b;
      }
      
      .search-button {
        display: flex;
        justify-content: center;
      }
      
      .search-btn {
        background-color: #3a7bd5;
        color: #fff;
        border: none;
        padding: 12px 35px;
        border-radius: 25px;
        font-size: 18px;
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 10px rgba(58, 123, 213, 0.3);
      }
      
      .search-btn:hover {
        background-color: #2563eb;
        transform: translateY(-3px);
        box-shadow: 0 6px 15px rgba(58, 123, 213, 0.4);
      }
      
      /* 动态显示/隐藏不同的搜索输入 */
      .input-group {
        display: none;
        width: 100%;
      }
      
      .input-group.active {
        display: flex;
      }

      /* 结果区域样式 */
      .results-section {
        margin-top: 40px;
        border-top: 2px dashed #d1d5db;
        padding-top: 25px;
      }
      
      .results-title {
        font-size: 24px;
        color: #3a7bd5;
        margin-bottom: 20px;
        text-align: center;
        font-weight: bold;
      }
      
      .no-results {
        text-align: center;
        padding: 20px;
        background-color: #f0f4f8;
        border-radius: 10px;
        color: #64748b;
        font-size: 18px;
        font-style: italic;
      }
      
      /* 商品卡片容器 */
      .items-container {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(230px, 1fr));
        gap: 20px;
      }
      
      /* 商品卡片样式 */
      .item-card {
        background: #fff;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
      }
      
      .item-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
      }
      
      .item-image {
        width: 100%;
        height: 160px;
        object-fit: cover;
        border-bottom: 1px solid #eee;
      }
      
      .item-info {
        padding: 15px;
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
        font-size: 20px;
        color: #e63946;
        font-weight: bold;
        margin-bottom: 10px;
      }
      
      .item-meta {
        display: flex;
        justify-content: space-between;
        font-size: 14px;
        color: #64748b;
      }
      
      .item-seller {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 50%;
      }
      
      /* 状态标签 */
      .status-tag {
        display: inline-block;
        padding: 3px 8px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: bold;
      }
      
      .status-available {
        background-color: #d1fae5;
        color: #065f46;
      }
      
      .status-sold {
        background-color: #fecaca;
        color: #991b1b;
      }
      
      /* 详情按钮 */
      .detail-button {
        width: 100%;
        background-color: #3a7bd5;
        color: white;
        border: none;
        padding: 8px 0;
        border-radius: 8px;
        font-size: 14px;
        cursor: pointer;
        margin-top: 10px;
        transition: background-color 0.3s;
      }
      
      .detail-button:hover {
        background-color: #2563eb;
      }
      
      /* 列表视图 */
      .list-view {
        display: flex;
        flex-direction: column;
        gap: 15px;
      }
      
      .list-item {
        display: flex;
        background: #fff;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      }
      
      .list-item-image {
        width: 120px;
        height: 120px;
        object-fit: cover;
      }
      
      .list-item-info {
        padding: 15px;
        flex: 1;
        position: relative;
      }
      
      .list-item-price {
        position: absolute;
        top: 15px;
        right: 15px;
        font-size: 18px;
        color: #e63946;
        font-weight: bold;
      }
      
      .list-item-description {
        margin-top: 8px;
        font-size: 14px;
        color: #4b5563;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
      }
      
      .list-item-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 10px;
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
        
        .search-input {
          flex-direction: column;
          align-items: flex-start;
        }
        
        .search-input label {
          margin-bottom: 10px;
        }
        
        .search-input input[type="text"] {
          width: 100%;
        }
        
        .price-range-inputs {
          width: 100%;
        }
        
        .list-item {
          flex-direction: column;
        }
        
        .list-item-image {
          width: 100%;
          height: 160px;
        }
        
        .list-item-price {
          position: static;
          margin-top: 5px;
        }
      }
    </style>
    
    <script>
      // 页面加载完成后执行
      document.addEventListener('DOMContentLoaded', function() {
          // 获取所有单选按钮
          const radioButtons = document.querySelectorAll('input[name="infocxtj"]');
          
          // 为每个单选按钮添加事件监听器
          radioButtons.forEach(function(radio) {
              radio.addEventListener('change', toggleInputFields);
          });
          
          // 初始化页面时调用一次
          toggleInputFields();
          
          function toggleInputFields() {
              // 获取当前选中的单选按钮值
              const selectedValue = document.querySelector('input[name="infocxtj"]:checked').value;
              
              // 隐藏所有输入组
              document.querySelectorAll('.input-group').forEach(function(group) {
                  group.classList.remove('active');
              });
              
              // 显示对应的输入组
              const activeGroup = document.getElementById(selectedValue + '-input');
              if (activeGroup) {
                  activeGroup.classList.add('active');
              }
          }
      });
    </script>
</head>
<body>
    <% 
        request.setCharacterEncoding("UTF-8"); // 设置请求编码为UTF-8，解决中文乱码问题
        
        String flag = (String)session.getAttribute("flag");
        if(flag==null || flag!="success") response.sendRedirect("error.jsp");
        String uname = (String)session.getAttribute("uname");
        
        // 处理查询
        boolean searched = false;
        String searchCondition = request.getParameter("infocxtj");
        String searchKeyword = request.getParameter("cxkey");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        String conditionValue = request.getParameter("conditionValue");
        String statusValue = request.getParameter("statusValue");
        ResultSet rs = null;
        Statement stmt = null;
        
        if (searchCondition != null) {
            searched = true;
            sqlBean db = new sqlBean();
            StringBuilder sql = new StringBuilder("SELECT * FROM item WHERE 1=1 ");
            
            try {
                stmt = db.getStatement();
                
                if (searchCondition.equals("itemname") && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                    sql.append("AND itemname LIKE '%" + searchKeyword + "%' ");
                } 
                else if (searchCondition.equals("username") && searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                    sql.append("AND username LIKE '%" + searchKeyword + "%' ");
                } 
                else if (searchCondition.equals("price")) {
                    try {
                        double min = (minPrice != null && !minPrice.trim().isEmpty()) ? Double.parseDouble(minPrice) : 0;
                        double max = (maxPrice != null && !maxPrice.trim().isEmpty()) ? Double.parseDouble(maxPrice) : Double.MAX_VALUE;
                        
                        sql.append("AND price >= " + min + " AND price <= " + max + " ");
                    } catch (NumberFormatException e) {
                        // 如果输入的不是有效数字，则查询所有价格
                        sql.append("AND price > 0 ");
                    }
                } 
                else if (searchCondition.equals("condition") && conditionValue != null && !conditionValue.equals("all")) {
                    sql.append("AND `condition` = '" + conditionValue + "' ");
                } 
                else if (searchCondition.equals("status") && statusValue != null && !statusValue.equals("all")) {
                    sql.append("AND status = '" + statusValue + "' ");
                }
                
                rs = stmt.executeQuery(sql.toString());
            } catch (Exception e) {
                out.println("<div class='no-results'>查询出错: " + e.getMessage() + "</div>");
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
        <button class="exit-btn" onclick="window.location.href='main.jsp'">返回主页</button>
        <button class="exit-btn" onclick="window.location.href='mycollection.jsp'">我的收藏</button>
        <button class="exit-btn" onclick="window.location.href='myitems.jsp'">我的商品</button>
        <button class="exit-btn" onclick="window.location.href='exit.jsp'">退出系统</button>
    </div>
    
    <div class="container">
        <h1 class="page-title">商品信息查询</h1>
        <div class="subtitle">欢迎来到商品查询界面！</div>
        
        <form method="post" action="infocx.jsp" name="infocxform" class="search-form" accept-charset="UTF-8">
            <div class="search-options">
                <div class="search-option">
                    <input type="radio" id="itemname" <%= searchCondition == null || searchCondition.equals("itemname") ? "checked='checked'" : "" %> value="itemname" name="infocxtj">
                    <label for="itemname">按商品名称查询</label>
                </div>
                <div class="search-option">
                    <input type="radio" id="username" <%= searchCondition != null && searchCondition.equals("username") ? "checked='checked'" : "" %> value="username" name="infocxtj">
                    <label for="username">按卖家姓名查询</label>
                </div>
                <div class="search-option">
                    <input type="radio" id="price" <%= searchCondition != null && searchCondition.equals("price") ? "checked='checked'" : "" %> value="price" name="infocxtj">
                    <label for="price">按价格范围查询</label>
                </div>
                <div class="search-option">
                    <input type="radio" id="condition" <%= searchCondition != null && searchCondition.equals("condition") ? "checked='checked'" : "" %> value="condition" name="infocxtj">
                    <label for="condition">按商品成色查询</label>
                </div>
                <div class="search-option">
                    <input type="radio" id="status" <%= searchCondition != null && searchCondition.equals("status") ? "checked='checked'" : "" %> value="status" name="infocxtj">
                    <label for="status">按商品状态查询</label>
                </div>
            </div>
            
            <!-- 名称和卖家的输入框 -->
            <div id="itemname-input" class="input-group <%= searchCondition == null || searchCondition.equals("itemname") ? "active" : "" %>">
                <div class="search-input">
                    <label for="cxkey">请输入商品名称：</label>
                    <input type="text" id="cxkey" maxlength="50" name="cxkey" placeholder="输入商品名称..." value="<%= searchKeyword != null ? searchKeyword : "" %>">
                </div>
            </div>
            
            <div id="username-input" class="input-group <%= searchCondition != null && searchCondition.equals("username") ? "active" : "" %>">
                <div class="search-input">
                    <label for="cxkey">请输入卖家姓名：</label>
                    <input type="text" id="cxkey" maxlength="50" name="cxkey" placeholder="输入卖家姓名..." value="<%= searchKeyword != null ? searchKeyword : "" %>">
                </div>
            </div>
            
            <!-- 价格范围输入 -->
            <div id="price-input" class="input-group <%= searchCondition != null && searchCondition.equals("price") ? "active" : "" %>">
                <div class="search-input">
                    <label for="price-range">价格范围：</label>
                    <div class="price-range-inputs">
                        <input type="number" id="minPrice" name="minPrice" min="0" step="0.01" placeholder="最低价格" value="<%= minPrice != null ? minPrice : "" %>">
                        <span class="price-range-dash">至</span>
                        <input type="number" id="maxPrice" name="maxPrice" min="0" step="0.01" placeholder="最高价格" value="<%= maxPrice != null ? maxPrice : "" %>">
                    </div>
                </div>
            </div>
            
            <!-- 商品成色选择 -->
            <div id="condition-input" class="input-group <%= searchCondition != null && searchCondition.equals("condition") ? "active" : "" %>">
                <div class="search-input">
                    <label for="conditionValue">选择商品成色：</label>
                    <select id="conditionValue" name="conditionValue">
                        <option value="all" <%= conditionValue == null || conditionValue.equals("all") ? "selected" : "" %>>所有成色</option>
                        <option value="new" <%= conditionValue != null && conditionValue.equals("new") ? "selected" : "" %>>全新</option>
                        <option value="seventy" <%= conditionValue != null && conditionValue.equals("seventy") ? "selected" : "" %>>七成新</option>
                        <option value="fifty" <%= conditionValue != null && conditionValue.equals("fifty") ? "selected" : "" %>>五成新</option>
                        <option value="thirdth" <%= conditionValue != null && conditionValue.equals("thirdth") ? "selected" : "" %>>三成新及以下</option>
                    </select>
                </div>
            </div>
            
            <!-- 商品状态选择 -->
            <div id="status-input" class="input-group <%= searchCondition != null && searchCondition.equals("status") ? "active" : "" %>">
                <div class="search-input">
                    <label for="statusValue">选择商品状态：</label>
                    <select id="statusValue" name="statusValue">
                        <option value="all" <%= statusValue == null || statusValue.equals("all") ? "selected" : "" %>>所有状态</option>
                        <option value="available" <%= statusValue != null && statusValue.equals("available") ? "selected" : "" %>>可购买</option>
                        <option value="sold" <%= statusValue != null && statusValue.equals("sold") ? "selected" : "" %>>已售出</option>
                    </select>
                </div>
            </div>
            
            <div class="search-button">
                <button type="submit" class="search-btn" name="cxbt">开始查询</button>
            </div>
        </form>
        
        <% if (searched) { %>
        <div class="results-section">
            <h2 class="results-title">查询结果</h2>
            
            <% 
            try {
                if (rs != null && rs.next()) {
                    // 重置结果集指针
                    rs.beforeFirst();
            %>
            <div class="items-container">
                <% while (rs.next()) { 
                    String itemId = rs.getString("itemid");
                    String itemName = rs.getString("itemname");
                    String itemSeller = rs.getString("username");
                    String itemPrice = rs.getString("price");
                    String itemStatus = rs.getString("status");
                    String itemPhoto = rs.getString("photo");
                    String itemCondition = rs.getString("condition");
                    
                    // 转换成色显示
                    String conditionDisplay = "";
                    if (itemCondition.equals("new")) conditionDisplay = "全新";
                    else if (itemCondition.equals("seventy")) conditionDisplay = "七成新";
                    else if (itemCondition.equals("fifty")) conditionDisplay = "五成新";
                    else if (itemCondition.equals("thirdth")) conditionDisplay = "三成新及以下";
                    else conditionDisplay = itemCondition;
                    
                    // 转换状态显示
                    String statusDisplay = itemStatus.equals("available") ? "可购买" : "已售出";
                    String statusClass = itemStatus.equals("available") ? "status-available" : "status-sold";
                %>
                <div class="item-card">
                    <img src="<%= itemPhoto %>" class="item-image" alt="<%= itemName %>" onerror="this.src='uploads/default.jpg'">
                    <div class="item-info">
                        <div class="item-name"><%= itemName %></div>
                        <div class="item-price">¥<%= itemPrice %></div>
                        <div class="item-meta">
                            <span class="item-seller">卖家: <%= itemSeller %></span>
                            <span class="status-tag <%= statusClass %>"><%= statusDisplay %></span>
                        </div>
                        <div class="item-meta" style="margin-top: 5px;">
                            <span>成色: <%= conditionDisplay %></span>
                        </div>
                        <button class="detail-button" onclick="window.location.href='itemdetail.jsp?itemid=<%= itemId %>'">查看详情</button>
                    </div>
                </div>
                <% } %>
            </div>
            <% } else { %>
            <div class="no-results">
                未找到符合条件的商品
            </div>
            <% }
            } catch (Exception e) { 
                out.println("<div class='no-results'>查询出错: " + e.getMessage() + "</div>");
                e.printStackTrace();
            } finally {
                // 关闭结果集和Statement
                if (rs != null) {
                    try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                if (stmt != null) {
                    try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
            %>
        </div>
        <% } %>
    </div>
</body>
</html>