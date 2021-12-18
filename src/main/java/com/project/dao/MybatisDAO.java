package com.project.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.project.vo.CommentsVO;
import com.project.vo.ContentsList;
import com.project.vo.ContentsVO;
import com.project.vo.UserVO;

public interface MybatisDAO {

	int selectUserCount(UserVO userVO);

	void insertUser(UserVO userVO);

	ArrayList<ContentsVO> selectContentsTop6();
	
	int selectCount(HashMap<String, Object> hmap);

	ArrayList<ContentsVO> selectContents(HashMap<String, Object> hmap);
	
	int selectCountMy(HashMap<String, Object> hmap);

	ArrayList<ContentsVO> selectContentsMy(HashMap<String, Object> hmap);
	
	ContentsVO selectByIdx(int idx);

	int searchCount(HashMap<String, Object> hmap);

	ArrayList<ContentsVO> searchContents(HashMap<String, Object> hmap);

	String searchNickname(String id);

	int searchCountMy(HashMap<String, Object> hmap);
	
	ArrayList<ContentsVO> searchContentsMy(HashMap<String, Object> hmap);

	void deleteContent(int idx);

	void deleteComment(int idx);
	
	void incrementView(int idx);

	ArrayList<CommentsVO> selectComments(int idx);

	void incrementComment(int idx);

	void insertReply(HashMap<String, Object> hmap);

	void insertCommentReply(HashMap<String, Object> hmap);

	CommentsVO selectCommentTargetIdx();

	void updateReply(HashMap<String, Object> hmap);

	UserVO selectById(String id);

	void uploadContent(HashMap<String, Object> hmap);

	void updateContent(HashMap<String, Object> hmap);

	void updatePassword(HashMap<String, Object> hmap);

	int selectNicknameCount(HashMap<String, Object> hmap);

	void updateContentNickname(HashMap<String, Object> hmap);

	void updateCommentNickname(HashMap<String, Object> hmap);

	void updateNickname(HashMap<String, Object> hmap);

	















	
}
