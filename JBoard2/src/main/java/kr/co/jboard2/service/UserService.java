package kr.co.jboard2.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.jboard2.dao.UserDAO;
import kr.co.jboard2.dao.articleDAO;
import kr.co.jboard2.vo.ArticleVO;
import kr.co.jboard2.vo.UserVO;

public enum UserService {
	
	INSTANCE;
	private UserDAO udao = UserDAO.getInstance();

	public int selectUserForCheckPw(String pass) {
		return udao.selectUserForCheckPw(pass);
	}
	public int updateUserPassWord(String uid, String pass) {
		return udao.updateUserPassword(uid, pass);
	}
	
	public int updateUser(UserVO vo) {
		return udao.updateUser(vo);
	}
}
