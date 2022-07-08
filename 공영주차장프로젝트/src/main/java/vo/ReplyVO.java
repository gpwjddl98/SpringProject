package vo;

import org.springframework.stereotype.Component;

@Component
public class ReplyVO {
	
	/*
	 * CREATE TABLE reviewb_reply( 
	 * 	reidx number, 
	 * 	idx number, 
	 * 	writer varchar2(50),
	 * 	content varchar2(50), 
	 * 	regDate varchar2(10), 
	 * 	PRIMARY KEY(reidx, idx) );
	 * 
	 * alter table reviewb_reply add foreign key (idx) references reviewb (idx);
	 * 
	 * create sequence seq_reviewb_reply;
	 */
	
	private int reidx  , idx;
	private String writer , content, regdate  ;
	
	
	
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	
	
	
}
