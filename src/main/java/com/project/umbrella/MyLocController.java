package com.project.umbrella;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import mybatis.MemberVO;
import mybatis.MyLocDTO;
import mybatis.MyLocDAO;
import mybatis.MybatisMember;
import mybatis.ParameterDTO;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
public class MyLocController {
	
	private SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		System.out.println("@Autowired->LocController");
	}
	//방명록 리스트
	@RequestMapping("/listM")
	public String list(Model model, HttpServletRequest req, HttpSession session) {
		if(session.getAttribute("siteUserInfo")==null) {
			return "redirect:login";
		}	
		
		String addQueryString = "";
		Map param = new HashMap();
		
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		
		if(searchColumn!=null) {
			//전달된 파라미터가 있을때만 아래 문장 수행
			addQueryString = String.format("searchColumn=%s&searchWord=%s&", searchColumn, searchWord);
			param.put("searchColumn", searchColumn);
			param.put("searchWord", searchWord);
		}		
		
		int totalRecordCount = sqlSession.getMapper(MyLocDAO.class).getTotalCount(param);
		
		//페이지 처리를 위한 설정값
		int pageSize = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "pageSize")); 				
		int blockPage = 
				Integer.parseInt(EnvFileReader.getValue("Paging.properties", "blockPage")); 
		//전체 페이지수 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);		
		//현재 페이지번호 파라미터로 받기
		int nowPage = req.getParameter("nowPage")==null? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		//페이지 처리 있는 메소드
		ArrayList<MyLocDTO> lists = sqlSession.getMapper(MyLocDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/listM?"+addQueryString, req.getContextPath());
		
		model.addAttribute("pagingImg", pagingImg);
		
		//내용에 대한 줄바꿈 처리 부분
		for(MyLocDTO dto : lists) {
			String temp = dto.getLoc().replace("\r\n", "<br/>");
			dto.setLoc(temp);
			System.out.println(dto.getUtime());
		}
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		
		return "/listM";
	}	
	
	@RequestMapping("/deleteM")
	public String delete(Model model, HttpServletRequest req, HttpSession session) {
		
		if(session.getAttribute("siteUserInfo")==null) {
			return "redirect:login.do";
		}	
		
		sqlSession.getMapper(MyLocDAO.class).delete(
				req.getParameter("idx"));
		
		return "redirect:listM";
	}
}
