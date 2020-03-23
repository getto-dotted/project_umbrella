package com.project.umbrella;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ApiCalling {
	
	@RequestMapping(value = "/weather.do", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView sendGetJson(HttpServletRequest req) throws Exception {
				
		ModelAndView mv = new ModelAndView();
		req.setCharacterEncoding("UTF-8");
		String name = req.getParameter("name");
                
        //String name2 = new String(name.getBytes("8859_1"),"UTF-8");
                
		URL url = new URL ("https://umbrella-machine3.run.goorm.io/?name="+name);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Content-Type", "application/json; UTF-8");
        con.setRequestProperty("Accept", "application/json");        
        
        try {        	        	
        	BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));        	
        	StringBuilder response = new StringBuilder();            
        	String responseLine = null;
        	String res = "";
        	while ((responseLine = br.readLine()) != null) {
        		response.append(responseLine.trim()); 
        		res = response.toString();
        	}
        	
        	String today = res.split(" ")[0];
            String tomorrow = res.split(" ")[1];
                              
            if(today.contains("doctype")) {
            	System.out.println("서버꺼짐");
            	mv.setViewName("404");
            	return mv;
            }
            else {
            	
            	System.out.println(today+"/////"+ tomorrow);
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
            	mv.setViewName("result");
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
