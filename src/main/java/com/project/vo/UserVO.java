package com.project.vo;

public class UserVO {
	
	private String id;
	private String password;
	private String nickname;
	private String profile;
	
	public UserVO() {;}

	public UserVO(String id, String password) {
		this.id = id;
		this.password = password;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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

	@Override
	public String toString() {
		return "UserVO [id=" + id + ", password=" + password + ", nickname=" + nickname + ", profile=" + profile + "]";
	}
	
	
	
}
