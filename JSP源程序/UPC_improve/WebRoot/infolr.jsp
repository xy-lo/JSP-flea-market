<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,java.sql.*,java.io.*,MyBean.*,java.util.Base64" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UPC二手交易平台-商品录入</title>
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
      
      /* 表单样式 */
      .form-group {
        margin-bottom: 25px;
        display: flex;
        align-items: flex-start;
      }
      .form-group label {
        width: 120px;
        text-align: right;
        padding-right: 15px;
        font-size: 18px;
        color: #0a2463;
        padding-top: 8px;
      }
      .form-control {
        flex: 1;
        padding: 10px 15px;
        border: 2px solid #d1d5db;
        border-radius: 10px;
        font-size: 16px;
        transition: all 0.3s ease;
        background-color: #fff;
        box-shadow: 0 2px 5px rgba(0,0,0,0.03);
      }
      
      .form-control:focus {
        border-color: #3a7bd5;
        box-shadow: 0 0 0 3px rgba(58, 123, 213, 0.2);
        outline: none;
      }
      
      textarea.form-control {
        min-height: 120px;
        resize: vertical;
      }
      
      .form-group select.form-control {
        cursor: pointer;
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%233a7bd5' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: calc(100% - 15px) center;
        padding-right: 40px;
      }
      
      /* 提交按钮区域 */
      .button-group {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin-top: 30px;
      }
      
      .submit-btn,
      .reset-btn {
        padding: 12px 35px;
        border: none;
        border-radius: 25px;
        font-size: 18px;
        font-weight: bold;
        cursor: pointer;
        transition: all 0.3s ease;
      }
      
      .submit-btn {
        background-color: #3a7bd5;
        color: #fff;
        box-shadow: 0 4px 10px rgba(58, 123, 213, 0.3);
      }
      
      .reset-btn {
        background-color: #f0f0f0;
        color: #555;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      }
      
      .submit-btn:hover {
        background-color: #2563eb;
        transform: translateY(-3px);
        box-shadow: 0 6px 15px rgba(58, 123, 213, 0.4);
      }
      
      .reset-btn:hover {
        background-color: #e0e0e0;
        transform: translateY(-3px);
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
      }
      
      /* 文件上传和图片预览 */
      .file-upload {
        position: relative;
        overflow: hidden;
        cursor: pointer;
        display: inline-block;
        padding: 10px 20px;
        background-color: #e2e8f0;
        color: #0a2463;
        border-radius: 10px;
        font-size: 16px;
        margin-bottom: 10px;
        transition: all 0.3s ease;
        text-align: center;
      }
      
      .file-upload:hover {
        background-color: #cbd5e1;
      }
      
      .file-upload input[type=file] {
        position: absolute;
        top: 0;
        right: 0;
        min-width: 100%;
        min-height: 100%;
        opacity: 0;
        cursor: pointer;
      }
      
      #imagePreview {
        margin-top: 15px;
        text-align: center;
        background-color: #f0f4f8;
        padding: 15px;
        border-radius: 10px;
        border: 1px dashed #cbd5e1;
        min-height: 150px;
        display: flex;
        align-items: center;
        justify-content: center;
      }
      
      #imagePreview img {
        max-width: 250px;
        max-height: 250px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      }
      
      #imagePreview:empty::before {
        content: '预览区域 - 选择图片后将显示在这里';
        color: #64748b;
        font-style: italic;
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
      
      .modal-image {
        max-width: 250px;
        max-height: 250px;
        margin: 15px auto;
        border-radius: 8px;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
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
        
        .form-group {
          flex-direction: column;
        }
        
        .form-group label {
          width: 100%;
          text-align: left;
          margin-bottom: 8px;
        }
        
        .button-group {
          flex-direction: column;
        }
        
        .submit-btn, .reset-btn {
          width: 100%;
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
 
    // 定义用于处理表单提交的变量
    String resultStatus = "";
    String resultMessage = "";
    String uploadedImagePath = "";
    
    // 处理表单提交
    if(request.getMethod().equals("POST")) {
    	
    	System.out.println("Request method = " + request.getMethod()); 

        try {
            // 获取表单数据
            request.setCharacterEncoding("UTF-8");  // 处理 POST 请求中文乱码
            String itemname = request.getParameter("itemname");
            System.out.println("itemname = " + itemname);
            String username = request.getParameter("username");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String status = request.getParameter("status");
            String condition = request.getParameter("condition");
            String photoData = request.getParameter("photoData");
            String photoName = request.getParameter("photoName");
            // 检查商品名称
            if (itemname == null || itemname.isEmpty()) {
                resultStatus = "error";
                resultMessage = "商品名称不能为空！/图片过大！(>1MB)";
            } else if (photoData == null || photoData.isEmpty()) {
                resultStatus = "error";
                resultMessage = "商品图片不能为空！";
            } else {
                // 处理Base64图片数据
                String[] parts = photoData.split(",");
                String imageData = parts.length > 1 ? parts[1] : parts[0]; // 移除"data:image/xxx;base64,"前缀
                // 生成唯一文件名
                String timestamp = new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS").format(new java.util.Date());
                String fileName = timestamp + "_" + photoName;
                // 确保上传目录存在
                String uploadPath = application.getRealPath("/") + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                // 将Base64数据解码并写入文件
                try {
                    byte[] decodedBytes = Base64.getDecoder().decode(imageData);
                    FileOutputStream fos = new FileOutputStream(new File(uploadPath, fileName));
                    fos.write(decodedBytes);
                    fos.close();
                    // 数据库操作
                    sqlBean db = new sqlBean();
                    String relativePath = "uploads/" + fileName;
                    String sql = String.format(
                        "INSERT INTO item (itemname, username, description, price, status, `condition`, photo) " +
                        "VALUES ('%s','%s','%s',%s,'%s','%s','%s')",
                        itemname, username, description, priceStr, status, condition, relativePath);
                    
                    if (db.executeUpdate(sql) != 0) {
                        resultStatus = "success";
                        resultMessage = "商品信息录入成功！";
                    } else {
                        resultStatus = "error";
                        resultMessage = "商品信息录入失败！数据库操作错误";
                    }
                } catch (Exception e) {
                    resultStatus = "error";
                    resultMessage = "商品信息录入失败！图片处理失败: " + e.getMessage();
                    e.printStackTrace();
                }
            }
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
    
        <button class="exit-btn" onclick="window.location.href='main.jsp'">返回主页</button>
        <button class="exit-btn" onclick="window.location.href='infocx.jsp'">商品查询</button>
        <button class="exit-btn" onclick="window.location.href='mycollection.jsp'">我的收藏</button>
        <button class="exit-btn" onclick="window.location.href='myitems.jsp'">我的商品</button>
        <button class="exit-btn" onclick="window.location.href='exit.jsp'">退出系统</button>
    </div>
    <div class="container">
        <h1 class="page-title">商品信息录入</h1>
        <div class="subtitle">录入人：<%=uname %></div>
        
        <form method="post" action="infolr.jsp" name="lrform" id="itemForm" onsubmit="return prepareSubmit()" accept-charset="UTF-8">
            <div class="form-group">
                <label for="itemname">商品名称：</label>
                <input type="text" id="itemname" class="form-control" maxlength="50" name="itemname" required>
            </div>
            
            <div class="form-group">
                <label for="username">卖家姓名：</label>
                <input type="text" id="username" class="form-control" maxlength="30" name="username" value="<%=uname %>" readonly>
            </div>
            
            <div class="form-group">
                <label for="description">商品描述：</label>
                <textarea id="description" class="form-control" name="description" rows="4" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="price">价格(元)：</label>
                <input type="number" id="price" class="form-control" min="0" step="0.01" name="price" required>
            </div>
            
            <div class="form-group">
                <label for="status">状态：</label>
                <select id="status" class="form-control" name="status">
                    <option value="available">可购买</option>
                    <option value="sold">已售出</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="condition">成色：</label>
                <select id="condition" class="form-control" name="condition">
                    <option value="new">全新</option>
                    <option value="seventy">七成新</option>
                    <option value="fifty">五成新</option>
                    <option value="thirdth">三成新及以下</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="photoFile">商品图片：</label>
                <div style="flex: 1;">
                    <div class="file-upload">
                        <span>选择图片文件</span>
                        <input type="file" id="photoFile" accept="image/*" onchange="previewImage(this)">
                    </div>
                    <div id="imagePreview"></div>
                    <!-- 隐藏字段用于存储Base64编码的图片 -->
                    <input type="hidden" name="photoData" id="photoData">
                    <input type="hidden" name="photoName" id="photoName">
                </div>
            </div>
            
            <div class="button-group">
                <button type="submit" class="submit-btn">保存商品</button>
                <button type="reset" class="reset-btn" onclick="clearPreview()">重置表单</button>
            </div>
        </form>
    </div>
    <!-- 弹窗 -->
    <div id="resultModal" class="modal">
        <div class="modal-content">
            <h2 id="modalTitle" class="modal-title"></h2>
            <p id="modalMessage" class="modal-message"></p>
            <img id="modalImage" class="modal-image" style="display:none;">
            <button id="modalButton" class="modal-button" onclick="closeModal()">确定</button>
        </div>
    </div>
    <script>
        // 预览选择的图片并转换为Base64
        function previewImage(input) {
            var preview = document.getElementById('imagePreview');
            preview.innerHTML = '';
            
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                
                reader.onload = function(e) {
                    // 创建图片预览
                    var img = document.createElement('img');
                    img.src = e.target.result;
                    preview.appendChild(img);
                    
                    // 存储Base64数据到隐藏字段
                    document.getElementById('photoData').value = e.target.result;
                    document.getElementById('photoName').value = input.files[0].name;
                }
                
                reader.readAsDataURL(input.files[0]);
            }
        }
        
        // 清除预览
        function clearPreview() {
            var preview = document.getElementById('imagePreview');
            preview.innerHTML = '';
            document.getElementById('photoData').value = '';
            document.getElementById('photoName').value = '';
        }
        
        // 表单提交前检查
        function prepareSubmit() {
            var photoData = document.getElementById('photoData').value;
            if (!photoData) {
                showModal("提示", "请选择商品图片", "", "error");
                return false;
            }
            return true;
        }
        
        // 显示弹窗
        function showModal(title, message, imagePath, status) {
            document.getElementById('modalTitle').textContent = title;
            document.getElementById('modalMessage').textContent = message;
            
            var modalImage = document.getElementById('modalImage');
            if (imagePath && imagePath !== "") {
                modalImage.src = imagePath;
                modalImage.style.display = "block";
            } else {
                modalImage.style.display = "none";
            }
            
            // 设置标题颜色根据状态
            if (status === "success") {
                document.getElementById('modalTitle').style.color = "#22c55e";  // 绿色
            } else {
                document.getElementById('modalTitle').style.color = "#ef4444";  // 红色
            }
            
            document.getElementById('resultModal').style.display = "flex";
        }
        
        // 关闭弹窗
        function closeModal() {
            document.getElementById('resultModal').style.display = "none";
            // 如果是成功状态，则重置表单
            if (document.getElementById('modalTitle').style.color === "rgb(34, 197, 94)") {
                document.getElementById('itemForm').reset();
                clearPreview();
            }
        }
    </script>
    
    <% if (!resultStatus.isEmpty()) { %>
        <script>
            // 自动显示结果弹窗
            window.onload = function() {
                showModal("<%= resultStatus.equals("success") ? "成功" : "错误" %>", 
                           "<%= resultMessage %>", 
                           "<%= uploadedImagePath %>", 
                           "<%= resultStatus %>");
            }
        </script>
    <% } %>
</body>
</html>