package vo;

public class BoardReplyVO {
	
			/*	create table free_reply(
				reidx number,
				idx number,
				writer varchar2(50),
				pwd varchar2(100),
				content varchar2(50),
				regDate varchar2(10),
				PRIMARY KEY(reidx, idx)
			);
			alter table free_reply add foreign key (idx) references freeboard (idx);
		);*/

	private int reidx  , idx;
	private String writer , content, regdate ,pwd ;
	
	
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public int getReidx() {
		return reidx;
	}
	public void setReidx(int reidx) {
		this.reidx = reidx;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
}
