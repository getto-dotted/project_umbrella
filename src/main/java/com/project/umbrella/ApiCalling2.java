package com.project.umbrella;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ApiCalling2 {
	
	@RequestMapping(value = "/weather.do", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView sendGetJson(HttpServletRequest req) throws Exception {
				
		ModelAndView mv = new ModelAndView();
		
		String name = req.getParameter("name");
		String age = req.getParameter("age");
		
		//https://test-django-dazza.run.goorm.io/
		URL url = new URL ("https://test-django-wkrud.run.goorm.io/?name="+name+"&age="+age);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Content-Type", "application/json; UTF-8");
        con.setRequestProperty("Accept", "application/json");
  
        
        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
        StringBuilder response = new StringBuilder();            

        String responseLine = null;
        while ((responseLine = br.readLine()) != null) {
            response.append(responseLine.trim());                
        }
        
        JSONParser jsonParser = new JSONParser(); 
		JSONObject jsonObj = (JSONObject) jsonParser.parse(response.toString());
		
		Iterator<String> keys = jsonObj.keySet().iterator();
		int i = 1;
		while( keys.hasNext() ){
			
            String key = keys.next();            
            Object value = jsonObj.get(key);             
            mv.addObject("name"+i, key);
            mv.addObject("age"+i, value);           
            i++;
            System.out.println( String.format("키: %s, 키값2 : %s", key, jsonObj.get(key)) );
        }
        
        mv.setViewName("index2");
        return mv;
    }
	
	public static void main(String[] args) throws Exception {
		
		String jsonData = "";
		
		try { 
			JSONParser jsonParser = new JSONParser(); 
			JSONObject jsonObj = (JSONObject) jsonParser.parse(jsonData);
			
			Iterator<String> keys = jsonObj.keySet().iterator();
	        
			while( keys.hasNext() ){
	            String key = keys.next();
	            System.out.println( String.format("키: %s, 키값 : %s", key, jsonObj.get(key)) );
	        }
			
			
			//jsonObj.get("name");
			//jsonObject.get("age"));
			
						
			
		} catch (ParseException e) {
			e.printStackTrace(); 
		} 
	} 	 
}
