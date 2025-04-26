<%@ page language="java" contentType="text/html;charset=utf-8" import="java.util.*,java.sql.*,MyBean.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>UPC二手交易平台</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Google 字体 Poppins -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <!-- Font Awesome 图标库 -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
    body { width: 100%; height: 100vh; overflow: hidden; background: #f0f2f5; }
    .container { display: flex; height: 100vh; }
    .main-area {
      flex: 1;
      background: url('${pageContext.request.contextPath}/images/自由女神.png') center/cover no-repeat;
      position: relative;
    }
    .logo-container { position: absolute; top: 20px; left: 20px; display: flex; align-items: center; }
    .logo {
      height: 60px;
      margin-right: 10px;
    }    
    .logo-text { color: #fff; font-size: 24px; font-weight: 700; text-shadow: 1px 1px 3px rgba(0,0,0,0.5); }
    .author-info { position: absolute; bottom: 20px; left: 20px; color: #fff; font-size: 14px; text-shadow: 1px 1px 3px rgba(0,0,0,0.5); }
    .sidebar {
      width: 400px;
      background: rgba(255,255,255,0.2);
      backdrop-filter: blur(12px);
      border: 1px solid rgba(255,255,255,0.3);
      border-radius: 20px;
      box-shadow: 0 8px 32px rgba(0,0,0,0.1);
      padding: 40px;
      display: flex;
      flex-direction: column;
      overflow-y: auto;
    }
    .platform-name { font-size: 28px; color: #2c3e50; text-align: center; font-weight: 600; margin-bottom: 30px; }
    .warning-message {
      background: linear-gradient(90deg, rgba(255,255,255,0.3), rgba(255,255,255,0.1));
      backdrop-filter: blur(8px);
      border: 1px solid rgba(255,255,255,0.4);
      border-radius: 12px;
      padding: 16px;
      color: #2c3e50;
      font-size: 16px;
      text-align: center;
      margin-bottom: 30px;
    }
    .form-group { margin-bottom: 20px; position: relative; }
    .input-with-icon { position: relative; }
    .icon {
      position: absolute;
      left: 14px;
      top: 50%;
      transform: translateY(-50%);
      color: #999;
      font-size: 18px;
      width: 24px;
      display: inline-block;
      text-align: center;
    }
    input {
      width: 100%;
      padding: 14px 14px 14px 48px;
      border: none;
      border-radius: 12px;
      background: #f0f0f3;
      box-shadow: inset 4px 4px 8px rgba(0,0,0,0.1), inset -4px -4px 8px rgba(255,255,255,0.7);
      font-size: 15px;
      transition: box-shadow 0.3s;
    }
    input:focus { box-shadow: inset 2px 2px 4px rgba(0,0,0,0.2), inset -2px -2px 4px rgba(255,255,255,0.9); outline: none; }
    .login-btn, .register-btn {
      width: 100%;
      background: linear-gradient(135deg, #4e54c8, #8f94fb);
      color: #fff;
      border: none;
      border-radius: 12px;
      padding: 14px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      box-shadow: 0 4px 14px rgba(78,84,200,0.4);
      transition: transform 0.2s, box-shadow 0.2s;
      margin-bottom: 10px;
    }
    .register-btn {
      background: linear-gradient(135deg, #36d1dc, #5b86e5);
    }
    .login-btn:hover, .register-btn:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(78,84,200,0.5); }
    .options { display: flex; justify-content: center; margin-top: 15px; font-size: 14px; }
    .options a { color: #4e54c8; text-decoration: none; transition: opacity 0.2s; margin: 0 10px; }
    .options a:hover { opacity: 0.7; }
    .notification {
      position: fixed;
      top: 20px;
      right: 20px;
      padding: 15px 20px;
      border-radius: 10px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.2);
      z-index: 1000;
      display: none;
    }
    .notification.success {
      background-color: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }
    .notification.error {
      background-color: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }
    .footer { margin-top: auto; text-align: center; font-size: 12px; color: #999; padding-top: 20px; }
    .tabs {
      display: flex;
      justify-content: center;
      margin-bottom: 20px;
    }
    .tab {
      padding: 10px 20px;
      cursor: pointer;
      border-bottom: 2px solid transparent;
      transition: all 0.3s;
      font-weight: 600;
      color: #999;
    }
    .tab.active {
      color: #4e54c8;
      border-bottom: 2px solid #4e54c8;
    }
    .form-container {
      display: none;
    }
    .form-container.active {
      display: block;
    }
    @media (max-width: 768px) {
      .container { flex-direction: column; }
      .main-area { height: 30vh; }
      .sidebar { width: 100%; height: 70vh; }
      .logo-container { top: 10px; left: 10px; }
      .platform-name { font-size: 24px; }
    }
  </style>
  <script>
    function showNotification(message, type) {
      const notification = document.getElementById('notification');
      notification.textContent = message;
      notification.className = 'notification ' + type;
      notification.style.display = 'block';
      
      setTimeout(() => {
        notification.style.display = 'none';
      }, 3000);
    }
    
    function switchTab(tabName) {
      // 隐藏所有表单
      document.querySelectorAll('.form-container').forEach(form => {
        form.classList.remove('active');
      });
      
      // 取消所有标签的活动状态
      document.querySelectorAll('.tab').forEach(tab => {
        tab.classList.remove('active');
      });
      
      // 激活选定的表单和标签
      document.getElementById(tabName + '-form').classList.add('active');
      document.getElementById(tabName + '-tab').classList.add('active');
    }
  </script>
</head>
<body>
  <!-- 通知弹窗 -->
  <div id="notification" class="notification"></div>

<div class="container">
    <div class="main-area">
      <div class="logo-container">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="UPC Logo" class="logo" />
      </div>
      <div class="author-info">Design by：电子（实验）2201 徐银</div>
    </div>
    <div class="sidebar">
      <div class="platform-name">
       UPC二手交易平台
      </div>
      <div class="warning-message"><strong>平台宗旨：</strong> 让校园资源流动起来，服务每一位同学。</div>
      <div class="tabs">
        <div id="login-tab" class="tab active" onclick="switchTab('login')">登录</div>
        <div id="register-tab" class="tab" onclick="switchTab('register')">注册</div>
      </div>
      
      <%
      // 处理登录表单提交
      if(request.getMethod().equalsIgnoreCase("POST") && request.getParameter("action") != null) {
          String action = request.getParameter("action");
          
          if(action.equals("login")) {
              String uname = request.getParameter("uname");
              if(uname != null) {
                  uname = conClass.tochinese(uname);
                  String upwd = request.getParameter("upwd");
                  
                  try {
                      sqlBean db = new sqlBean();
                      if(db != null && db.getStatement() != null) {
                          String sql = String.format("select * from userAdmin where username='%s' and password='%s'", uname, upwd);
                          ResultSet rs = db.executeQuery(sql);
                          
                          if(rs != null && rs.next()) {
                              // 登录成功
                              String role = rs.getString("role");
                              session.setAttribute("uname", uname);
                              session.setAttribute("role", role);
                              session.setAttribute("flag", "success");
                              response.sendRedirect("main.jsp");
                              return; // 确保不继续执行后面的代码
                          } else {
                              // 登录失败 - 用户名或密码错误
                              out.println("<script>showNotification('用户名或密码错误！', 'error');</script>");
                          }
                      } else {
                          // 数据库连接错误
                          out.println("<script>showNotification('系统错误：无法连接到数据库！', 'error');</script>");
                      }
                  } catch(Exception e) {
                      // 异常处理
                      out.println("<script>showNotification('系统错误：" + e.getMessage() + "', 'error');</script>");
                  }
              } else {
                  // 没有输入用户名
                  out.println("<script>showNotification('请输入用户名！', 'error');</script>");
              }
          } 
          
          else if(action.equals("register")) { 
        	    String username = request.getParameter("reg_username");
        	    String password = request.getParameter("reg_password");
        	    String confirmPassword = request.getParameter("confirm_password");
        	    String phone = request.getParameter("phone");
        	    String email = request.getParameter("email");

        	    if(username != null && password != null && confirmPassword != null) {
        	        username = conClass.tochinese(username);
        	        
        	        // 检查密码是否匹配
        	        if(!password.equals(confirmPassword)) {
        	            out.println("<script>showNotification('两次输入的密码不一致！', 'error'); switchTab('register');</script>");
        	            return;
        	        }
        	        
        	        try {
        	            sqlBean db = new sqlBean();
        	            if(db != null && db.getStatement() != null) {
        	                // 检查用户名是否已存在
        	                String checkSql = String.format("SELECT * FROM userAdmin WHERE username='%s'", username);
        	                ResultSet checkRs = db.executeQuery(checkSql);
        	                
        	                if(checkRs != null && checkRs.next()) {
        	                    // 用户名已存在
        	                    out.println("<script>showNotification('用户名已存在，请选择其他用户名！', 'error'); switchTab('register');</script>");
        	                } else {
        	                    // 插入新用户（包含电话和邮箱）
        	                    String insertSql = String.format(
        	                        "INSERT INTO userAdmin (username, password, role, phone, email) VALUES ('%s', '%s', 'normal', '%s', '%s')", 
        	                        username, password, phone, email
        	                    );
        	                    int result = db.executeUpdate(insertSql);
        	                    
        	                    if(result > 0) {
        	                        // 注册成功
        	                        out.println("<script>showNotification('注册成功！请登录', 'success'); switchTab('login');</script>");
        	                    } else {
        	                        // 注册失败
        	                        out.println("<script>showNotification('注册失败，请重试！', 'error'); switchTab('register');</script>");
        	                    }
        	                }
        	            } else {
        	                // 数据库连接错误
        	                out.println("<script>showNotification('系统错误：无法连接到数据库！', 'error');</script>");
        	            }
        	        } catch(Exception e) {
        	            // 异常处理
        	            out.println("<script>showNotification('系统错误：" + e.getMessage() + "', 'error'); switchTab('register');</script>");
        	        }
        	    } else {
        	        // 表单数据不完整
        	        out.println("<script>showNotification('请填写所有必填字段！', 'error'); switchTab('register');</script>");
        	    }
        	}


          

      }
      %>

      <!-- 登录表单 -->
      <div id="login-form" class="form-container active">
        <form method="post" action="" name="lgform">
          <input type="hidden" name="action" value="login">
          <div class="form-group">
            <div class="input-with-icon">
              <i class="fas fa-user icon"></i>
              <input type="text" name="uname" placeholder="用户名" maxlength="20" required />
            </div>
          </div>
          <div class="form-group">
            <div class="input-with-icon">
              <i class="fas fa-lock icon"></i>
              <input type="password" name="upwd" placeholder="密码" maxlength="20" required />
            </div>
          </div>
          <button type="submit" class="login-btn">登录</button>
        </form>
      </div>
      
      <!-- 注册表单 -->
      <div id="register-form" class="form-container">
        <form method="post" action="" name="regform">
          <input type="hidden" name="action" value="register">
          <div class="form-group">
            <div class="input-with-icon">
              <i class="fas fa-user icon"></i>
              <input type="text" name="reg_username" placeholder="用户名" maxlength="50" required />
            </div>
          </div>
          <div class="form-group">
            <div class="input-with-icon">
              <i class="fas fa-lock icon"></i>
              <input type="password" name="reg_password" placeholder="密码" maxlength="20" required />
            </div>
          </div>
          <div class="form-group">
            <div class="input-with-icon">
              <i class="fas fa-check icon"></i>
              <input type="password" name="confirm_password" placeholder="确认密码" maxlength="20" required />
            </div>
          </div>
			<div class="form-group input-with-icon">
			  <span class="icon"><i class="fas fa-phone-alt"></i></span>
			  <input type="text" name="phone" placeholder="联系电话" required />
			</div>
			
			<div class="form-group input-with-icon">
			  <span class="icon"><i class="fas fa-envelope"></i></span>
			  <input type="email" name="email" placeholder="邮箱地址" required />
			</div>
          
          <button type="submit" class="register-btn">注册</button>
        </form>
      </div>
      
      <div class="options">
        <a href="#" id="logout">安全退出</a>
        <a href="#" id="contact">联系作者</a>
      </div>

      <div class="footer">© 2025 UPC二手交易平台 | 电子（实验）2201 徐银</div>
    </div>
  </div>
</body>
</html>

<script>
// 安全退出：清空所有 input、textarea、select 的值
  document.getElementById('logout').addEventListener('click', function(e) {
    e.preventDefault();
    const inputs = document.querySelectorAll('input, textarea, select');
    inputs.forEach(el => {
      if (el.type === 'checkbox' || el.type === 'radio') {
        el.checked = false; // 清除勾选
      } else {
        el.value = ''; // 清除文字
      }
    });
  });

  // 联系作者
  document.getElementById('contact').addEventListener('click', function(e) {
    e.preventDefault(); // 阻止默认跳转
    window.open('https://github.com/xy-lo', '_blank'); // 新标签打开 GitHub
  });
</script>ss