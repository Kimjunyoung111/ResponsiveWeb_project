package com.project.responsiveWeb_1;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.dao.MybatisDAO;
import com.project.vo.CommentsList;
import com.project.vo.CommentsVO;
import com.project.vo.ContentsList;
import com.project.vo.ContentsVO;
import com.project.vo.UserVO;

@Controller
public class HomeController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/")
	public String home(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		session.setAttribute("loginStatus", "False");
		
		ContentsList contentsList = new ContentsList();
		contentsList.setList(mapper.selectContentsTop6()); 
		
		model.addAttribute("contentsList", contentsList);
		return "main";
	}
	
	@RequestMapping("/main")
	public String main(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		ContentsList contentsList = new ContentsList();
		contentsList.setList(mapper.selectContentsTop6()); 
		
		model.addAttribute("contentsList", contentsList);
		return "main";
	}
	
	@RequestMapping("/login")
	public String login(Model model,HttpSession session ) {
		
		if(session.getAttribute("loginStatus") == "True") {
			return "redirect:main";
		}
		
		return "login";
		
	}
	
	@RequestMapping("/signUp")
	public String signUp(Model model,HttpSession session ) {
		
		if(session.getAttribute("loginStatus") == "True") {
			return "redirect:main";
		}
		
		return "signUp";
		
	}
	
	@RequestMapping("/joinOK")
	public String joinOK(HttpSession session, HttpServletRequest request, Model model) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
			
		
		String id = request.getParameter("id").trim();
		String password = request.getParameter("password").trim();
		String passwordCheck = request.getParameter("passwordCheck").trim();
		if(id == "" || password == "" || passwordCheck == "") {
			model.addAttribute("msg", "아이디, 비밀번호를 모두 입력하세요. <i class=\"fas fa-times\"></i>");
			return "signUp";
		}
		
		if(!password.equals(passwordCheck)) {
			model.addAttribute("msg", "비밀번호가 서로 틀립니다. <i class=\"fas fa-times\"></i>");
			return "signUp";
		}
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		UserVO userVO = ctx.getBean("userVO", UserVO.class);
		
		userVO.setId(id);
		userVO.setPassword(password);
		
		int count = mapper.selectUserCount(userVO);
		
		if(count == 0) {
			mapper.insertUser(userVO);
			model.addAttribute("pass", "회원 가입이 완료 되었습니다.");
			return "login";
		}
		else if(count == 1) {
			model.addAttribute("msg", "이미 존재하는 회원입니다. <i class=\"fas fa-times\"></i>");
			return "signUp";
		}else {
			model.addAttribute("msg", "오류 - 중복 회원 존재 <i class=\"fas fa-times\"></i>");
			return "signUp";
		}
	}
	
	@RequestMapping("/loginOK")
	public String loginOK(HttpSession session, HttpServletRequest request, Model model) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
			
		UserVO userVO = new UserVO();
		
		String id = request.getParameter("id").trim();
		String password = request.getParameter("password").trim();
		if(id == "" || password == "") {
			model.addAttribute("msg", "아이디, 비밀번호를 모두 입력하세요. <i class=\"fas fa-times\"></i>");
			return "login";
		}
		
		userVO.setId(id);
		userVO.setPassword(password);
		
		int count = mapper.selectUserCount(userVO);
		
		if(count == 1) {
			String nickname = mapper.searchNickname(id);
			session.setAttribute("id", id);
			session.setAttribute("nickname", nickname);
			session.setAttribute("password", password);
			session.setAttribute("loginStatus", "True");
			return "redirect:main";
		}
		else {
			model.addAttribute("msg", "아이디 또는 비밀번호가 틀렸습니다. <i class=\"fas fa-times\"></i>");
			return "login";
		}		
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request, Model model) {
		
		session.removeAttribute("id");
		session.removeAttribute("nickname");
		session.removeAttribute("password");
		session.setAttribute("loginStatus", "False");
		
		return "redirect:main";
	}
	
	@RequestMapping("/content")
	public String content(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		int pageSize = 10;
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}catch (Exception e) {;}
		String category = request.getParameter("category");
		if(category == null || category.equals("ALL")) {
			category = "";
		}
		int totalCount = 0;
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("category", category);
		
		totalCount = mapper.selectCount(hmap);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ContentsList contentsList = ctx.getBean("contentsList", ContentsList.class);
		contentsList.initContentsList(pageSize, totalCount, currentPage);
		
		hmap.put("startNo", contentsList.getStartNo());
		hmap.put("endNo", contentsList.getEndNo());
		
		contentsList.setList(mapper.selectContents(hmap));
		if(category.equals("")) {
			category ="ALL";
		}
		
		model.addAttribute("contentsList", contentsList);
		model.addAttribute("category", category);
		
		return "content";
	}
	
	@RequestMapping("/search")
	public String search(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		int pageSize = 10;
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}catch (Exception e) {;}
		int totalCount = 0;
		
		String select = request.getParameter("select");
		if(select == null || select.equals("")) {
			select = "title";
		}
		
		String text = request.getParameter("text").trim();
		if(text == null || text.equals("")) {
			return "redirect:content";
		}
		
		String category = request.getParameter("category");
		if(category == null || category.equals("ALL")) {
			category = "";
		}
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("category", category);
		hmap.put("select", select);
		hmap.put("text", text);
		
		totalCount = mapper.searchCount(hmap);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ContentsList contentsList = ctx.getBean("contentsList", ContentsList.class);
		contentsList.initContentsList(pageSize, totalCount, currentPage);
		
		hmap.put("startNo", contentsList.getStartNo());
		hmap.put("endNo", contentsList.getEndNo());
		
		contentsList.setList(mapper.searchContents(hmap));
		
		if(category.equals("")) {
			category = "ALL";
		}
		
		model.addAttribute("contentsList", contentsList);
		model.addAttribute("category", category);
		model.addAttribute("text", text);
		model.addAttribute("select", select);
		model.addAttribute("search", "True");
		
		return "content";
	}
	
	@RequestMapping("/myContent")
	public String myContent(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String loginStatus = "False";
		String id = "";
		String nickname = "";
		try {
			loginStatus = (String) session.getAttribute("loginStatus");
			id = (String) session.getAttribute("id");
			nickname = (String) session.getAttribute("nickname");
		} catch (Exception e) {}
		
		if(loginStatus == null || loginStatus.equals("") || id == null || id.equals("")) {
			model.addAttribute("pass", "로그인 후 이용 가능합니다.");
			return "login";
		}
		
		int pageSize = 10;
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}catch (Exception e) {;}
		String category = request.getParameter("category");
		if(category == null || category.equals("ALL")) {
			category = "";
		}
		int totalCount = 0;
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("category", category);
		hmap.put("nickname", nickname);
		
		totalCount = mapper.selectCountMy(hmap);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ContentsList contentsList = ctx.getBean("contentsList", ContentsList.class);
		contentsList.initContentsList(pageSize, totalCount, currentPage);
		
		hmap.put("startNo", contentsList.getStartNo());
		hmap.put("endNo", contentsList.getEndNo());
		
		contentsList.setList(mapper.selectContentsMy(hmap));
		if(category.equals("")) {
			category ="ALL";
		}
		
		model.addAttribute("contentsList", contentsList);
		model.addAttribute("category", category);
		
		return "myContent";
	}
	
	@RequestMapping("/searchMy")
	public String searchMy(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String loginStatus = "False";
		String id = "";
		String nickname = "";
		try {
			loginStatus = (String) session.getAttribute("loginStatus");
			id = (String) session.getAttribute("id");
			nickname = (String) session.getAttribute("nickname");
		} catch (Exception e) {}
		
		if(loginStatus == null || loginStatus.equals("") || id == null || id.equals("")) {
			model.addAttribute("pass", "로그인 후 이용 가능합니다.");
			return "login";
		}
		
		int pageSize = 10;
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}catch (Exception e) {;}
		int totalCount = 0;
		
		String select = request.getParameter("select");
		if(select == null || select.equals("")) {
			select = "title";
		}
		
		String text = "";
		try {
			text = request.getParameter("text").trim();
		} catch (Exception e) {;}
		if(text == null || text.equals("")) {
			return "redirect:myContent";
		}
		
		String category = request.getParameter("category");
		if(category == null || category.equals("ALL")) {
			category = "";
		}
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("nickname", nickname);
		hmap.put("category", category);
		hmap.put("select", select);
		hmap.put("text", text);
		
		totalCount = mapper.searchCountMy(hmap);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ContentsList contentsList = ctx.getBean("contentsList", ContentsList.class);
		contentsList.initContentsList(pageSize, totalCount, currentPage);
		
		hmap.put("startNo", contentsList.getStartNo());
		hmap.put("endNo", contentsList.getEndNo());
		
		contentsList.setList(mapper.searchContentsMy(hmap));
		
		if(category.equals("")) {
			category = "ALL";
		}
		
		model.addAttribute("contentsList", contentsList);
		model.addAttribute("category", category);
		model.addAttribute("text", text);
		model.addAttribute("select", select);
		model.addAttribute("search", "True");
		
		return "myContent";
	}
	
	@RequestMapping("/delete")
	public String delete(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		int idx =  Integer.parseInt(request.getParameter("idx"));
		mapper.deleteContent(idx);
		mapper.deleteComment(idx);
		
		model.addAttribute("currentPage",Integer.parseInt(request.getParameter("currentPage")));
		return "redirect:myContent";
	}
	
	@RequestMapping("/view")
	public String view(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		int idx =  Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		String incrementIdx = "increment"+idx; 
		String CheckIdx = "";
		try {
			CheckIdx = (String) session.getAttribute(incrementIdx);
		} catch (Exception e) {
			CheckIdx = "False";
		} 
		
		if(CheckIdx == null || CheckIdx.equals("False") || CheckIdx.equals("")) {
			mapper.incrementView(idx);
			session.setAttribute(incrementIdx, "True");
		}
		
		model.addAttribute("idx", idx);
		model.addAttribute("currentPage", currentPage);
		
		return "redirect:contentView";
	}
	
	@RequestMapping("/view2")
	public String view2(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		int idx =  Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String category = request.getParameter("category");
		String text = request.getParameter("text");
		String select = request.getParameter("select");
		String search = request.getParameter("select");
		
		String incrementIdx = "increment"+idx; 
		String CheckIdx = "";
		try {
			CheckIdx = (String) session.getAttribute(incrementIdx);
		} catch (Exception e) {
			CheckIdx = "False";
		} 
		
		if(CheckIdx == null || CheckIdx.equals("False") || CheckIdx.equals("")) {
			mapper.incrementView(idx);
			session.setAttribute(incrementIdx, "True");
		}
		
		model.addAttribute("idx", idx);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("category", category);
		model.addAttribute("text", text);
		model.addAttribute("select", select);
		model.addAttribute("search", search);
		
		return "redirect:contentView2";
	}	
	
	@RequestMapping("/contentView")
	public String contentView(Model model,HttpSession session, HttpServletRequest request) {
		
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		
		int idx =  Integer.parseInt(request.getParameter("idx"));
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ContentsVO contentsVO = ctx.getBean("contentsVO", ContentsVO.class);
		contentsVO = mapper.selectByIdx(idx);
		
		CommentsList commentsList = ctx.getBean("commentsList", CommentsList.class);
		commentsList.setList(mapper.selectComments(idx));
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		contentsVO.setContent(contentsVO.getContent().trim());
		
		model.addAttribute("contentsVO", contentsVO);
		model.addAttribute("commentsList", commentsList);
		model.addAttribute("currentPage", currentPage);
		
		return "contentView";
	}
	
	@RequestMapping("/contentView2")
	public String contentView2(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		int idx =  Integer.parseInt(request.getParameter("idx"));
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ContentsVO contentsVO = ctx.getBean("contentsVO", ContentsVO.class);
		contentsVO = mapper.selectByIdx(idx);
		
		CommentsList commentsList = ctx.getBean("commentsList", CommentsList.class);
		commentsList.setList(mapper.selectComments(idx));
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String category = request.getParameter("category");
		String text = request.getParameter("text");
		String select = request.getParameter("select");
		String search = request.getParameter("select");
		
		contentsVO.setContent(contentsVO.getContent().trim());
		
		model.addAttribute("contentsVO", contentsVO);
		model.addAttribute("commentsList", commentsList);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("category", category);
		model.addAttribute("text", text);
		model.addAttribute("select", select);
		model.addAttribute("search", search);
		
		return "contentView";
	}
	
	@RequestMapping("/reply")
	public String reply(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		
		String nickname = request.getParameter("nickname");
		int idx =  Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String comment = request.getParameter("comment");
		
		model.addAttribute("nickname", nickname);
		model.addAttribute("idx", idx);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("comment", comment);
		
		if(comment == null && comment.equals("")) {
			return "redirect:contentView";
		}
		
		mapper.incrementComment(idx);
		
		return "redirect:replyUp";
	}
	
	@RequestMapping("/reply2")
	public String reply2(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String nickname = request.getParameter("nickname");
		int idx =  Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String comment = request.getParameter("comment");
		String category = request.getParameter("category");
		String text = request.getParameter("text");
		String select = request.getParameter("select");
		String search = request.getParameter("search");
		
		model.addAttribute("nickname", nickname);
		model.addAttribute("idx", idx);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("category", category);
		model.addAttribute("text", text);
		model.addAttribute("select", select);
		model.addAttribute("search", search);
		model.addAttribute("comment", comment);
	
		if(comment == null && comment.equals("")) {
			return "redirect:contentView2";
		}
		
		mapper.incrementComment(idx);
		
		return "redirect:replyUp2";
	}
	
	@RequestMapping("/replyUp")
	public String replyUp(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String nickname = request.getParameter("nickname");
		int idx =  Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String comment = request.getParameter("comment").trim();
		
		String target_idx = "re"; 
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("nickname", nickname);
		hmap.put("idx", idx);
		hmap.put("target_idx", target_idx);
		hmap.put("comment", comment);
		
		mapper.insertReply(hmap);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		CommentsVO commentsVO = ctx.getBean("commentsVO", CommentsVO.class);
		commentsVO = mapper.selectCommentTargetIdx();
		int comment_idx = commentsVO.getComment_idx();
		String target_idx2 = "";
		if(comment_idx < 10) {
			target_idx2 = "000" + comment_idx ;
		}else if(comment_idx < 100) {
			target_idx2 = "00" + comment_idx ;
		}else if(comment_idx < 1000) {
			target_idx2 = "0" + comment_idx ;
		}else {
			target_idx2 = "" +comment_idx ;
		}
		hmap.put("comment_idx", comment_idx);
		hmap.put("target_idx2", target_idx2);
		mapper.updateReply(hmap);
		
		
		model.addAttribute("idx", idx);
		model.addAttribute("currentPage", currentPage);
		return "redirect:contentView";
	}
	
	@RequestMapping("/replyUp2")
	public String replyUp2(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String nickname = request.getParameter("nickname");
		int idx =  Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String comment = request.getParameter("comment").trim();
		
		String target_idx = "re";
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("nickname", nickname);
		hmap.put("idx", idx);
		hmap.put("target_idx", target_idx);
		hmap.put("comment", comment);
		
		mapper.insertReply(hmap);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		CommentsVO commentsVO = ctx.getBean("commentsVO", CommentsVO.class);
		commentsVO = mapper.selectCommentTargetIdx();
		int comment_idx = commentsVO.getComment_idx();
		String target_idx2 = "";
		if(comment_idx < 10) {
			target_idx2 = "000" + comment_idx ;
		}else if(comment_idx < 100) {
			target_idx2 = "00" + comment_idx ;
		}else if(comment_idx < 1000) {
			target_idx2 = "0" + comment_idx ;
		}else {
			target_idx2 = "" +comment_idx ;
		}
		hmap.put("comment_idx", comment_idx);
		hmap.put("target_idx2", target_idx2);
		mapper.updateReply(hmap);
		
		String category = request.getParameter("category");
		String text = request.getParameter("text");
		String select = request.getParameter("select");
		String search = request.getParameter("search");
		
		model.addAttribute("idx", idx);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("category", category);
		model.addAttribute("text", text);
		model.addAttribute("select", select);
		model.addAttribute("search", search);
		
		return "redirect:contentView2";
	}
	
	@RequestMapping("/comment_reply")
	public String comment_reply(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		
		String nickname = request.getParameter("nickname");
		int idx =  Integer.parseInt(request.getParameter("idx"));
		int comment_lev =  Integer.parseInt(request.getParameter("comment_lev"));
		String target_idx = request.getParameter("target_idx");
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String comment = request.getParameter("comment");
		
		model.addAttribute("nickname", nickname);
		model.addAttribute("idx", idx);
		model.addAttribute("comment_lev", comment_lev);
		model.addAttribute("target_idx", target_idx);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("comment", comment);
		
		if(comment == null && comment.equals("")) {
			return "redirect:contentView";
		}
		
		mapper.incrementComment(idx);
		
		return "redirect:comment_replyUp";
	}
	
	@RequestMapping("/comment_reply2")
	public String comment_reply2(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String nickname = request.getParameter("nickname");
		int idx =  Integer.parseInt(request.getParameter("idx"));
		int comment_lev =  Integer.parseInt(request.getParameter("comment_lev"));
		String target_idx = request.getParameter("target_idx");
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String comment = request.getParameter("comment");
		String category = request.getParameter("category");
		String text = request.getParameter("text");
		String select = request.getParameter("select");
		String search = request.getParameter("search");
		
		model.addAttribute("nickname", nickname);
		model.addAttribute("idx", idx);
		model.addAttribute("comment_lev", comment_lev);
		model.addAttribute("target_idx", target_idx);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("category", category);
		model.addAttribute("text", text);
		model.addAttribute("select", select);
		model.addAttribute("search", search);
		model.addAttribute("comment", comment);
	
		if(comment == null && comment.equals("")) {
			return "redirect:comment_replyUp2";
		}
		
		mapper.incrementComment(idx);
		
		return "redirect:comment_replyUp2";
	}
	
	@RequestMapping("/comment_replyUp")
	public String comment_replyUp(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String nickname = request.getParameter("nickname");
		int idx =  Integer.parseInt(request.getParameter("idx"));
		int comment_lev =  Integer.parseInt(request.getParameter("comment_lev"));
		String target_idx = request.getParameter("target_idx");
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String comment = request.getParameter("comment").trim();
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("nickname", nickname);
		hmap.put("idx", idx);
		hmap.put("comment_lev", comment_lev + 1);
		hmap.put("target_idx", "re");
		hmap.put("comment", comment);
		
		mapper.insertCommentReply(hmap);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		CommentsVO commentsVO = ctx.getBean("commentsVO", CommentsVO.class);
		commentsVO = mapper.selectCommentTargetIdx();
		int comment_idx = commentsVO.getComment_idx();
		
		String target_idx2 = target_idx + "-";
		if(comment_idx < 10) {
			target_idx2 = target_idx2 +"000" + comment_idx ;
		}else if(comment_idx < 100) {
			target_idx2 = target_idx2 +"00" + comment_idx ;
		}else if(comment_idx < 1000) {
			target_idx2 = target_idx2 +"0" + comment_idx ;
		}else {
			target_idx2 = target_idx2 + comment_idx ;
		}
		
		hmap.put("comment_idx", comment_idx);
		hmap.put("target_idx2", target_idx2);
		mapper.updateReply(hmap);
		
		
		model.addAttribute("idx", idx);
		model.addAttribute("currentPage", currentPage);
		return "redirect:contentView";
	}
	
	@RequestMapping("/comment_replyUp2")
	public String comment_replyUp2(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String nickname = request.getParameter("nickname");
		int idx =  Integer.parseInt(request.getParameter("idx"));
		int comment_lev =  Integer.parseInt(request.getParameter("comment_lev"));
		String target_idx = request.getParameter("target_idx");
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String comment = request.getParameter("comment").trim();
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("nickname", nickname);
		hmap.put("idx", idx);
		hmap.put("comment_idx", "re");
		hmap.put("comment_lev", comment_lev + 1);
		hmap.put("target_idx", target_idx);
		hmap.put("comment", comment);
		
		mapper.insertCommentReply(hmap);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		CommentsVO commentsVO = ctx.getBean("commentsVO", CommentsVO.class);
		commentsVO = mapper.selectCommentTargetIdx();
		int comment_idx = commentsVO.getComment_idx();
		
		String target_idx2 = target_idx + "-";
		if(comment_idx < 10) {
			target_idx2 = target_idx2 +"000" + comment_idx ;
		}else if(comment_idx < 100) {
			target_idx2 = target_idx2 +"00" + comment_idx ;
		}else if(comment_idx < 1000) {
			target_idx2 = target_idx2 +"0" + comment_idx ;
		}else {
			target_idx2 = target_idx2 + comment_idx ;
		}
		
		hmap.put("comment_idx", comment_idx);
		hmap.put("target_idx2", target_idx2);
		mapper.updateReply(hmap);
		
		String category = request.getParameter("category");
		String text = request.getParameter("text");
		String select = request.getParameter("select");
		String search = request.getParameter("search");
		
		model.addAttribute("idx", idx);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("category", category);
		model.addAttribute("text", text);
		model.addAttribute("select", select);
		model.addAttribute("search", search);
		
		return "redirect:contentView2";
	}
	
	@RequestMapping("/uploadContent")
	public String uploadContent(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String loginStatus = "False";
		String id = "";
		String nickname = "";
		try {
			loginStatus = (String) session.getAttribute("loginStatus");
			id = (String) session.getAttribute("id");
			nickname = (String) session.getAttribute("nickname");
		} catch (Exception e) {}
		
		if(loginStatus == null || loginStatus.equals("") || id == null || id.equals("")) {
			model.addAttribute("pass", "로그인 후 이용 가능합니다.");
			return "login";
		}
		
		return "uploadContent";
	}
	
	@RequestMapping("/upload")
	public String upload(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String loginStatus = "False";
		String id = "";
		String nickname = "";
		try {
			loginStatus = (String) session.getAttribute("loginStatus");
			id = (String) session.getAttribute("id");
			nickname = (String) session.getAttribute("nickname");
		} catch (Exception e) {}
		
		if(loginStatus == null || loginStatus.equals("") || id == null || id.equals("")) {
			model.addAttribute("pass", "로그인 후 이용 가능합니다.");
			return "login";
		}
		
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		UserVO userVO = ctx.getBean("userVO", UserVO.class);
		userVO = mapper.selectById(id);
		
		String profile = userVO.getProfile();
		String title = "";
		String content = "";
		String category = request.getParameter("category");
		String image = "";
		try {
			title = request.getParameter("title").trim();
			content = request.getParameter("content").trim();
			image = request.getParameter("image");
		} catch (Exception e) {;}
		
		if(title.equals("") || content.equals("")) {
			model.addAttribute("msg", "제목 또는 내용을 모두 작성해주세요.");
			return "uploadContent";
		}
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("nickname", nickname);
		hmap.put("profile", profile);
		hmap.put("title", title);
		hmap.put("content", content);
		hmap.put("category", category);
		hmap.put("image", image);
	
		mapper.uploadContent(hmap);
		
		model.addAttribute("msg", "글 저장이 완료되었습니다.");
		return "uploadContent";
	}
	
	@RequestMapping("/updateContent")
	public String updateContent(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String loginStatus = "False";
		String id = "";
		String nickname = "";
		try {
			loginStatus = (String) session.getAttribute("loginStatus");
			id = (String) session.getAttribute("id");
			nickname = (String) session.getAttribute("nickname");
		} catch (Exception e) {}
		
		if(loginStatus == null || loginStatus.equals("") || id == null || id.equals("")) {
			model.addAttribute("pass", "로그인 후 이용 가능합니다.");
			return "login";
		}
		
		int idx =  Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String msg = "";
		try {
			msg = request.getParameter("msg");
		} catch (Exception e) {;}
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ContentsVO contentsVO = ctx.getBean("contentsVO", ContentsVO.class);
		contentsVO = mapper.selectByIdx(idx);
		
		contentsVO.setContent(contentsVO.getContent().trim());
		
		model.addAttribute("msg", msg);
		model.addAttribute("contentsVO", contentsVO);
		model.addAttribute("currentPage", currentPage);
		
		return "updateContent";
	}
	
	
	@RequestMapping("/updateContentDB")
	public String updateContentDB(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String loginStatus = "False";
		String id = "";
		try {
			loginStatus = (String) session.getAttribute("loginStatus");
			id = (String) session.getAttribute("id");
		} catch (Exception e) {}
		
		if(loginStatus == null || loginStatus.equals("") || id == null || id.equals("")) {
			model.addAttribute("pass", "로그인 후 이용 가능합니다.");
			return "login";
		}
		
		String title = "";
		String content = "";
		String category = request.getParameter("category");
		String image = "";
		try {
			title = request.getParameter("title").trim();
			content = request.getParameter("content").trim();
			image = request.getParameter("image");
		} catch (Exception e) {;}
		
		int idx =  Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		model.addAttribute("idx", idx);
		model.addAttribute("currentPage", currentPage);
		
		if(title.equals("") || content.equals("")) {
			model.addAttribute("msg", "제목 또는 내용을 모두 작성해주세요.");
			return "redirect:updateContent";
		}
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("title", title);
		hmap.put("content", content);
		hmap.put("category", category);
		hmap.put("image", image);
		hmap.put("idx", idx);
		
		mapper.updateContent(hmap);
		
		model.addAttribute("msg", "글 저장이 완료되었습니다.");
		return "redirect:updateContent";
	}
	
	@RequestMapping("/userStatus")
	public String userStatus(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String loginStatus = "False";
		String id = "";
		String nickname = "";
		String password = "";
		try {
			loginStatus = (String) session.getAttribute("loginStatus");
			id = (String) session.getAttribute("id");
			nickname = (String) session.getAttribute("nickname");
			password = (String) session.getAttribute("password");
		} catch (Exception e) {}
		
		if(loginStatus == null || loginStatus.equals("") || id == null || id.equals("")) {
			model.addAttribute("pass", "로그인 후 이용 가능합니다.");
			return "login";
		}
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		UserVO userVO = ctx.getBean("userVO", UserVO.class);
		userVO = mapper.selectById(id);
		
		String userId = userVO.getId();
		String id_token = "";
		for (int i = 0; i < userId.length(); i++) {
			if(i < 4) {
				id_token += userId.charAt(i); 
			} else {
				id_token += "*";
			}
		}
		
		String password_token = "**********"; 
		
		model.addAttribute("userVO", userVO);
		model.addAttribute("id_token", id_token);
		model.addAttribute("password_token", password_token);
		return "userStatus";
	}
	
	@RequestMapping("/update_nickname")
	public String update_nickname(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String loginStatus = "False";
		String id = "";
		String nickname = "";
		String password = "";
		try {
			loginStatus = (String) session.getAttribute("loginStatus");
			id = (String) session.getAttribute("id");
			nickname = (String) session.getAttribute("nickname");
			password = (String) session.getAttribute("password");
		} catch (Exception e) {}
		
		if(loginStatus == null || loginStatus.equals("") || id == null || id.equals("")) {
			model.addAttribute("pass", "로그인 후 이용 가능합니다.");
			return "login";
		}
		
		return "updateNickname";
	}
	
	@RequestMapping("/update_password")
	public String update_password(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String loginStatus = "False";
		String id = "";
		String nickname = "";
		String password = "";
		try {
			loginStatus = (String) session.getAttribute("loginStatus");
			id = (String) session.getAttribute("id");
			nickname = (String) session.getAttribute("nickname");
			password = (String) session.getAttribute("password");
		} catch (Exception e) {}
		
		if(loginStatus == null || loginStatus.equals("") || id == null || id.equals("")) {
			model.addAttribute("pass", "로그인 후 이용 가능합니다.");
			return "login";
		}
		
		return "updatePassword";
	}
	
	@RequestMapping("/updatePassword")
	public String updatePassword(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String loginStatus = "False";
		String id = "";
		String nickname = "";
		String password = "";
		try {
			loginStatus = (String) session.getAttribute("loginStatus");
			id = (String) session.getAttribute("id");
			nickname = (String) session.getAttribute("nickname");
			password = (String) session.getAttribute("password");
		} catch (Exception e) {}
		
		if(loginStatus == null || loginStatus.equals("") || id == null || id.equals("")) {
			model.addAttribute("pass", "로그인 후 이용 가능합니다.");
			return "login";
		}
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		UserVO userVO = ctx.getBean("userVO", UserVO.class);
		userVO = mapper.selectById(id);
		
		String current_password = request.getParameter("current_password").trim();
		String update_password = request.getParameter("update_password").trim();
		String password_check = request.getParameter("password_check").trim();
		
		if(current_password == null || current_password.equals("") ||
				update_password == null || update_password.equals("")||
				password_check == null || password_check.equals("")) {
			
			model.addAttribute("msg", "비밀번호를 모두 입력하세요. <i class=\"fas fa-times\"></i>");
			return "updatePassword";
			
		} else if(!password.equals(current_password)){
			model.addAttribute("msg", "현제 비밀번호가 일치하지 않습니다. <i class=\"fas fa-times\"></i>");
			return "updatePassword";
			
		} else if (!update_password.equals(password_check)) {
			model.addAttribute("msg", "비밀번호 체크가 일치하지 않습니다. <i class=\"fas fa-times\"></i>");
			return "updatePassword";
		}
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("id", id);
		hmap.put("password", update_password);
	
		mapper.updatePassword(hmap);
		session.setAttribute("password", update_password);
		
		model.addAttribute("pass", "비밀번호 변경이 완료 되었습니다.");
		
		return "updatePassword";
		
	}
	
	@RequestMapping("/updateNickname")
	public String updateNickname(Model model,HttpSession session, HttpServletRequest request) {
		MybatisDAO mapper = sqlSession.getMapper(MybatisDAO.class);
		
		String loginStatus = "False";
		String id = "";
		String nickname = "";
		String password = "";
		try {
			loginStatus = (String) session.getAttribute("loginStatus");
			id = (String) session.getAttribute("id");
			nickname = (String) session.getAttribute("nickname");
			password = (String) session.getAttribute("password");
		} catch (Exception e) {}
		
		if(loginStatus == null || loginStatus.equals("") || id == null || id.equals("")) {
			model.addAttribute("pass", "로그인 후 이용 가능합니다.");
			return "login";
		}
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		UserVO userVO = ctx.getBean("userVO", UserVO.class);
		userVO = mapper.selectById(id);
		
		String update_nickname = request.getParameter("update_nickname").trim();
		String password_check = request.getParameter("password_check").trim();
		
		if(update_nickname == null || update_nickname.equals("") ||
				password_check == null || password_check.equals("")) {
			model.addAttribute("msg", "닉네임 또는 비밀번호를 모두 입력하세요. <i class=\"fas fa-times\"></i>");
			return "updateNickname";
			
		} else if(!password.equals(password_check)){
			model.addAttribute("msg", "현제 비밀번호가 일치하지 않습니다. <i class=\"fas fa-times\"></i>");
			return "updateNickname";
			
		} else if (nickname.equals(update_nickname)) {
			model.addAttribute("msg", "현제 닉네임과 동일합니다. <i class=\"fas fa-times\"></i>");
			return "updateNickname";
		}
		
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("id", id);
		hmap.put("nickname", nickname);
		hmap.put("update_nickname", update_nickname);
		
		int count = mapper.selectNicknameCount(hmap);
		
		if(count > 0) {
			model.addAttribute("msg", "중복된 닉네임이 존재합니다. <i class=\"fas fa-times\"></i>");
			return "updateNickname";
		}
		
		mapper.updateContentNickname(hmap);
		mapper.updateCommentNickname(hmap);
	
		mapper.updateNickname(hmap);
		session.setAttribute("nickname", update_nickname);
		model.addAttribute("pass", "닉네임 변경이 완료 되었습니다.");
		
		return "updateNickname";
		
	}
	
	
}
