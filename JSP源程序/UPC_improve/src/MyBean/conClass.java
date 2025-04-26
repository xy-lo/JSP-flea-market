package MyBean;
public class conClass {
	
	public static String tochinese(String str)
	{
		try{
			byte s[]=str.getBytes("ISO-8859-1");
			str = new String(s,"utf-8");
			return str;
		}
		catch(Exception e)
		{ return str;}
	}

}
