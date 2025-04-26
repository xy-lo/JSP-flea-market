package MyBean;

import java.util.*;
import java.sql.*;

public class sqlBean {
	
	 private Connection con = null;
	 
	 public Statement getStatement(){  
		 Statement stmt=null;
		 try{ 
			 //����MySql�������� 
			 Class.forName("com.mysql.jdbc.Driver"); 
			 }catch(ClassNotFoundException e){ 
			 System.out.println("�Ҳ������������� ����������ʧ�ܣ�"); 
			 e.printStackTrace() ; 
			 }
		
		//����MySql���ݿ⣬�����ݿ�˿ڣ�3306
		 //���ݿ�����test1
		 //�û���sa������Sa123456 
		  String url ="jdbc:mysql://rm-cn-oo047rmxr0004lbo.rwlb.rds.aliyuncs.com:3306/test1" ;  
		  String username = "sa" ; 
		  String password = "Sa123456" ; 
		  try{ 
		 con =DriverManager.getConnection(url,username,password); 
		  }catch(SQLException se){ 
		 System.out.println("���ݿ������������ʧ�ܣ�"); 
		 se.printStackTrace() ; 
		  }
		  try {  
	       stmt=con.createStatement();
	       }catch(Exception e){  
	            System.out.println("���ݿ�����ʧ��!!!"+e.getMessage());  
	        }  

	        return stmt;  
	    }  
	   
	 
	    /** 
	     * ִ��sql�������ݿ��ѯ 
	     * @param sql 
	     * @return 
	     */  
	    public ResultSet executeQuery(String sql){  
	        ResultSet rs=null;  
	        try {  
	            rs=getStatement().executeQuery(sql);  
	        } catch (SQLException e) {  
	            e.printStackTrace();  
	            System.out.println("���ݿ��ѯʧ��!!!"+e.getMessage());  
	        }  
	        return rs;  
	    }  
	    
	    
	    /** 
	     * ִ��sql�������ݿ����(��ɾ��)
	     */  
	    public int executeUpdate(String sql){  
	        int i=0;  
	        try {  
	            i=getStatement().executeUpdate(sql);  
	        } catch (SQLException e) {
	            e.printStackTrace();  
	            System.out.println("ִ�����ݿ��������!!!"+e.getMessage());  
	        }  
	        return i;  
	    }  
	    
	    /** 
	     * �ر����ݿ�
	     */  
	    
	    public void closeDB() {
	    	try{
	    		con.close();
	    	} catch (SQLException e) {
	    		System.out.println("���ݿ�رմ���!!!"+e.getMessage());  
	    	}
	    	
	    }
	    public PreparedStatement getPreparedStatement(String sql) throws SQLException {
	        if (con == null || con.isClosed()) {
	            // �������δ�������Ѿ��رգ�����������
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
