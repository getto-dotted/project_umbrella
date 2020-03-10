package com.project.umbrella;

import java.sql.Connection;
import java.sql.DriverManager;
 
public class Common {
 
    public static void main(String[] args) {
        Connection con = null;
        
        String className = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/project2?useSSL=false&useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
        String user = "root";
        String passwd = "1234";
        
        try {
            Class.forName(className);
            con = DriverManager.getConnection(url, user, passwd);
            System.out.println("Connect Success!");
        } catch(Exception e) {
            System.out.println("Connect Failed!");
            e.printStackTrace();
        } finally {
                try {
                    if(con != null && !con.isClosed()) {
                        con.close();
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                }
        }
        
    }
}

