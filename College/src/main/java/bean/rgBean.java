package bean;

public class rgBean {
	private String regStdNo;
	private int regLecNo;
	private int regMidScore; 
	private int regFinalScore;
	private int regTotalScore;
	private String regGrade;
	
	// 병합
	private String lecName;
	private String StdName;
	
	public void setLecName(String lecName) {
		this.lecName = lecName;
	}
	public String getLecName() {
		return lecName;
	}
	
	public void setStdName(String StdName) {
		this.StdName = StdName;
	}
	public String getStdName() {
		return StdName;
	}
	//병합 끝
	
	public String getRegStdNo() {
		return regStdNo;
	}
	public void setRegStdNo(String regStdNo) {
		this.regStdNo = regStdNo;
	}
	public int getRegLecNo() {
		return regLecNo;
	}
	public void setRegLecNo(int regLecNo) {
		this.regLecNo = regLecNo;
	}
	public int getRegMidScore() {
		return regMidScore;
	}
	public void setRegMidScore(int regMidScore) {
		this.regMidScore = regMidScore;
	}
	public int getRegFinalScore() {
		return regFinalScore;
	}
	public void setRegFinalScore(int regFinalScore) {
		this.regFinalScore = regFinalScore;
	}
	public int getRegTotalScore() {
		return regTotalScore;
	}
	public void setRegTotalScore(int regTotalScore) {
		this.regTotalScore = regTotalScore;
	}
	public String getRegGrade() {
		return regGrade;
	}
	public void setRegGrade(String regGrade) {
		this.regGrade = regGrade;
	}
	
	
}	
