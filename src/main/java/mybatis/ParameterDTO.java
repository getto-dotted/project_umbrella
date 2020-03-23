package mybatis;

public class ParameterDTO {
	
	private String board_idx;
	private String pass;
	
	public ParameterDTO() {}
	
	public ParameterDTO(String board_idx,String pass) {
		super();		
		this.board_idx = board_idx;
		this.pass = pass;
	}
	
	public String getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(String board_idx) {
		this.board_idx = board_idx;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}
	
	
	
}
