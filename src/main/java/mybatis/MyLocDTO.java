package mybatis;

import java.sql.Date;

public class MyLocDTO {
	private int idx;
	private String loc;
	private int today;
	private int tomorrow;
	private String etc;
	private Date utime;
	
	public MyLocDTO() {}

	public MyLocDTO(int idx, String loc, int today, int tomorrow, String etc, Date utime) {
		super();
		this.idx = idx;
		this.loc = loc;
		this.today = today;
		this.tomorrow = tomorrow;
		this.etc = etc;
		this.utime = utime;
	}

	public Date getUtime() {
		return utime;
	}

	public void setUtime(Date utime) {
		this.utime = utime;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getLoc() {
		return loc;
	}

	public void setLoc(String loc) {
		this.loc = loc;
	}

	public int getToday() {
		return today;
	}

	public void setToday(int today) {
		this.today = today;
	}

	public int getTomorrow() {
		return tomorrow;
	}

	public void setTomorrow(int tomorrow) {
		this.tomorrow = tomorrow;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}
	
	
}
