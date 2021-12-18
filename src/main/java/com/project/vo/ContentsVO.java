package com.project.vo;

import java.util.Date;

public class ContentsVO {
	private String nickname;
	private String profile ;
	private int idx;
	private String title;
	private String content;
	private String category;
	private String image;
	private Date writedate;
	private int views;
	private int commentNum;
	
	public ContentsVO() {;}

	public ContentsVO(String nickname, String profile, int idx, String title, String content, String category,
			String image, Date writedate, int views, int commentNum) {
		this.nickname = nickname;
		this.profile = profile;
		this.idx = idx;
		this.title = title;
		this.content = content;
		this.category = category;
		this.image = image;
		this.writedate = writedate;
		this.views = views;
		this.commentNum = commentNum;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Date getWritedate() {
		return writedate;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}

	@Override
	public String toString() {
		return "ContentsVO [nickname=" + nickname + ", profile=" + profile + ", idx=" + idx + ", title=" + title
				+ ", content=" + content + ", category=" + category + ", image=" + image + ", writedate=" + writedate
				+ ", views=" + views + ", commentNum=" + commentNum + "]";
	}
	
}
