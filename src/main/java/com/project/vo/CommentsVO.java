package com.project.vo;

import java.util.Date;

public class CommentsVO {
	private String nickname;
	private int idx;
	private int comment_idx;
	private int comment_lev;
	private String target_idx;
	private String content;
	private Date writedate;
	
	public CommentsVO() {;}

	public CommentsVO(String nickname, int idx, int comment_idx, int comment_lev, String target_idx, String content,
			Date writedate) {
		super();
		this.nickname = nickname;
		this.idx = idx;
		this.comment_idx = comment_idx;
		this.comment_lev = comment_lev;
		this.target_idx = target_idx;
		this.content = content;
		this.writedate = writedate;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getComment_idx() {
		return comment_idx;
	}

	public void setComment_idx(int comment_idx) {
		this.comment_idx = comment_idx;
	}

	public int getComment_lev() {
		return comment_lev;
	}

	public void setComment_lev(int comment_lev) {
		this.comment_lev = comment_lev;
	}

	public String getTarget_idx() {
		return target_idx;
	}

	public void setTarget_idx(String target_idx) {
		this.target_idx = target_idx;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getWritedate() {
		return writedate;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	@Override
	public String toString() {
		return "CommentsVO [nickname=" + nickname + ", idx=" + idx + ", comment_idx=" + comment_idx + ", comment_lev="
				+ comment_lev + ", target_idx=" + target_idx + ", content=" + content + ", writedate=" + writedate
				+ "]";
	}
	
	
}
