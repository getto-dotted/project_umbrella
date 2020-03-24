package mybatis;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface MyLocDAO {

	//게시물 수 카운트하기
	public int getTotalCount(Map param);	
	
	//리스트 페이지 처리
	public ArrayList<MyLocDTO> listPage(Map param);	
	
	//글쓰기 처리
	
	public Integer write(
			@Param("_loc") String loc, 
			@Param("_today") String today, 
			@Param("_tomorrow") String tomorrow);

	//게시물 수정
	public int modify(String idx, String loc, String today, String tomorrow, String etc);
	//게시물 삭제
	public int delete(String idx);
	
}
