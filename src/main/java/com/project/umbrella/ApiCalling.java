package com.project.umbrella;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mybatis.MyLocDAO;

@Controller
public class ApiCalling {//api를 호출하는 클래스
	
	private SqlSession sqlSession;

	@Autowired//mybatis를 위한 @Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		System.out.println("@Autowired->ApiCalling");
	}
	
	@RequestMapping(value = "/weather.do", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView sendGetJson(HttpServletRequest req) throws Exception {
				
		ModelAndView mv = new ModelAndView();
		req.setCharacterEncoding("UTF-8");
		String name = req.getParameter("name");
		String loc = req.getParameter("loc");
                
        //String name2 = new String(name.getBytes("8859_1"),"UTF-8");
        //구름ide에서는 브라우저 인코딩인 8859_1을 변환시키지 않으면 에러가 난다.
		
		URL url = new URL ("https://umbrella-machine3.run.goorm.io/?name="+name);//api정보를 받아올 url주소
        HttpURLConnection con = (HttpURLConnection) url.openConnection();//url과 연결하고 그것을 HttpURLConnection타입으로 변환한다.
        con.setRequestMethod("GET");//전송방식을 get으로 설정
        con.setRequestProperty("Content-Type", "application/json; UTF-8");//받아올 데이터 타입을 utf-8의 json형식으로 지정
        con.setRequestProperty("Accept", "application/json");
        
        try {        	        	
        	BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
        	//읽어온 데이터를 해석할 BufferedReader를 생성한다. UTF-8로 읽어온 InputStream데이터를 InputStreamReader로 읽게 한다.
        	StringBuilder response = new StringBuilder();//스트링을 이어붙여줄 StringBuilder 객체 생성        
        	String responseLine = null;//null값의 스트링을 생성한다.
        	String res = "";//빈값의 스트링을 생성한다.
        	while ((responseLine = br.readLine()) != null) {//null값으로 생성한 스트링에 값이 들어오면(받아온 데이터가 있으면)
        		response.append(responseLine.trim());//받아온 데이터에서 공백을 제거하고 StringBuilder객체에 이어붙여준다.
        		res = response.toString();//빈값의 스트링에 해당 내용을 스트링으로 형변환 하여 입력해준다.
        	}
        	
        	String today = res.split(" ")[0];
            String tomorrow = res.split(" ")[1];                              
            
            String today2;
    		String tomorrow2;
    		
    		if(today.contains("sunny")) {
    			today2="1";
    		}
    		else {
    			today2="0";
    		}
    		if(tomorrow.contains("sunny")) {
    			tomorrow2="1";
    		}
    		else {
    			tomorrow2="0";
    		}   		
            
            if(today.contains("doctype")) {
            	System.out.println("서버꺼짐");
            	mv.setViewName("404");
            	return mv;
            }
            else {
            	
            	if(today.contains("sunny")) {
            		mv.addObject("today", "sunny");        	
            	}
            	else{
            		mv.addObject("today", "rainy"); 
            	}            
            	if(tomorrow.contains("sunny")) {
            		mv.addObject("tomorrow", "sunny");
            	}
            	else{
            		mv.addObject("tomorrow", "rainy"); 
            	}    
            	mv.addObject("loc",loc);
            	mv.setViewName("result");
            	
            	sqlSession.getMapper(MyLocDAO.class).write(loc, today2, tomorrow2);
            	
            	return mv;            	
            }
            
			
			} catch (Exception e) {
				e.printStackTrace(); 
				System.out.println("try에러 발생");
				
				mv.setViewName("404"); 
				return mv; 
			}
        
    }	
}
