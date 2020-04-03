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
import mybatis.MyBoardDTO;
import mybatis.MybatisDAO;
import mybatis.MybatisMember;
import mybatis.ParameterDTO;
import util.EnvFileReader;
import util.PagingUtil;

@Controller
public class MybatisController {//일반 게시판 관련 메소드가 있는 클래스
	
	private SqlSession sqlSession;

	@Autowired//mybatis를 위한 @Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		System.out.println("@Autowired->MyBatisController");
	}
	//방명록 리스트
	@RequestMapping("/list")//리스트의 출력/반복/검색 메소드
	public String list(Model model, HttpServletRequest req) {
		
		String addQueryString = "";//페이지 구분을 위한 쿼리스트링
		Map<String, Object> param = new HashMap<String, Object>();//DB에 값을 전달하기 위한 Map 생성
		//<String, Object>과 같은 제네릭을 설정하지 않으면 경고를 자주 띄운다.
		
		String searchColumn = req.getParameter("searchColumn");//검색할 컬럼값. input type select로 받아온다.
		String searchWord = req.getParameter("searchWord");//검색할 단어. input type text로 받아온다. -> 인코딩 및 에러 주의
		
		if(searchColumn!=null) {
			//전달된 파라미터가 있을때만 아래 문장 수행
			addQueryString = String.format("searchColumn=%s&searchWord=%s&", searchColumn, searchWord);
			param.put("searchColumn", searchColumn);
			param.put("searchWord", searchWord);
		}		
		
		int totalRecordCount = sqlSession.getMapper(MybatisDAO.class).getTotalCount(param);//페이지 목록에 담겨야할 총 게시물 수를 계산한다.
		
		//페이지 처리를 위한 설정값
		int pageSize = Integer.parseInt(EnvFileReader.getValue("Paging.properties", "pageSize"));//한 페이지에 출력할 게시물 수를 외부파일에서 가져온다.			
		int blockPage = Integer.parseInt(EnvFileReader.getValue("Paging.properties", "blockPage"));//전체 페이지 수 한계를 외부파일에서 가져온다.
				
		//현재 페이지번호 파라미터로 받기
		int nowPage = req.getParameter("nowPage")==null? 1 : Integer.parseInt(req.getParameter("nowPage"));
		//쿼리의 start, end값 구하기, rowNumber를 통한 검색시 활용. 다만 검색에 넣어놓지 않았음.
		int start = (nowPage-1) * pageSize +1;
		int end = nowPage * pageSize;
		param.put("start", start);
		param.put("end", end);		
		
		ArrayList<MyBoardDTO> lists = sqlSession.getMapper(MybatisDAO.class).listPage(param);
		//페이지 처리를 위한 static메소드 호출
		String pagingImg = PagingUtil.pagingImg(totalRecordCount, pageSize, blockPage, nowPage,	
				req.getContextPath()+"/list?"+addQueryString, req.getContextPath());
		
		model.addAttribute("pagingImg", pagingImg);
		
		//내용에 대한 줄바꿈 처리 부분
		for(MyBoardDTO dto : lists) {
			String temp = dto.getContent().replace("\r\n", "<br/>");
			dto.setContent(temp);
		}
		
		//모델객체에 저장후 뷰 호출
		model.addAttribute("lists", lists);	
		
		return "/list";
	}	
	
	//로그인페이지
	@RequestMapping("/login")
	public String login(Model model) {		
		return "/login";
	}
	//로그아웃 처리
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		//세션영역을 비운 후 로그인 페이지로 이동한다.
		session.setAttribute("siteUserInfo", null);
		return "redirect:login";
	}
	//로그인프로세스
	@RequestMapping("/loginAction")
	public ModelAndView loginAction(HttpServletRequest req, HttpSession session) {
		
		//Mapper의 id="login"인 엘리먼트를 인터페이스를 통해 호출한다.
		MemberVO vo = sqlSession.getMapper(MybatisMember.class).login(req.getParameter("id"),req.getParameter("pass"));		
		ModelAndView mv = new ModelAndView();
		
		if(vo==null) {
			//로그인에 실패한 경우
			mv.addObject("LoginNg", "아이디/패스워드가 틀렸습니다.");
			//로그인 페이지로 다시이동
			mv.setViewName("/login");
			return mv;
		}
		else {
			//로그인에 성공한 경우 Session영역에 속성저장
			session.setAttribute("siteUserInfo", vo);
		}
		
		//로그인 후 페이지 이동
		String backUrl = req.getParameter("backUrl");
		if(backUrl==null || backUrl.equals("")) {
			//다시 로그인 페이지로 이동함.
			mv.setViewName("/login");
		}
		else {
			//로그인후 글쓰기 페이지로 이동함
			mv.setViewName(backUrl);
		}
		return mv;
		
	}
	
	
	//글쓰기페이지
	@RequestMapping("/write")
	public String write(Model model, HttpSession session, HttpServletRequest req) {		
		return "/write";
	}
	//글쓰기처리
	@RequestMapping(value="/writeAction", method=RequestMethod.POST)
	public String writeAction(Model model, HttpServletRequest req, HttpSession session) {		
		sqlSession.getMapper(MybatisDAO.class).write(
				req.getParameter("name"), 
				req.getParameter("contents"),
				req.getParameter("pass"));
		
		//글쓰기 완료시 리스트로 이동
		return "redirect:list";
	}	
	
	//기존 게시물 내용 가져와서 수정폼에 삽입하기
	@RequestMapping("/modify")
	public String modify(Model model, HttpServletRequest req, HttpSession session) {
		
		//Mapper쪽으로 전달할 파라미터값을 저장할 DTO객체 생성
		ParameterDTO parameterDTO = new ParameterDTO();
		parameterDTO.setBoard_idx(req.getParameter("idx"));//idx를 통해 해당 글의 내용을 가져온다.
		parameterDTO.setPass(req.getParameter("pass"));//password가 맞을 때만 가져온다.
		//Interface 호출을 통해 Mapper로 전달
		MyBoardDTO dto = sqlSession.getMapper(MybatisDAO.class).view(parameterDTO);
		
		model.addAttribute("dto", dto);
		return "/modify";
		
	}
	//전송된 폼값으로 수정처리하기
	@RequestMapping("/modifyAction")
	public String modifyAction(Model model, HttpServletRequest req, HttpSession session) {		
		
		sqlSession.getMapper(MybatisDAO.class).modify(
				req.getParameter("idx"),
				req.getParameter("name"),
				req.getParameter("contents"),
				req.getParameter("pass"));		
		
		return "redirect:list";
	}
	
	@RequestMapping("/delete")
	public String delete(Model model, HttpServletRequest req, HttpSession session) {
		
		sqlSession.getMapper(MybatisDAO.class).delete(
				req.getParameter("idx"),//해당 idx를 가진 글을 삭제한다.	
				req.getParameter("pass"));//password가 맞을때만 삭제한다.
		
		return "redirect:list";
	}
	
	
}
