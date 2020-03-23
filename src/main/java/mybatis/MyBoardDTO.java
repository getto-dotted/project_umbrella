package mybatis;

import java.sql.Date;

public class MyBoardDTO {
		
	private String idx;
	private String name;
	private String pass;
	private String content;
	private Date postdate;
	
	public MyBoardDTO() {}

	public MyBoardDTO(String name, String content, String pass, Date postdate, String idx) {
		super();
		this.pass = pass;
		this.name = name;
		this.content = content;
		this.postdate = postdate;
		this.idx = idx;
	}

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getPostdate() {
		return postdate;
	}

	public void setPostdate(Date postdate) {
		this.postdate = postdate;
	}

	
}
