package mybatis;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface MybatisDAO {

	//게시물 수 카운트하기
	public int getTotalCount(Map<String, Object> param);	
	
	//리스트 페이지 처리
	public ArrayList<MyBoardDTO> listPage(Map<String, Object> param);	
	
	//글쓰기 처리
	
	public int write(
			@Param("_name") String name, 
			@Param("_contents") String contents, 
			@Param("_pass") String pass);
	
	//기존 게시물 읽어오기
	public MyBoardDTO view(ParameterDTO parameterDTO);
	
	//게시물 수정
	public int modify(String idx, String name, String contents, String pass);
	//게시물 삭제
	public int delete(String idx, String pass);
	
}
