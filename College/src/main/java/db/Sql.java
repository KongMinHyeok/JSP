package db;

public class Sql {

	public static final String SELECT_LECTURE = "SELECT * FROM `lecture`";
	public static final String SELECT_REGISTER = "SELECT a.`regStdNo`, b.`stdName`, c.`lecName`, `regLecNo`, `regMidScore`, `regFinalScore`, `regTotalScore`, `regGrade` FROM `register` AS a "
												+ "JOIN `student` AS b ON a.regStdNo = b.stdNo "
												+ "JOIN `lecture` AS c ON a.regLecNo = c.lecno";
	public static final String SELECT_STUDENT = "SELECT * FROM `student`";
	
	
	public static final String INSERT_LECTURE = "INSERT INTO `lecture` (`lecno`, `lecName`, `lecCredit`, `lecTime`, `lecClass`) "
												+ "values (?, ?, ?, ?, ?)";
	public static final String INSERT_REGISTER = "INSERT INTO `register` (`regStdNo`, `StdName`, `lecName`, `regLecNo`) "
												+ "values (?, ?, ?, ?)";
	public static final String INSERT_STUDENT = "INSERT INTO `student` (`stdNo`, `stdName`, `stdHp`, `stdYear`, `stdAddress`) "
												+ "values (?, ?, ?, ?, ?)";
}
