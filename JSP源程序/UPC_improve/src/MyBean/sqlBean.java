package MyBean;

import java.util.*;
import java.sql.*;

public class sqlBean {
	
	 private Connection con = null;
	 
	 public Statement getStatement(){  
		 Statement stmt=null;
		 try{ 
			 //加载MySql的驱动类 
			 Class.forName("com.mysql.jdbc.Driver"); 
			 }catch(ClassNotFoundException e){ 
			 System.out.println("找不到驱动程序类 ，加载驱动失败！"); 
			 e.printStackTrace() ; 
			 }
		
		//连接MySql数据库，云数据库端口：3306
		 //数据库名：test1
		 //用户名sa和密码Sa123456 
		  String url ="jdbc:mysql://rm-cn-oo047rmxr0004lbo.rwlb.rds.aliyuncs.com:3306/test1" ;  
		  String username = "sa" ; 
		  String password = "Sa123456" ; 
		  try{ 
		 con =DriverManager.getConnection(url,username,password); 
		  }catch(SQLException se){ 
		 System.out.println("数据库参数错误，连接失败！"); 
		 se.printStackTrace() ; 
		  }
		  try {  
	       stmt=con.createStatement();
	       }catch(Exception e){  
	            System.out.println("数据库连接失败!!!"+e.getMessage());  
	        }  

	        return stmt;  
	    }  
	   
	 
	    /** 
	     * 执行sql语句的数据库查询 
	     * @param sql 
	     * @return 
	     */  
	    public ResultSet executeQuery(String sql){  
	        ResultSet rs=null;  
	        try {  
	            rs=getStatement().executeQuery(sql);  
	        } catch (SQLException e) {  
	            e.printStackTrace();  
	            System.out.println("数据库查询失败!!!"+e.getMessage());  
	        }  
	        return rs;  
	    }  
	    
	    
	    /** 
	     * 执行sql语句的数据库更新(增删改)
	     */  
	    public int executeUpdate(String sql){  
	        int i=0;  
	        try {  
	            i=getStatement().executeUpdate(sql);  
	        } catch (SQLException e) {
	            e.printStackTrace();  
	            System.out.println("执行数据库操作错误!!!"+e.getMessage());  
	        }  
	        return i;  
	    }  
	    
	    /** 
	     * 关闭数据库
	     */  
	    
	    public void closeDB() {
	    	try{
	    		con.close();
	    	} catch (SQLException e) {
	    		System.out.println("数据库关闭错误!!!"+e.getMessage());  
	    	}
	    	
	    }
	    public PreparedStatement getPreparedStatement(String sql) throws SQLException {
	        if (con == null || con.isClosed()) {
	            // 如果连接未建立或已经关闭，则重新连接
	            String url = "jdbc:mysql://rm-cn-oo047rmxr0004lbo.rwlb.rds.aliyuncs.com:3306/test1";
	            String username = "sa";
	            String password = "Sa123456";
	            try {
	                Class.forName("com.mysql.jdbc.Driver");
	                con = DriverManager.getConnection(url, username, password);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	        return con.prepareStatement(sql);
	    }

}
