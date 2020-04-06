package mybatis;

import java.sql.Timestamp;//mysql에서는 Timestamp를 사용한다.

public class MemberVO {

	private String id;
	private String pass;
	private String name;
	private Timestamp regidate;
	public MemberVO() {}
	public MemberVO(String id, String pass, String name, Timestamp regidate) {
		super();
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.regidate = regidate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getRegidate() {
		return regidate;
	}
	public void setRegidate(Timestamp regidate) {
		this.regidate = regidate;
	}
	
	
	
}
