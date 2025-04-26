<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*,java.sql.*,java.io.*,MyBean.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>UPC二手交易平台 - 商品详情</title>
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
        
        .nav-buttons {
            display: flex;
            gap: 10px;
        }
        
        .nav-btn {
            background-color: #fff;
            color: #0a2463;
            border: none;
            padding: 8px 15px;
            border-radius: 20px;
            cursor: pointer;
            font-weight: bold;
            font-size: 18px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: 0.3s;
        }
        
        .nav-btn:hover {
            background-color: #f0f0f0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            transform: translateY(-2px);
        }
        
        /* 主容器，控制宽度与边界 */
        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 30px;
            background-color: #f9f6f0;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.05);
        }
        
        /* 用户信息显示 */
        .user-info {
            background-color: #e6f0ff;
            padding: 10px 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: inline-block;
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
        
        /* 商品详情布局 */
        .item-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        /* 商品图片容器 */
        .item-image-container {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .item-image {
            width: 100%;
            height: auto;
            display: block;
        }
        
        /* 商品信息容器 */
        .item-info {
            background-color: #fff;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .item-title {
            font-size: 28px;
            color: #0a2463;
            margin-bottom: 15px;
            font-weight: bold;
        }
        
        .item-price {
            font-size: 32px;
            color: #ff6b6b;
            margin-bottom: 20px;
            font-weight: bold;
        }
        
        .item-status {
            display: inline-block;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        
        .status-available {
            background-color: #c8f7c5;
            color: #0e9f6e;
        }
        
        .status-sold {
            background-color: #fecaca;
            color: #dc2626;
        }
        
        .item-detail-row {
            display: flex;
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }
        
        .item-detail-label {
            width: 100px;
            font-weight: bold;
            color: #64748b;
        }
        
        .item-detail-value {
            flex: 1;
            color: #1e293b;
        }
        
        .item-description {
            background-color: #f8fafc;
            padding: 15px;
            border-radius: 10px;
            margin-top: 20px;
            border-left: 4px solid #3a7bd5;
        }
        
        .desc-title {
            font-weight: bold;
            margin-bottom: 10px;
            color: #3a7bd5;
        }
        
        /* 操作按钮 */
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        
        .action-btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }
        
        .collect-btn {
            background-color: #fef3c7;
            color: #d97706;
            border: 2px solid #fcd34d;
        }
        
        .collect-btn:hover {
            background-color: #fcd34d;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(251, 191, 36, 0.4);
        }
        
        .collect-btn:disabled {
            background-color: #fcd34d;
            color: #92400e;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .back-btn {
            background-color: #e2e8f0;
            color: #475569;
            border: 2px solid #cbd5e1;
        }
        
        .back-btn:hover {
            background-color: #cbd5e1;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(203, 213, 225, 0.4);
        }
        
        /* 卖家信息 */
        .seller-section {
            background-color: #fff;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .section-title {
            font-size: 22px;
            color: #0a2463;
            margin-bottom: 15px;
            font-weight: bold;
            padding-bottom: 8px;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .seller-name {
            font-size: 18px;
            margin-bottom: 15px;
        }
        
        .contact-btn {
            background-color: #3a7bd5;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .contact-btn:hover {
            background-color: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(58, 123, 213, 0.3);
        }
        
        /* 留言板区域 */
        .message-section {
            background-color: #fff;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .message-list {
            margin-bottom: 30px;
        }
        
        .message-item {
            background-color: #f8fafc;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.03);
            border-left: 4px solid #3a7bd5;
        }
        
        .message-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding-bottom: 8px;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .message-user {
            font-weight: bold;
            color: #3a7bd5;
        }
        
        .message-date {
            color: #94a3b8;
            font-size: 14px;
        }
        
        .message-content {
            color: #475569;
            line-height: 1.6;
        }
        
        .no-messages {
            text-align: center;
            padding: 20px;
            color: #64748b;
            font-style: italic;
        }
        
        /* 留言表单 */
        .message-form {
            background-color: #f8fafc;
            border-radius: 10px;
            padding: 20px;
        }
        
        .form-title {
            font-size: 18px;
            color: #0a2463;
            margin-bottom: 15px;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 16px;
            margin-bottom: 15px;
            transition: all 0.3s;
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
        
        .submit-btn {
            background-color: #3a7bd5;
            color: #fff;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .submit-btn:hover {
            background-color: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(58, 123, 213, 0.3);
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
            position: relative;
        }
        
        .modal-close {
            position: absolute;
            top: 15px;
            right: 15px;
            font-size: 24px;
            color: #64748b;
            background: none;
            border: none;
            cursor: pointer;
        }
        
        .modal-title {
            color: #3a7bd5;
            font-size: 24px;
            margin-bottom: 15px;
        }
        
        .contact-item {
            padding: 15px 0;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .contact-item:last-child {
            border-bottom: none;
        }
        
        .contact-label {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 5px;
        }
        
        .contact-value {
            font-size: 18px;
            font-weight: bold;
            color: #0a2463;
            margin-bottom: 10px;
        }
        
        .copy-btn {
            background-color: #e2e8f0;
            border: none;
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 14px;
            color: #3a7bd5;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .copy-btn:hover {
            background-color: #cbd5e1;
        }
        
        .result-modal .modal-content {
            text-align: center;
        }
        
        .modal-button {
            background-color: #3a7bd5;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 20px;
        }
        
        .modal-button:hover {
            background-color: #2563eb;
            transform: translateY(-2px);
        }

        .delete-btn {
        padding: 12px 0;
        border: none;
        border-radius: 10px;
        font-size: 18px;
        font-weight: bold;
        cursor: pointer;
        flex: 1;
        transition: all 0.3s ease;
        background-color: #ff4d4d;
        color: white;
      }
      
        /* 调试信息隐藏 */
        .debug-info {
            display: none;
        }
        
        /* 响应式调整 */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                padding: 15px;
            }
            
            .logo {
                margin-bottom: 10px;
            }
            
            .container {
                padding: 15px;
                margin: 15px 10px;
            }
            
            .item-container {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .modal-content {
                width: 95%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
  <div class="header">
        <div class="logo">UPC二手交易平台</div>
        
        <div class="nav-buttons">
	        <button class="nav-btn" onclick="window.location.href='main.jsp'">返回主页</button>
	        <button class="nav-btn" onclick="window.location.href='infolr.jsp'">商品录入</button>
	        <button class="nav-btn" onclick="window.location.href='infocx.jsp'">商品查询</button>
	        <button class="nav-btn" onclick="window.location.href='mycollection.jsp'">我的收藏</button>
	        <button class="nav-btn" onclick="window.location.href='myitems.jsp'">我的商品</button>
	        <button class="nav-btn" onclick="window.location.href='exit.jsp'">退出系统</button>
        </div>
    </div>
  <div class="container">
	<%
	    request.setCharacterEncoding("UTF-8");
	    response.setCharacterEncoding("UTF-8");
	    String flag = (String)session.getAttribute("flag");
	    if(flag==null || flag!="success") {
	        out.println("<div class='debug-info'>Session验证失败，flag=" + flag + "，应重定向到error.jsp</div>");
	        // 在生产环境可以取消注释下面的重定向
	        // response.sendRedirect("error.jsp");
	    }
	    
	    String uname = (String)session.getAttribute("uname");
	    String role = (String)session.getAttribute("role"); // 获取用户角色
	    boolean isAdmin = "admin".equals(role); // 判断是否为管理员
	    
	    if(uname == null) {
	        out.println("<div class='debug-info'>未获取到用户名，uname为null</div>");
	        uname = "未知用户";
	    } else {
	        out.println("<div class='user-info'>当前用户：" + uname + (isAdmin ? " (管理员)" : "") + "</div>");
	    }
	
	    // 获取商品ID
	    String itemId = request.getParameter("itemid");
	    if(itemId == null || itemId.isEmpty()) {
	        out.println("<div class='debug-info'>未获取到商品ID参数</div>");
	        %>
	        <div style="text-align: center; padding: 50px 0;">
	            <h2 style="color: #dc2626; margin-bottom: 20px;">缺少商品ID参数</h2>
	            <p style="margin-bottom: 20px; font-size: 18px;">请返回并选择一个商品查看详情。</p>
	            <button class="action-btn back-btn" onclick="history.back()">返回上一页</button>
	        </div>
	        <%
	    } else {
	        out.println("<div class='debug-info'>接收到的商品ID: " + itemId + "</div>");
	        
	        // 变量初始化
	        String resultStatus = "";
	        String resultMessage = "";
	        sqlBean db = null;
	        ResultSet rs = null;
	        
	        try {
	            db = new sqlBean();
	            
	            // 处理收藏/取消收藏操作
	            if("add".equals(request.getParameter("action"))) {
	                out.println("<div class='debug-info'>正在处理收藏操作</div>");
	                try {
	                    // 检查是否已收藏
	                    String checkSql = "SELECT itemid FROM collection WHERE username=? AND itemid=?";
	                    out.println("<div class='debug-info'>准备执行检查收藏SQL</div>");
	                    
	                    PreparedStatement checkStmt = db.getPreparedStatement(checkSql);
	                    checkStmt.setString(1, uname);
	                    checkStmt.setInt(2, Integer.parseInt(itemId));
	                    
	                    ResultSet checkRs = checkStmt.executeQuery();
	                    if(checkRs != null && checkRs.next()) {
	                        resultStatus = "warning";
	                        resultMessage = "您已经收藏过此商品";
	                    } else {
	                        // 添加收藏
	                        String addSql = "INSERT INTO collection (username, itemid, collectdate) VALUES (?, ?, NOW())";
	                        out.println("<div class='debug-info'>准备执行添加收藏SQL</div>");
	                        
	                        PreparedStatement addStmt = db.getPreparedStatement(addSql);
	                        addStmt.setString(1, uname);
	                        addStmt.setInt(2, Integer.parseInt(itemId));
	                        
	                        if(addStmt.executeUpdate() > 0) {
	                            resultStatus = "success";
	                            resultMessage = "收藏成功！";
	                        } else {
	                            resultStatus = "error";
	                            resultMessage = "收藏失败，请稍后再试";
	                        }
	                        addStmt.close();
	                    }
	                    if(checkRs != null) checkRs.close();
	                    checkStmt.close();
	                } catch(Exception e) {
	                    resultStatus = "error";
	                    resultMessage = "收藏操作异常：" + e.getMessage();
	                    out.println("<div class='debug-info'>收藏操作异常: " + e.getMessage() + "</div>");
	                }
	            } else if("remove".equals(request.getParameter("action"))) {
	                // 新增：处理取消收藏
	                out.println("<div class='debug-info'>正在处理取消收藏操作</div>");
	                try {
	                    String removeSql = "DELETE FROM collection WHERE username=? AND itemid=?";
	                    out.println("<div class='debug-info'>准备执行取消收藏SQL</div>");
	                    
	                    PreparedStatement removeStmt = db.getPreparedStatement(removeSql);
	                    removeStmt.setString(1, uname);
	                    removeStmt.setInt(2, Integer.parseInt(itemId));
	                    
	                    if(removeStmt.executeUpdate() > 0) {
	                        resultStatus = "success";
	                        resultMessage = "已取消收藏！";
	                    } else {
	                        resultStatus = "error";
	                        resultMessage = "取消收藏失败，请稍后再试";
	                    }
	                    removeStmt.close();
	                } catch(Exception e) {
	                    resultStatus = "error";
	                    resultMessage = "取消收藏操作异常：" + e.getMessage();
	                    out.println("<div class='debug-info'>取消收藏操作异常: " + e.getMessage() + "</div>");
	                }
	            }
	
	            // 处理删除留言
	            if("deleteMessage".equals(request.getParameter("action"))) {
	                out.println("<div class='debug-info'>正在处理删除留言操作</div>");
	                try {
	                    String messageId = request.getParameter("messageId");
	                    if(messageId != null && !messageId.isEmpty()) {
	                        // 先验证是否为该留言的发送者或管理员
	                        String checkMsgSql = "SELECT sender FROM messages WHERE id=?";
	                        PreparedStatement checkMsgStmt = db.getPreparedStatement(checkMsgSql);
	                        checkMsgStmt.setInt(1, Integer.parseInt(messageId));
	                        ResultSet msgCheckRs = checkMsgStmt.executeQuery();
	                        
	                        boolean canDelete = false;
	                        if(msgCheckRs != null && msgCheckRs.next()) {
	                            String sender = msgCheckRs.getString("sender");
	                            // 如果是留言发送者或管理员，允许删除
	                            if(uname.equals(sender) || isAdmin) {
	                                canDelete = true;
	                            }
	                        }
	                        
	                        if(canDelete) {
	                            String deleteMsgSql = "DELETE FROM messages WHERE id=?";
	                            PreparedStatement deleteMsgStmt = db.getPreparedStatement(deleteMsgSql);
	                            deleteMsgStmt.setInt(1, Integer.parseInt(messageId));
	                            
	                            if(deleteMsgStmt.executeUpdate() > 0) {
	                                resultStatus = "success";
	                                resultMessage = "留言已删除！";
	                            } else {
	                                resultStatus = "error";
	                                resultMessage = "删除留言失败，请稍后再试";
	                            }
	                            deleteMsgStmt.close();
	                        } else {
	                            resultStatus = "error";
	                            resultMessage = "您没有权限删除此留言";
	                        }
	                        
	                        if(msgCheckRs != null) msgCheckRs.close();
	                        checkMsgStmt.close();
	                    }
	                } catch(Exception e) {
	                    resultStatus = "error";
	                    resultMessage = "删除留言操作异常：" + e.getMessage();
	                    out.println("<div class='debug-info'>删除留言操作异常: " + e.getMessage() + "</div>");
	                }
	            }
	            
	            // 处理删除商品
	            if("deleteItem".equals(request.getParameter("action"))) {
	                out.println("<div class='debug-info'>正在处理删除商品操作</div>");
	                try {
	                    // 获取商品所有者
	                    String getOwnerSql = "SELECT username FROM item WHERE itemid=?";
	                    PreparedStatement ownerStmt = db.getPreparedStatement(getOwnerSql);
	                    ownerStmt.setInt(1, Integer.parseInt(itemId));
	                    ResultSet ownerRs = ownerStmt.executeQuery();
	                    
	                    boolean canDelete = false;
	                    if(ownerRs != null && ownerRs.next()) {
	                        String owner = ownerRs.getString("username");
	                        // 如果是商品所有者或管理员，允许删除
	                        if(uname.equals(owner) || isAdmin) {
	                            canDelete = true;
	                        }
	                    }
	                    
	                    if(canDelete) {
	                        // 删除关联的收藏记录
	                        String deleteCollectionSql = "DELETE FROM collection WHERE itemid=?";
	                        PreparedStatement deleteCollectionStmt = db.getPreparedStatement(deleteCollectionSql);
	                        deleteCollectionStmt.setInt(1, Integer.parseInt(itemId));
	                        deleteCollectionStmt.executeUpdate();
	                        deleteCollectionStmt.close();
	                        
	                        // 删除关联的留言
	                        String deleteMessagesSql = "DELETE FROM messages WHERE itemid=?";
	                        PreparedStatement deleteMessagesStmt = db.getPreparedStatement(deleteMessagesSql);
	                        deleteMessagesStmt.setInt(1, Integer.parseInt(itemId));
	                        deleteMessagesStmt.executeUpdate();
	                        deleteMessagesStmt.close();
	                        
	                        // 删除商品
	                        String deleteItemSql = "DELETE FROM item WHERE itemid=?";
	                        PreparedStatement deleteItemStmt = db.getPreparedStatement(deleteItemSql);
	                        deleteItemStmt.setInt(1, Integer.parseInt(itemId));
	                        
	                        if(deleteItemStmt.executeUpdate() > 0) {
	                            // 重定向到商品列表页
	                            response.sendRedirect("main.jsp?status=deleted");
	                            return;
	                        } else {
	                            resultStatus = "error";
	                            resultMessage = "删除商品失败，请稍后再试";
	                        }
	                        deleteItemStmt.close();
	                    } else {
	                        resultStatus = "error";
	                        resultMessage = "您没有权限删除此商品";
	                    }
	                    
	                    if(ownerRs != null) ownerRs.close();
	                    ownerStmt.close();
	                } catch(Exception e) {
	                    resultStatus = "error";
	                    resultMessage = "删除商品操作异常：" + e.getMessage();
	                    out.println("<div class='debug-info'>删除商品操作异常: " + e.getMessage() + "</div>");
	                }
	            }
	
	            // 处理留言提交
	            if("post".equals(request.getParameter("action"))) {
	                out.println("<div class='debug-info'>正在处理留言操作</div>");
	                try {
	                    String messageContent = request.getParameter("message");
	                    if(messageContent != null && !messageContent.trim().isEmpty()) {
	                        // 先获取商品所有者
	                        String getOwnerSql = "SELECT username FROM item WHERE itemid=?";
	                        PreparedStatement ownerStmt = db.getPreparedStatement(getOwnerSql);
	                        ownerStmt.setInt(1, Integer.parseInt(itemId));
	                        ResultSet ownerRs = ownerStmt.executeQuery();
	                        
	                        if(ownerRs != null && ownerRs.next()) {
	                            String receiver = ownerRs.getString("username");
	                            
	                            String addMsgSql = "INSERT INTO messages (itemid, sender, receiver, content, sendtime) VALUES (?, ?, ?, ?, NOW())";
	                            out.println("<div class='debug-info'>准备执行留言SQL</div>");
	                            
	                            PreparedStatement msgStmt = db.getPreparedStatement(addMsgSql);
	                            msgStmt.setInt(1, Integer.parseInt(itemId));
	                            msgStmt.setString(2, uname);
	                            msgStmt.setString(3, receiver);
	                            msgStmt.setString(4, messageContent);
	                            
	                            if(msgStmt.executeUpdate() > 0) {
	                                resultStatus = "success";
	                                resultMessage = "留言发送成功！";
	                            } else {
	                                resultStatus = "error";
	                                resultMessage = "留言发送失败，请稍后再试";
	                            }
	                            msgStmt.close();
	                        } else {
	                            resultStatus = "error";
	                            resultMessage = "找不到商品所有者信息";
	                        }
	                        if(ownerRs != null) ownerRs.close();
	                        ownerStmt.close();
	                    } else {
	                        resultStatus = "warning";
	                        resultMessage = "留言内容不能为空";
	                    }
	                } catch(Exception e) {
	                    resultStatus = "error";
	                    resultMessage = "留言操作异常：" + e.getMessage();
	                    out.println("<div class='debug-info'>留言操作异常: " + e.getMessage() + "</div>");
	                }
	            }
	
	            // 查询商品信息
	            String sql = "SELECT i.*, u.email, u.phone FROM item i LEFT JOIN useradmin u ON i.username = u.username WHERE i.itemid=?";
	            out.println("<div class='debug-info'>准备执行查询商品信息SQL</div>");
	            
	            try {
	                PreparedStatement pstmt = db.getPreparedStatement(sql);
	                pstmt.setInt(1, Integer.parseInt(itemId));
	                rs = pstmt.executeQuery();
	                
	                if(rs == null) {
	                    out.println("<div class='debug-info'>查询结果为null，检查sqlBean执行是否正确</div>");
	                    %>
	                    <div style="text-align: center; padding: 50px 0;">
	                        <h2 style="color: #dc2626; margin-bottom: 20px;">系统错误</h2>
	                        <p style="margin-bottom: 20px; font-size: 18px;">无法获取商品信息，请联系管理员。</p>
	                        <button class="action-btn back-btn" onclick="history.back()">返回上一页</button>
	                    </div>
	                    <%
	                } else if(!rs.next()) {
	                    out.println("<div class='debug-info'>查询结果为空，没有找到ID为" + itemId + "的商品</div>");
	                    %>
	                    <div style="text-align: center; padding: 50px 0;">
	                        <h2 style="color: #dc2626; margin-bottom: 20px;">商品不存在</h2>
	                        <p style="margin-bottom: 20px; font-size: 18px;">未找到ID为 <%= itemId %> 的商品信息。</p>
	                        <button class="action-btn back-btn" onclick="history.back()">返回上一页</button>
	                    </div>
	                    <%
	                } else {
	                    // 获取商品信息
	                    String itemName = rs.getString("itemname");
	                    String sellerName = rs.getString("username");
	                    String description = rs.getString("description") != null ? rs.getString("description") : "暂无描述";
	                    double price = rs.getDouble("price");
	                    String status = rs.getString("status");
	                    String condition = rs.getString("condition");
	                    String photo = rs.getString("photo") != null ? rs.getString("photo") : "images/default.jpg";
	                    String email = rs.getString("email");
	                    String phone = rs.getString("phone") != null ? rs.getString("phone") : "";
	                    
	                    // 格式化商品状态和成色显示
	                    String statusText = "未知";
	                    String conditionText = "未知";
	                    
	                    if("available".equals(status)) {
	                        statusText = "可购买";
	                    } else if("sold".equals(status)) {
	                        statusText = "已售出";
	                    }
	                    
	                    if("new".equals(condition)) {
	                        conditionText = "全新";
	                    } else if("seventy".equals(condition)) {
	                        conditionText = "七成新";
	                    } else if("fifty".equals(condition)) {
	                        conditionText = "五成新";
	                    } else if("thirdth".equals(condition)) {
	                        conditionText = "三成新及以下";
	                    }
	                    
	                    // 检查是否已收藏
	                    boolean isCollected = false;
	                    String checkCollectSql = "SELECT id FROM collection WHERE username=? AND itemid=?";
	                    PreparedStatement collectStmt = db.getPreparedStatement(checkCollectSql);
	                    collectStmt.setString(1, uname);
	                    collectStmt.setInt(2, Integer.parseInt(itemId));
	                    ResultSet collectRs = collectStmt.executeQuery();
	                    if(collectRs != null && collectRs.next()) {
	                        isCollected = true;
	                    }
	                    if(collectRs != null) collectRs.close();
	                    collectStmt.close();
	                    
	                    // 是否为自己的商品
	                    boolean isOwner = sellerName.equals(uname);
	                    
	                    // 输出商品详情
	                    %>
	                    <h1 class="page-title">商品详情</h1>
	
	                    <div class="item-container">
	                        <!-- 商品图片 -->
	                        <div class="item-image-container">
	                            <img src="<%= photo %>" alt="<%= itemName %>" class="item-image" onerror="this.src='images/default.jpg'">
	                        </div>
	
	                        <!-- 商品信息 -->
	                        <div class="item-info">
	                            <h2 class="item-title"><%= itemName %></h2>
	                            <div class="item-price">￥<%= String.format("%.2f", price) %></div>
	                            <div class="item-status <%= "available".equals(status) ? "status-available" : "status-sold" %>">
	                                <%= statusText %>
	                            </div>
	                            
	                            <div class="item-detail-row">
	                                <div class="item-detail-label">成色:</div>
	                                <div class="item-detail-value"><%= conditionText %></div>
	                            </div>
	                            
	                            <div class="item-detail-row">
	                                <div class="item-detail-label">卖家:</div>
	                                <div class="item-detail-value"><%= sellerName %></div>
	                            </div>
	                            
	                            <div class="item-description">
	                                <div class="desc-title">商品描述</div>
	                                <p><%= description %></p>
	                            </div>
	
	                            <!-- 操作按钮 -->
	                            <!-- 第一排按钮 -->
								<div class="action-buttons">
								    <% if(!isCollected) { %>
								        <button class="action-btn collect-btn" onclick="location.href='itemdetail.jsp?itemid=<%= itemId %>&action=add'">
								            加入收藏
								        </button>
								    <% } else { %>
								        <button class="action-btn uncollect-btn" onclick="location.href='itemdetail.jsp?itemid=<%= itemId %>&action=remove'">
								            取消收藏
								        </button>
								    <% } %>
								
								    <button class="action-btn back-btn" onclick="window.location.href='main.jsp'">
								        返回主页
								    </button>
								</div>
								
								<!-- 第二排按钮 -->
								<div class="action-buttons">
								    <% if(isOwner || isAdmin) { %>
								        <button class="delete-btn" onclick="confirmDeleteItem('<%= itemId %>')">
								            删除商品
								        </button>
								    <% } %>
								    
								</div>
	                        </div>
	                    </div>
	
	                    <div class="seller-section">
	                        <h3 class="section-title">卖家信息</h3>
	                        <p class="seller-name"><strong>卖家:</strong> <%= sellerName %></p>
	                    
	                        <% if(!isOwner) { %>
	                            <button class="contact-btn" onclick="showContactInfo()">查看联系方式</button>
	                            
	                            <!-- Contact Modal -->
	                            <div id="contactModal" class="modal">
	                                <div class="modal-content">
	                                    <button class="modal-close" onclick="hideContactInfo()">&times;</button>
	                                    <h3 class="modal-title"><%= sellerName %> 的联系方式</h3>
	                                    
	                                    <% if(phone != null && !phone.isEmpty()) { %>
	                                    <div class="contact-item">
	                                        <div class="contact-label">手机号码</div>
	                                        <div class="contact-value"><%= phone %></div>
	                                        <button class="copy-btn" onclick="copyToClipboard('<%= phone %>')">复制</button>
	                                    </div>
	                                    <% } %>
	
	                                    <% if(email != null && !email.isEmpty()) { %>
	                                    <div class="contact-item">
	                                        <div class="contact-label">电子邮箱</div>
	                                        <div class="contact-value"><%= email %></div>
	                                        <button class="copy-btn" onclick="copyToClipboard('<%= email %>')">复制</button>
	                                    </div>
	                                    <% } %>
	                                </div>
	                            </div>
	                        <% } %>
	                    </div>
	                    
	                    <!-- Message section with proper styling -->
	                    <div class="message-section">
	                        <h3 class="section-title">商品留言</h3>
	                    
	                        <div class="message-list">
	                            <% 
	                            // Query messages
	                            String msgSql = "SELECT m.*, u.username as senderName FROM messages m LEFT JOIN useradmin u ON m.sender = u.username WHERE m.itemid=" + itemId + " ORDER BY m.sendtime DESC";
	                            out.println("<div class='debug-info'>执行留言查询: " + msgSql + "</div>");
	                            
	                            ResultSet msgRs = db.executeQuery(msgSql);
	                            boolean hasMessages = false;
	                    
	                            if(msgRs != null) {
	                                while(msgRs.next()) {
	                                    hasMessages = true;
	                                    int messageId = msgRs.getInt("id");
	                                    String sender = msgRs.getString("senderName");
	                                    String content = msgRs.getString("content");
	                                    java.sql.Timestamp sendTime = msgRs.getTimestamp("sendtime");
	                                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	                                    String formattedTime = sdf.format(sendTime);
	                                    
	                                    // 检查是否为自己的留言或管理员
	                                    boolean canDeleteMessage = uname.equals(sender) || isAdmin;
	                            %>
	                            <div class="message-item">
	                                <div class="message-header">
	                                    <div class="message-user"><%= sender %></div>
	                                    <div class="message-date"><%= formattedTime %></div>
	                                    
	                                    <% if(canDeleteMessage) { %>
	                                    <div class="message-actions">
	                                        <button class="delete-message-btn" onclick="confirmDeleteMessage('<%= messageId %>')">删除</button>
	                                    </div>
	                                    <% } %>
	                                </div>
	                                <div class="message-content"><%= content %></div>
	                            </div>
	                            <% 
	                                }
	                                msgRs.close();
	                            } else {
	                                out.println("<div class='debug-info'>留言查询结果为null</div>");
	                            }
	                    
	                            if(!hasMessages) {
	                            %>
	                            <div class="no-messages">
	                                暂无留言，快来留下第一条留言吧！
	                            </div>
	                            <% } %>
	                        </div>
	                    
	                        <!-- Message form -->
	                        <% if(!isOwner && "available".equals(status)) { %>
	                        <div class="message-form">
	                            <h4 class="form-title">发表留言</h4>
	                            <form method="post" action="itemdetail.jsp?itemid=<%= itemId %>&action=post">
	                                <textarea name="message" class="form-control" placeholder="对该商品有什么问题想咨询卖家？在这里留言吧..." required></textarea>
	                                <button type="submit" class="submit-btn">发送留言</button>
	                            </form>
	                        </div>
	                        <% } %>
	                    </div>
	                    
	                    <!-- Result Modal -->
	                    <div id="resultModal" class="modal result-modal">
	                        <div class="modal-content">
	                            <h3 id="modalTitle" class="modal-title"></h3>
	                            <p id="modalMessage"></p>
	                            <button class="modal-button" onclick="closeModal()">确定</button>
	                        </div>
	                    </div>
	                    
	                    <!-- Confirm Delete Modal -->
	                    <div id="confirmModal" class="modal confirm-modal">
	                        <div class="modal-content">
	                            <h3 id="confirmTitle" class="modal-title">确认操作</h3>
	                            <p id="confirmMessage"></p>
	                            <div class="confirm-buttons">
	                                <button class="modal-button cancel-btn" onclick="hideConfirmModal()">取消</button>
	                                <button id="confirmButton" class="modal-button confirm-btn">确定</button>
	                            </div>
	                        </div>
	                    </div>
	                    
	                    <script>
	                        // Show contact info modal
	                        function showContactInfo() {
	                            document.getElementById('contactModal').style.display = 'flex';
	                        }
	                    
	                        // Hide contact info modal
	                        function hideContactInfo() {
	                            document.getElementById('contactModal').style.display = 'none';
	                        }
	                    
	                        // Copy to clipboard
	                        function copyToClipboard(text) {
	                            const textarea = document.createElement('textarea');
	                            textarea.value = text;
	                            document.body.appendChild(textarea);
	                            textarea.select();
	                            document.execCommand('copy');
	                            document.body.removeChild(textarea);
	                    
	                            // Show success message
	                            showModal("成功", "已复制到剪贴板", "success");
	                        }
	                    
	                        // Show modal
	                        function showModal(title, message, status) {
	                            document.getElementById('modalTitle').textContent = title;
	                            document.getElementById('modalMessage').textContent = message;
	                            document.getElementById('resultModal').style.display = "flex";
	                        }
	                    
	                        // Close modal
	                        function closeModal() {
	                            document.getElementById('resultModal').style.display = "none";
	                        }
	                        
	                        // Confirm delete message
	                        function confirmDeleteMessage(messageId) {
	                            document.getElementById('confirmMessage').textContent = "确定要删除这条留言吗？";
	                            document.getElementById('confirmButton').onclick = function() {
	                            	window.location.href = 'itemdetail.jsp?itemid=' + '<%= itemId %>' + '&action=deleteMessage&messageId=' + messageId;
	                            };
	                            document.getElementById('confirmModal').style.display = 'flex';
	                        }
	                        
	                        // Confirm delete item
	                        function confirmDeleteItem(itemId) {
	                            document.getElementById('confirmMessage').textContent = "确定要删除这个商品吗？此操作不可恢复，相关的收藏和留言也将被删除。";
	                            document.getElementById('confirmButton').onclick = function() {
	                                window.location.href = 'itemdetail.jsp?itemid=' + itemId + '&action=deleteItem';
	                            };
	                            document.getElementById('confirmModal').style.display = 'flex';
	                        }
	                        
	                        // Hide confirm modal
	                        function hideConfirmModal() {
	                            document.getElementById('confirmModal').style.display = 'none';
	                        }
	                    </script>
	                    
	                    <% if (!resultStatus.isEmpty()) { %>
	                        <script>
	                            // 自动显示结果弹窗
	                            window.onload = function() {
	                                showModal('<%= "success".equals(resultStatus) ? "成功" : ("warning".equals(resultStatus) ? "提示" : "错误") %>',
	                                        "<%= resultMessage %>", 
	                                        "<%= resultStatus %>");
	                            }
	                        </script>
	                    <% } %>
	                <% } // end of else (rs.next()) 
	            } catch(SQLException e) {
	                out.println("<div class='debug-info'>SQL执行异常: " + e.getMessage() + "</div>");
	                out.println("<h2>数据库查询失败</h2>");
	                out.println("<p>错误信息: " + e.getMessage() + "</p>");
	                out.println("<button onclick='history.back()'>返回</button>");
	            }
	        } catch(Exception e) {
	            out.println("<div class='debug-info'>系统异常: " + e.getMessage() + "</div>");
	            out.println("<h2>系统错误</h2>");
	            out.println("<p>错误信息: " + e.getMessage() + "</p>");
	            out.println("<button onclick='history.back()'>返回</button>");
	        } finally {
    
                // 关闭数据库连接
                try {
                    if(rs != null) rs.close();
                    if(db != null) db.closeDB();
                } catch(Exception e) {
                    out.println("<div class='debug-info'>关闭数据库连接异常: " + e.getMessage() + "</div>");
                }
            }
        } // end of if itemId != null
        %>
    </div>
</body>
</html>