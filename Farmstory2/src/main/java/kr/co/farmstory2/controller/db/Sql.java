package kr.co.farmstory2.controller.db;

public class Sql {

	public static final String SELECT_TERMS = "select * from `board_terms`";
	
	public static final String INSERT_USER = "select * from `board_user`";
	
	public static final String SELECT_COUNT_USER = "select count(`uid`) from `board_user`  where `uid`=?";
}
